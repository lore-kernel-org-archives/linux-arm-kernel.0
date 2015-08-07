From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 7 Aug 2015 23:34:24 +0200
Subject: [RFC PATCH v4 7/9] arm: lpc18xx_defconfig: remove
 CONFIG_MMC_DW_IDMAC
In-Reply-To: <1438843590-24101-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843590-24101-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <CAGhQ9VxkFk19HGtToUm8bOU62Z8S0_dMqciUiNfJry-Jb5YF=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2015 at 08:46, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Joachim Eastwood <manabian@gmail.com>

>  arch/arm/configs/lpc18xx_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
> index 1c47f86..b7e8cda 100644
> --- a/arch/arm/configs/lpc18xx_defconfig
> +++ b/arch/arm/configs/lpc18xx_defconfig
> @@ -119,7 +119,6 @@ CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_ROOT_HUB_TT=y
>  CONFIG_MMC=y
>  CONFIG_MMC_DW=y
> -CONFIG_MMC_DW_IDMAC=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_PCA9532=y
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
