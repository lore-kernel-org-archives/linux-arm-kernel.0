From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 25 Jun 2018 17:58:50 +0200
Subject: [PATCH v2 4/7] clk: sunxi-ng: add A64 compatible string
In-Reply-To: <20180622124540.56203-3-icenowy@aosc.io>
References: <20180622124540.56203-1-icenowy@aosc.io>
 <20180622124540.56203-3-icenowy@aosc.io>
Message-ID: <20180625155850.m4unvqyxc3aavrkv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 08:45:37PM +0800, Icenowy Zheng wrote:
> As claiming Allwinner A64 SRAM C is a prerequisite for all sub-blocks of
> the A64 DE2, not only the CCU sub-block, a bus driver is then written for
> enabling the access to the whole DE2 part by claiming the SRAM.
> 
> In this situation, the A64 compatible string will be just added with no
> other requirments, as they're processed by the parent bus driver.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> No changes since v1.
> 
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> index 468d1abaf0ee..8df7cd93453e 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> @@ -292,13 +292,10 @@ static const struct of_device_id sunxi_de2_clk_ids[] = {
>  		.compatible = "allwinner,sun50i-h5-de2-clk",
>  		.data = &sun50i_a64_de2_clk_desc,
>  	},
> -	/*
> -	 * The Allwinner A64 SoC needs some bit to be poke in syscon to make
> -	 * DE2 really working.
> -	 * So there's currently no A64 compatible here.
> -	 * H5 shares the same reset line with A64, so here H5 is using the
> -	 * clock description of A64.
> -	 */
> +	{
> +		.compatible = "allwinner,sun50i-a64-de2-clk",
> +		.data = &sun50i_a64_de2_clk_desc,
> +	},

This should be before the h5 (and possibly others?) compatible.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180625/0510cac7/attachment.sig>
