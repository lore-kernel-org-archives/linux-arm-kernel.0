From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 18 Jun 2012 16:13:46 +0400
Subject: [RFC PATCH v2 09/11] ARM: DT: Add support to system control module
 for OMAP4
In-Reply-To: <4FDF11D6.6050205@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <4FDF11D6.6050205@dev.rtsoft.ru>
Message-ID: <4FDF1B7A.6010608@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-06-2012 15:32, Konstantin Baydarov wrote:

> This patch adds device tree entries on OMAP4 based boards
> for System Control Module (SCM).

> TODO:
> The IOMEM windows of ctrl_module_core, bandgap, usbphy overlap, so
> probably only specific registers should be specified in dts for
> bandgap and usb phy entries.

> Signed-off-by: Konstantin Baydarov<kbaidarov@dev.rtsoft.ru>
> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
> ---
>   arch/arm/boot/dts/omap4.dtsi |   17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> Index: linux-2.6/arch/arm/boot/dts/omap4.dtsi
> ===================================================================
> --- linux-2.6.orig/arch/arm/boot/dts/omap4.dtsi
> +++ linux-2.6/arch/arm/boot/dts/omap4.dtsi
> @@ -272,5 +272,22 @@
>   			ti,hwmods = "mmc5";
>   			ti,needs-special-reset;
>   		};
> +
> +		ctrl_module_core: ctrl_module_core at 4a002000 {
> +			compatible = "ti,omap4-control";
> +			#address-cells =<1>;
> +			#size-cells =<1>;
> +			ranges;
> +			ti,hwmods = "ctrl_module_core";
> +			reg =<0x4a002000 0x1000>;
> +			bandgap at 4a002000 {
> +				compatible = "ti,omap4-bandgap";
> +				reg =<0x4a002000 0x1000>;
> +			};
> +			usb at 4a002000 {
> +				compatible = "ti,omap4-usb-phy";
> +				reg =<0x4a002000 0x1000>;

    Two devices at the same address? Also, shouldn't values in the "reg" 
property be relative to the value in the parent's "reg" property? Are they 
needed at all here?

WBR, Sergei
