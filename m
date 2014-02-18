From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Feb 2014 15:15:32 +0100
Subject: [PATCH v7 2/8] clk: sunxi: Implement MMC phase control
In-Reply-To: <20140217100221.15040.47203.stgit@pagira.o2s.ch>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100221.15040.47203.stgit@pagira.o2s.ch>
Message-ID: <20140218141532.GH3142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 17, 2014 at 11:02:21AM +0100, David Lanzend?rfer wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

You're missing your Signed-off-by here too.  Remember, for every patch
you send, your Signed-off-by must be there, regardless wether you're
the author or not.

A commit log would be very much welcome too.

Now, down to the patch itself, I remember Mike saying that he would
prefer adding a function in the framework instead of hardcoding
it. Mike, what's your feeling on this? Would merging this seem
reasonnable to you as is, or do you want to take this to the
framework?

> ---
>  drivers/clk/sunxi/clk-sunxi.c |   35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index abb6c5a..33b9977 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -377,6 +377,41 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
>  
>  
>  /**
> + * clk_sunxi_mmc_phase_control() - configures MMC clock phase control
> + */

If you don't go the framework road, some documentation on what are the
arguments it takes and what it's supposed to return would be great.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/267ca19e/attachment.sig>
