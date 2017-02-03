From: eric@anholt.net (Eric Anholt)
Date: Fri, 03 Feb 2017 09:26:14 -0800
Subject: [PATCH v2 4/8] arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig
In-Reply-To: <1486123913-31705-5-git-send-email-kraxel@redhat.com>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
 <1486123913-31705-5-git-send-email-kraxel@redhat.com>
Message-ID: <87inorp4nd.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> ---
>  arch/arm/configs/bcm2835_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> index 4b89f4e..3767c24 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -92,6 +92,7 @@ CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_IPROC=y
> +CONFIG_MMC_BCM2835=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y

If you end up resubmitting this, could you extend the commit message of
the defconfig changes to explain why it's being done?  Something like:

"We need to enable this controller so that we can switch the SD card's
pinmux over to it by default, which will improve storage read/write
speed."

(even better if we have some sort of stats on how much better it is).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170203/20099ee6/attachment.sig>
