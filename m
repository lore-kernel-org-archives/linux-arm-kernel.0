From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 24 Apr 2014 17:49:29 +0400
Subject: [PATCH 11/23] ARM: dts: omap5-uevm.dts: add tca6424a
In-Reply-To: <1398334639-14172-12-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-12-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <53591669.7060502@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 24-04-2014 14:17, Tomi Valkeinen wrote:

> omap5-uevm has a tca6424a I/O expander. Add it to the .dts file.

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/boot/dts/omap5-uevm.dts | 7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 3b99ec25b748..9e7581eaeb23 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -434,6 +434,13 @@
>   	pinctrl-0 = <&i2c5_pins>;
>
>   	clock-frequency = <400000>;
> +
> +	tca6424a: tca6424a at 22 {

    The ePAPR standard [1] says: "The name of a node should be somewhat generic,
reflecting the function of the device and not its precise programming model.
If appropriate, the name should be one of the following choices:
[...]
    - gpio;"

> +		compatible = "ti,tca6424";
> +		reg = <0x22>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
>   };

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
