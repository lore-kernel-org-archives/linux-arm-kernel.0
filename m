From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Nov 2016 11:57:25 +0100
Subject: [RFC PATCH 3/5] arm64: defconfig: sunxi: include options for
 Allwinner H5 SoC
In-Reply-To: <1479950235-26821-4-git-send-email-andre.przywara@arm.com>
References: <1479950235-26821-1-git-send-email-andre.przywara@arm.com>
 <1479950235-26821-4-git-send-email-andre.przywara@arm.com>
Message-ID: <20161124105725.va6gf6b3min74occ@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 01:17:13AM +0000, Andre Przywara wrote:
> The Allwinner H5 SoC is closely related to the H3 SoC, so select the
> basic pinctrl driver and the DMA driver to let a defconfig kernel boot
> on those boards.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/Kconfig.platforms | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index cfbdf02..8300677 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -5,8 +5,12 @@ config ARCH_SUNXI
>  	select GENERIC_IRQ_CHIP
>  	select PINCTRL
>  	select PINCTRL_SUN50I_A64
> +	select PINCTRL_SUN8I_H3
> +	select PINCTRL_SUN8I_H3_R
> +	select DMA_SUN6I

I'm not sure I want to get an ever growing select which will be an
union of all the drivers that all the arm64 Allwinner SoCs will
require.

Select leaves no option to disable that option, and we have defconfig
to deal with that nicely.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/00e005e3/attachment.sig>
