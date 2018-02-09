From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 9 Feb 2018 18:16:44 +0530
Subject: [PATCH v6 41/41] ARM: dts: da850: Add clocks
In-Reply-To: <1516468460-4908-42-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-42-git-send-email-david@lechnology.com>
Message-ID: <075d9f68-ad82-c8c0-c302-3b07162ecb2e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index c66cf78..7f4acd7 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -21,6 +21,36 @@
>  			#interrupt-cells = <1>;
>  			ti,intc-size = <101>;
>  			reg = <0xfffee000 0x2000>;
> +			clocks = <&psc0 6>;
> +		};
> +	};
> +	clocks: clocks {
> +		ref_clk: ref_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +			clock-output-names = "ref_clk";
> +		};

The ref_clk clock-frequency should rather be added in each board file
since its not fixed by the SoC. In general we dont want any SoC defined
properties to be overwritten by board files (except the status = property).

Thanks,
Sekhar
