From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 22 May 2014 16:48:16 +0400
Subject: [PATCH] ARM: socfpga: dts: add watchdog0+1
In-Reply-To: <1400753977-11620-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1400753977-11620-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <537DF210.50508@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-05-2014 14:19, Steffen Trumtrar wrote:

> The SoCFPGA has two watchdog timers. Add them to the dtsi.

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>   arch/arm/boot/dts/socfpga.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 56fc214..ee10fa6 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -549,6 +549,22 @@
[...]
> +		watchdog1: wd at ffd04000 {

    Oh, and the unit-address part of the name should match the "reg" property.

> +			compatible = "snps,dw-wdt";
> +			reg = <0xffd03000 0x1000>;
> +			interrupts = <0 172 0>;
> +			clocks = <&osc1>;
> +			status = "disabled";
> +		};
> +

WBR, Sergei
