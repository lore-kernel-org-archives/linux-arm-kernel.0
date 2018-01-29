From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jan 2018 10:21:45 +0100
Subject: [PATCH v2 02/16] arm: config: sunxi_defconfig: enable SUN4I_GPADC
In-Reply-To: <20180128232919.12639-3-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-3-embed3d@gmail.com>
Message-ID: <20180129092145.4pagdnfmhilwaj2r@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 29, 2018 at 12:29:05AM +0100, Philipp Rossak wrote:
> This commit enables the SUN4I_GPADC config option and
> sets the value to yes. This is needed to enable the ths sensors.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/configs/sunxi_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> index 5caaf971fb50..52c3990b9d91 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -131,6 +131,7 @@ CONFIG_DMA_SUN6I=y
>  CONFIG_EXTCON=y
>  CONFIG_IIO=y
>  CONFIG_AXP20X_ADC=y
> +CONFIG_SUN4I_GPADC=y

Unfortunately, we can't do that since TOUCHSCREEN_SUN4I is already
enabled and we have a depends on !TOUCHSCREEN_SUN4I.

One more reason to stop worrying about replacing that driver DT
binding.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/5e8fd0c5/attachment.sig>
