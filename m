From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 4 Oct 2016 12:40:11 +0200
Subject: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
In-Reply-To: <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
Message-ID: <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  4 Oct 2016 11:46:14 +0200
Myl?ne Josserand <mylene.josserand@free-electrons.com> wrote:

> Add the case of a burst of 4 which is handled by the SoC.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  drivers/dma/sun6i-dma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 8346199..0485204 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
>  	switch (maxburst) {
>  	case 1:
>  		return 0;
> +	case 4:
> +		return 1;
>  	case 8:
>  		return 2;
>  	default:
> -- 
> 2.9.3

This patch has already been rejected by Maxime in the threads
	http://www.spinics.net/lists/dmaengine/msg08610.html
and
	http://www.spinics.net/lists/dmaengine/msg08719.html

I hope you will find the way he wants for this maxburst to be added.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
