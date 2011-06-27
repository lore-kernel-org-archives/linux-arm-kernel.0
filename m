From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Jun 2011 11:52:29 +0200
Subject: [PATCH 1/1] MXC: iomux-v3: correct NO_PAD_CTRL definition
In-Reply-To: <1308937976-18638-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1308937976-18638-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20110627095229.GB6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lothar,

Since you had comments to an earlier version, can I have your Acked-by
for this?

Sascha

On Fri, Jun 24, 2011 at 10:52:56AM -0700, Troy Kisky wrote:
> iomux-v3.c uses NO_PAD_CTRL as a 32 bit value
> so it should not be shifted left by MUX_PAD_CTRL_SHIFT(41)
> 
> Previously, anything requesting NO_PAD_CTRL would get
> their pad control register set to 0.
> 
> Since it is a pad control mask, place it with the other mask values.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-v3.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> index 82620af..ebbce33 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> @@ -66,7 +66,6 @@ typedef u64 iomux_v3_cfg_t;
>  #define MUX_MODE_MASK		((iomux_v3_cfg_t)0x1f << MUX_MODE_SHIFT)
>  #define MUX_PAD_CTRL_SHIFT	41
>  #define MUX_PAD_CTRL_MASK	((iomux_v3_cfg_t)0x1ffff << MUX_PAD_CTRL_SHIFT)
> -#define NO_PAD_CTRL		((iomux_v3_cfg_t)1 << (MUX_PAD_CTRL_SHIFT + 16))
>  #define MUX_SEL_INPUT_SHIFT	58
>  #define MUX_SEL_INPUT_MASK	((iomux_v3_cfg_t)0xf << MUX_SEL_INPUT_SHIFT)
>  
> @@ -85,6 +84,7 @@ typedef u64 iomux_v3_cfg_t;
>   * Use to set PAD control
>   */
>  
> +#define NO_PAD_CTRL			(1 << 16)
>  #define PAD_CTL_DVS			(1 << 13)
>  #define PAD_CTL_HYS			(1 << 8)
>  
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
