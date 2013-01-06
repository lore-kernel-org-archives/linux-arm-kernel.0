From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 6 Jan 2013 10:03:13 +0100
Subject: [PATCH 4/4] arm: mvebu: indentation fixes for Armada 370/XP
 .dtsi files
In-Reply-To: <1357315498-4570-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357315498-4570-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130106090313.GP17242@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 05:04:58PM +0100, Thomas Petazzoni wrote:
> The Armada 370 and Armada XP .dtsi files contained a mix of
> space-based and tabulation-based indentation, with not even the same
> width. This commit homogenize the indentation by using tabs everywhere
> and making the indentation level match the DT information level.
> 
> The only non-whitespace change in this patch is the addition of a
> semi-colon at the end of the cpus { }; section in
> armada-xp-mv78230.dtsi.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> This is a fix for 3.8, should be pushed for some 3.8-rc.

Hi Thomas

White space changes are not fixes, so should not really be submitted
for 3.8-rc. Lets commit these as cleanup in 3.9.

I will however create and submit a patch to add the missing ;

Thanks
	Andrew

> ---
>  arch/arm/boot/dts/armada-370.dtsi        |    8 ++--
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi |   30 +++++++--------
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi |   38 +++++++++---------
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi |   62 +++++++++++++++---------------
>  arch/arm/boot/dts/armada-xp.dtsi         |   44 ++++++++++-----------
>  5 files changed, 91 insertions(+), 91 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 636cf7d..a5c447d 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -34,14 +34,14 @@
>  	};
>  
>  	mpic: interrupt-controller at d0020000 {
> -	      reg = <0xd0020a00 0x1d0>,
> -		    <0xd0021870 0x58>;
> +		reg = <0xd0020a00 0x1d0>,
> +		      <0xd0021870 0x58>;
>  	};
>  
>  	soc {
>  		system-controller at d0018200 {
> -				compatible = "marvell,armada-370-xp-system-controller";
> -				reg = <0xd0018200 0x100>;
> +			compatible = "marvell,armada-370-xp-system-controller";
> +			reg = <0xd0018200 0x100>;
>  		};
>  
>  		pinctrl {
> diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> index 8f90fac..dff3750 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> @@ -25,23 +25,23 @@
>  	};
>  
>  	cpus {
> -	    #address-cells = <1>;
> -	    #size-cells = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  
> -	    cpu at 0 {
> -		device_type = "cpu";
> -		compatible = "marvell,sheeva-v7";
> -		reg = <0>;
> -		clocks = <&cpuclk 0>;
> -	    };
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "marvell,sheeva-v7";
> +			reg = <0>;
> +			clocks = <&cpuclk 0>;
> +		};
>  
> -	    cpu at 1 {
> -		device_type = "cpu";
> -		compatible = "marvell,sheeva-v7";
> -		reg = <1>;
> -		clocks = <&cpuclk 1>;
> -	    };
> -	}
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "marvell,sheeva-v7";
> +			reg = <1>;
> +			clocks = <&cpuclk 1>;
> +		};
> +	};
>  
>  	soc {
>  		pinctrl {
> diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> index 1c1937d..10511e6 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> @@ -26,22 +26,22 @@
>  	};
>  
>  	cpus {
> -	    #address-cells = <1>;
> -	    #size-cells = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  
> -	    cpu at 0 {
> -		device_type = "cpu";
> -		compatible = "marvell,sheeva-v7";
> -		reg = <0>;
> -		clocks = <&cpuclk 0>;
> -	    };
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "marvell,sheeva-v7";
> +			reg = <0>;
> +			clocks = <&cpuclk 0>;
> +		};
>  
> -	    cpu at 1 {
> -		device_type = "cpu";
> -		compatible = "marvell,sheeva-v7";
> -		reg = <1>;
> -		clocks = <&cpuclk 1>;
> -	    };
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "marvell,sheeva-v7";
> +			reg = <1>;
> +			clocks = <&cpuclk 1>;
> +		};
>  	};
>  
>  	soc {
> @@ -87,11 +87,11 @@
>  		};
>  
>  		ethernet at d0034000 {
> -				compatible = "marvell,armada-370-neta";
> -				reg = <0xd0034000 0x2500>;
> -				interrupts = <14>;
> -				clocks = <&gateclk 1>;
> -				status = "disabled";
> +			compatible = "marvell,armada-370-neta";
> +			reg = <0xd0034000 0x2500>;
> +			interrupts = <14>;
> +			clocks = <&gateclk 1>;
> +			status = "disabled";
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> index 4905cf3..c76a18b 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> @@ -27,36 +27,36 @@
>  
>  
>  	cpus {
> -	    #address-cells = <1>;
> -	    #size-cells = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  
> -	    cpu at 0 {
> -		device_type = "cpu";
> -		compatible = "marvell,sheeva-v7";
> -		reg = <0>;
> -		clocks = <&cpuclk 0>;
> -	    };
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "marvell,sheeva-v7";
> +			reg = <0>;
> +			clocks = <&cpuclk 0>;
> +		};
>  
> -	    cpu at 1 {
> -		device_type = "cpu";
> -		compatible = "marvell,sheeva-v7";
> -		reg = <1>;
> -		clocks = <&cpuclk 1>;
> -	    };
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "marvell,sheeva-v7";
> +			reg = <1>;
> +			clocks = <&cpuclk 1>;
> +		};
>  
> -	    cpu at 2 {
> -		device_type = "cpu";
> -		compatible = "marvell,sheeva-v7";
> -		reg = <2>;
> -		clocks = <&cpuclk 2>;
> -	    };
> +		cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "marvell,sheeva-v7";
> +			reg = <2>;
> +			clocks = <&cpuclk 2>;
> +		};
>  
> -	    cpu at 3 {
> -		device_type = "cpu";
> -		compatible = "marvell,sheeva-v7";
> -		reg = <3>;
> -		clocks = <&cpuclk 3>;
> -	    };
> +		cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "marvell,sheeva-v7";
> +			reg = <3>;
> +			clocks = <&cpuclk 3>;
> +		};
>  	};
>  
>  	soc {
> @@ -102,11 +102,11 @@
>  		};
>  
>  		ethernet at d0034000 {
> -				compatible = "marvell,armada-370-neta";
> -				reg = <0xd0034000 0x2500>;
> -				interrupts = <14>;
> -				clocks = <&gateclk 1>;
> -				status = "disabled";
> +			compatible = "marvell,armada-370-neta";
> +			reg = <0xd0034000 0x2500>;
> +			interrupts = <14>;
> +			clocks = <&gateclk 1>;
> +			status = "disabled";
>  		};
>  	};
>   };
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 390ba98..95d43ec 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -30,8 +30,8 @@
>  	};
>  
>  	mpic: interrupt-controller at d0020000 {
> -	      reg = <0xd0020a00 0x2d0>,
> -		    <0xd0021070 0x58>;
> +		reg = <0xd0020a00 0x2d0>,
> +		      <0xd0021070 0x58>;
>  	};
>  
>  	armada-370-xp-pmsu at d0022000 {
> @@ -42,24 +42,24 @@
>  
>  	soc {
>  		serial at d0012200 {
> -				compatible = "snps,dw-apb-uart";
> -				reg = <0xd0012200 0x100>;
> -				reg-shift = <2>;
> -				interrupts = <43>;
> -				reg-io-width = <4>;
> -				status = "disabled";
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0xd0012200 0x100>;
> +			reg-shift = <2>;
> +			interrupts = <43>;
> +			reg-io-width = <4>;
> +			status = "disabled";
>  		};
>  		serial at d0012300 {
> -				compatible = "snps,dw-apb-uart";
> -				reg = <0xd0012300 0x100>;
> -				reg-shift = <2>;
> -				interrupts = <44>;
> -				reg-io-width = <4>;
> -				status = "disabled";
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0xd0012300 0x100>;
> +			reg-shift = <2>;
> +			interrupts = <44>;
> +			reg-io-width = <4>;
> +			status = "disabled";
>  		};
>  
>  		timer at d0020300 {
> -				marvell,timer-25Mhz;
> +			marvell,timer-25Mhz;
>  		};
>  
>  		coreclk: mvebu-sar at d0018230 {
> @@ -83,16 +83,16 @@
>  		};
>  
>  		system-controller at d0018200 {
> -				compatible = "marvell,armada-370-xp-system-controller";
> -				reg = <0xd0018200 0x500>;
> +			compatible = "marvell,armada-370-xp-system-controller";
> +			reg = <0xd0018200 0x500>;
>  		};
>  
>  		ethernet at d0030000 {
> -				compatible = "marvell,armada-370-neta";
> -				reg = <0xd0030000 0x2500>;
> -				interrupts = <12>;
> -				clocks = <&gateclk 2>;
> -				status = "disabled";
> +			compatible = "marvell,armada-370-neta";
> +			reg = <0xd0030000 0x2500>;
> +			interrupts = <12>;
> +			clocks = <&gateclk 2>;
> +			status = "disabled";
>  		};
>  
>  		xor at d0060900 {
> -- 
> 1.7.9.5
> 
