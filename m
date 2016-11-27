From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 27 Nov 2016 19:57:00 +0100
Subject: [PATCH] ARM: dts: mvebu: Add Armada 38x labels and clean up
 Turris Omnia
In-Reply-To: <1480272700-28888-1-git-send-email-afaerber@suse.de>
References: <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
 <1480272700-28888-1-git-send-email-afaerber@suse.de>
Message-ID: <e7cdf277-2d16-2f10-4e53-a0f15e32a4ab@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.11.2016 um 19:51 schrieb Andreas F?rber:
> To more consistently reference nodes by label, add labels for sata,
> usb2, sdhci and usb3 nodes.

s/usb2/usb/ to be fully correct.

> 
> Convert all other 38x boards for consistency. Add labels for nfc and rtc.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm/boot/dts/armada-385-db-ap.dts             | 334 +++++++------
>  arch/arm/boot/dts/armada-385-linksys-caiman.dts    |  98 ++--
>  arch/arm/boot/dts/armada-385-linksys-cobra.dts     |  98 ++--
>  arch/arm/boot/dts/armada-385-linksys.dtsi          | 294 ++++++-----
>  arch/arm/boot/dts/armada-385-turris-omnia.dts      |  97 ++--
>  arch/arm/boot/dts/armada-385.dtsi                  |  20 +-
>  arch/arm/boot/dts/armada-388-clearfog.dts          | 550 ++++++++++-----------
>  arch/arm/boot/dts/armada-388-db.dts                | 236 ++++-----
>  arch/arm/boot/dts/armada-388-gp.dts                | 403 ++++++++-------
>  arch/arm/boot/dts/armada-388-rd.dts                | 115 +++--
>  arch/arm/boot/dts/armada-388.dtsi                  |  19 +-
>  .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 111 ++---
>  arch/arm/boot/dts/armada-38x.dtsi                  |  16 +-
>  13 files changed, 1170 insertions(+), 1221 deletions(-)
[...]
> diff --git a/arch/arm/boot/dts/armada-388.dtsi b/arch/arm/boot/dts/armada-388.dtsi
> index 564fa59..1a7fc5d 100644
> --- a/arch/arm/boot/dts/armada-388.dtsi
> +++ b/arch/arm/boot/dts/armada-388.dtsi
> @@ -50,21 +50,8 @@
>  	model = "Marvell Armada 388 family SoC";
>  	compatible = "marvell,armada388", "marvell,armada385",
>  		"marvell,armada380";
> +};
>  
> -	soc {
> -		internal-regs {
> -			pinctrl at 18000 {
> -				compatible = "marvell,mv88f6828-pinctrl";
> -			};
> -
> -			sata at e0000 {
> -				compatible = "marvell,armada-380-ahci";
> -				reg = <0xe0000 0x2000>;
> -				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&gateclk 30>;
> -				status = "disabled";
> -			};

Note that this sata node is redundant with armada-38x.dtsi by my
reading, therefore dropped.

> -
> -		};
> -	};
> +&pinctrl {
> +	compatible = "marvell,mv88f6828-pinctrl";
>  };

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
