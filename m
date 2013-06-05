From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Wed, 05 Jun 2013 17:29:52 +0900
Subject: [PATCH 01/05] ARM: shmobile: r8a73a4 SMP prototype v1 (CA15 x 4)
In-Reply-To: <20130530085201.24374.97084.sendpatchset@w520>
References: <20130530085152.24374.64208.sendpatchset@w520>
 <20130530085201.24374.97084.sendpatchset@w520>
Message-ID: <51AEF700.7010003@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On 5/30/2013 5:52 PM, Magnus Damm wrote:
> --- 0003/arch/arm/boot/dts/r8a73a4.dtsi
> +++ work/arch/arm/boot/dts/r8a73a4.dtsi	2013-05-22 13:21:21.000000000 +0900
> @@ -25,6 +25,27 @@
>  			reg = <0>;
>  			clock-frequency = <1500000000>;
>  		};
> +
> +		cpu1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <1>;
> +			clock-frequency = <1500000000>;
> +		};
> +
> +		cpu2: cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <2>;
> +			clock-frequency = <1500000000>;
> +		};
> +
> +		cpu3: cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <3>;
> +			clock-frequency = <1500000000>;
> +		};
>  	};

The frequency of the EXTAL on APE6EVM machine is 26MHz, and the Generic
Timers are clocked at EXTAL x1/2 (=13MHz).  Do not copy-and-paste wrong
clock-frequency properties currently we have, but fix cpu0 along with
adding cpu1..3, please.

Furthermore you don't have (should not) to use clock-frequency property
if you set up CNTFRQ to an appropriate value one by one in PATCH 05/05.
--
Shinya Kuribayashi
Renesas Electronics
