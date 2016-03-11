From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Mar 2016 13:06:01 +0100
Subject: [PATCH v2 3/5] dmaengine: sun6i: Add 4 as a possible burst value
In-Reply-To: <7898ac737e1cce9542de662f1266d94bd451659e.1457695169.git.moinejf@free.fr>
References: <cover.1457695169.git.moinejf@free.fr>
 <7898ac737e1cce9542de662f1266d94bd451659e.1457695169.git.moinejf@free.fr>
Message-ID: <20160311120601.GD8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 12:01:29PM +0100, Jean-Francois Moine wrote:
> Some DMA transfers, as for H3 audio, ask for 4 as a burst value.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/dma/sun6i-dma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 3579ee7..7c98c0d 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -238,6 +238,8 @@ static inline s8 convert_burst(u32 maxburst)
>  	switch (maxburst) {
>  	case 1:
>  		return 0;
> +	case 4:
> +		return 1;

This is true only for the H3.

For the other SoCs that we support, the only valid values are 0 and 2,
so we need to reject those values.

We should do that based on the compatible.

The easiest solution would be to expose the available burst sizes in
the probe, and just our new one if we match that compatible, and any
invalid burst size would be rejected by the framework. Vinod, any
objection to that?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/7c32487f/attachment.sig>
