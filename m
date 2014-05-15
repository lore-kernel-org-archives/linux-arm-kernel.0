From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 15 May 2014 17:26:36 +0400
Subject: [PATCH v6 17/17] ARM: mvebu: add Device Tree description of the
 EHCI controller on Armada 375
In-Reply-To: <1400149062-32661-18-git-send-email-gregory.clement@free-electrons.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
 <1400149062-32661-18-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <5374C08C.7040700@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/15/2014 02:17 PM, Gregory CLEMENT wrote:

> The Marvell Armada 375 SoCs contains one EHCI controller. This commit

    However, you're adding two. :-)

> adds the Device Tree description of this interfaces at the SoC level,
> and also enables the USB2 port on the Armada 375 DB platform.

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   arch/arm/boot/dts/armada-375-db.dts |  4 ++++
>   arch/arm/boot/dts/armada-375.dtsi   | 16 ++++++++++++++++
>   2 files changed, 20 insertions(+)

[...]

> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index 7b303ecc2490..53baeb2f1fe8 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -320,6 +320,22 @@
>   				clocks = <&coreclk 0>;
>   			};
>
> +			usb at 50000 {
> +				compatible = "marvell,orion-ehci";
> +				reg = <0x50000 0x500>;
> +				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gateclk 18>;
> +				status = "disabled";
> +			};
> +
> +			usb at 54000 {
> +				compatible = "marvell,orion-ehci";
> +				reg = <0x54000 0x500>;
> +				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gateclk 26>;
> +				status = "disabled";
> +			};
> +
>   			usb3 at 58000 {
>   				compatible = "marvell,armada-375-xhci";
>   				reg = <0x58000 0x20000>,<0x5b880 0x80>;
>

WBR, Sergei
