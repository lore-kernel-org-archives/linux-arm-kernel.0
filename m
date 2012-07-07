From: robherring2@gmail.com (Rob Herring)
Date: Sat, 07 Jul 2012 14:37:12 -0500
Subject: [PATCH 1/3] ARM: dts: dove: Add devicetree descriptors
In-Reply-To: <1341318868-24567-3-git-send-email-sebastian.hesselbarth@googlemail.com>
References: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
 <1341318868-24567-3-git-send-email-sebastian.hesselbarth@googlemail.com>
Message-ID: <4FF88FE8.5060708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2012 07:34 AM, Sebastian Hesselbarth wrote:
> This adds devicetree descriptors for Marvell Dove and currently
> supported boards. 

[snip]

> --- /dev/null
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -0,0 +1,55 @@
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	compatible = "mrvl,dove";
> +
> +	ocp at f1000000 {
> +		compatible = "simple-bus";
> +		ranges = <0 0xf1000000 0x8000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		serial at 12000 {
> +			compatible = "ns16550a";
> +			reg = <0x12000 0x100>;
> +			reg-shift = <2>;
> +			interrupts = <7>;

This requires having an interrupt parent node which is missing. Since
the parent defines the number of cells that needs to be done first.

Rob

> +			clock-frequency = <166666667>;
> +			status = "disabled";
> +		};
> +
> +		serial at 12100 {
> +			compatible = "ns16550a";
> +			reg = <0x12100 0x100>;
> +			reg-shift = <2>;
> +			interrupts = <8>;
> +			clock-frequency = <166666667>;
> +			status = "disabled";
> +		};
> +
> +		serial at 12200 {
> +			compatible = "ns16550a";
> +			reg = <0x12200 0x100>;
> +			reg-shift = <2>;
> +			interrupts = <9>;
> +			clock-frequency = <166666667>;
> +			status = "disabled";
> +		};
> +
> +		serial at 12300 {
> +			compatible = "ns16550a";
> +			reg = <0x12300 0x100>;
> +			reg-shift = <2>;
> +			interrupts = <10>;
> +			clock-frequency = <166666667>;
> +			status = "disabled";
> +		};
> +
> +		rtc at d8500 {
> +			compatible = "mrvl,dove-rtc", "mrvl,orion-rtc";
> +			reg = <0xd8500 0x20>;
> +			interrupts = <133>;
> +		};
> +
> +	};
> +};
> 
