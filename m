From: liviu.dudau@arm.com (Liviu Dudau)
Date: Wed, 19 Apr 2017 11:07:25 +0100
Subject: [PATCH] ARM: dts: vexpress: fix few unit address format warnings
In-Reply-To: <1492537507-7783-1-git-send-email-sudeep.holla@arm.com>
References: <1492537507-7783-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20170419100725.GH10078@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 06:45:07PM +0100, Sudeep Holla wrote:
> This patch fixes the following set of warnings on vexpress platforms:
> 
>  sysreg at 010000 simple-bus unit address format error, expected "10000"
>  sysctl at 020000 simple-bus unit address format error, expected "20000"
>  i2c at 030000 simple-bus unit address format error, expected "30000"
>  aaci at 040000 simple-bus unit address format error, expected "40000"
>  mmci at 050000 simple-bus unit address format error, expected "50000"
>  kmi at 060000 simple-bus unit address format error, expected "60000"
>  kmi at 070000 simple-bus unit address format error, expected "70000"
>  uart at 090000 simple-bus unit address format error, expected "90000"
>  uart at 0a0000 simple-bus unit address format error, expected "a0000"
>  uart at 0b0000 simple-bus unit address format error, expected "b0000"
>  uart at 0c0000 simple-bus unit address format error, expected "c0000"
>  wdt at 0f0000 simple-bus unit address format error, expected "f0000"
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi     | 24 ++++++++++++------------
>  arch/arm/boot/dts/vexpress-v2m.dtsi         | 24 ++++++++++++------------
>  arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |  2 +-
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  | 18 +++++++++---------
>  arch/arm/boot/dts/vexpress-v2p-ca5s.dts     |  2 +-
>  arch/arm/boot/dts/vexpress-v2p-ca9.dts      |  2 +-
>  6 files changed, 36 insertions(+), 36 deletions(-)
> 
> Hi,
> 
> I observed few warning in linux-next due to the enhanced DTC checks
> introduced with DTC upgrade in linux-next. The patch fixes few warnings

All changes look sensible to me in order to fix the warnings, but I feel like
letting out a minor rant from me: the fact that DTC now complains about leading
zeros in what is usually a numeric field is silly. I find it easier to parse numbers
that have the same width. Also, now the reg property doesn't match the @<number>
part if you grep for it.

Best regards,
Liviu

> 
> Regards,
> Sudeep
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> index 3086efacd00e..35714ff6f467 100644
> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> @@ -71,7 +71,7 @@
>  			#size-cells = <1>;
>  			ranges = <0 3 0 0x200000>;
> 
> -			v2m_sysreg: sysreg at 010000 {
> +			v2m_sysreg: sysreg at 10000 {
>  				compatible = "arm,vexpress-sysreg";
>  				reg = <0x010000 0x1000>;
> 
> @@ -94,7 +94,7 @@
>  				};
>  			};
> 
> -			v2m_sysctl: sysctl at 020000 {
> +			v2m_sysctl: sysctl at 20000 {
>  				compatible = "arm,sp810", "arm,primecell";
>  				reg = <0x020000 0x1000>;
>  				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&smbclk>;
> @@ -106,7 +106,7 @@
>  			};
> 
>  			/* PCI-E I2C bus */
> -			v2m_i2c_pcie: i2c at 030000 {
> +			v2m_i2c_pcie: i2c at 30000 {
>  				compatible = "arm,versatile-i2c";
>  				reg = <0x030000 0x1000>;
> 
> @@ -119,7 +119,7 @@
>  				};
>  			};
> 
> -			aaci at 040000 {
> +			aaci at 40000 {
>  				compatible = "arm,pl041", "arm,primecell";
>  				reg = <0x040000 0x1000>;
>  				interrupts = <11>;
> @@ -127,7 +127,7 @@
>  				clock-names = "apb_pclk";
>  			};
> 
> -			mmci at 050000 {
> +			mmci at 50000 {
>  				compatible = "arm,pl180", "arm,primecell";
>  				reg = <0x050000 0x1000>;
>  				interrupts = <9 10>;
> @@ -139,7 +139,7 @@
>  				clock-names = "mclk", "apb_pclk";
>  			};
> 
> -			kmi at 060000 {
> +			kmi at 60000 {
>  				compatible = "arm,pl050", "arm,primecell";
>  				reg = <0x060000 0x1000>;
>  				interrupts = <12>;
> @@ -147,7 +147,7 @@
>  				clock-names = "KMIREFCLK", "apb_pclk";
>  			};
> 
> -			kmi at 070000 {
> +			kmi at 70000 {
>  				compatible = "arm,pl050", "arm,primecell";
>  				reg = <0x070000 0x1000>;
>  				interrupts = <13>;
> @@ -155,7 +155,7 @@
>  				clock-names = "KMIREFCLK", "apb_pclk";
>  			};
> 
> -			v2m_serial0: uart at 090000 {
> +			v2m_serial0: uart at 90000 {
>  				compatible = "arm,pl011", "arm,primecell";
>  				reg = <0x090000 0x1000>;
>  				interrupts = <5>;
> @@ -163,7 +163,7 @@
>  				clock-names = "uartclk", "apb_pclk";
>  			};
> 
> -			v2m_serial1: uart at 0a0000 {
> +			v2m_serial1: uart at a0000 {
>  				compatible = "arm,pl011", "arm,primecell";
>  				reg = <0x0a0000 0x1000>;
>  				interrupts = <6>;
> @@ -171,7 +171,7 @@
>  				clock-names = "uartclk", "apb_pclk";
>  			};
> 
> -			v2m_serial2: uart at 0b0000 {
> +			v2m_serial2: uart at b0000 {
>  				compatible = "arm,pl011", "arm,primecell";
>  				reg = <0x0b0000 0x1000>;
>  				interrupts = <7>;
> @@ -179,7 +179,7 @@
>  				clock-names = "uartclk", "apb_pclk";
>  			};
> 
> -			v2m_serial3: uart at 0c0000 {
> +			v2m_serial3: uart at c0000 {
>  				compatible = "arm,pl011", "arm,primecell";
>  				reg = <0x0c0000 0x1000>;
>  				interrupts = <8>;
> @@ -187,7 +187,7 @@
>  				clock-names = "uartclk", "apb_pclk";
>  			};
> 
> -			wdt at 0f0000 {
> +			wdt at f0000 {
>  				compatible = "arm,sp805", "arm,primecell";
>  				reg = <0x0f0000 0x1000>;
>  				interrupts = <0>;
> diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
> index c6393d3f1719..1b6f6393be93 100644
> --- a/arch/arm/boot/dts/vexpress-v2m.dtsi
> +++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
> @@ -70,7 +70,7 @@
>  			#size-cells = <1>;
>  			ranges = <0 7 0 0x20000>;
> 
> -			v2m_sysreg: sysreg at 00000 {
> +			v2m_sysreg: sysreg at 0 {
>  				compatible = "arm,vexpress-sysreg";
>  				reg = <0x00000 0x1000>;
> 
> @@ -93,7 +93,7 @@
>  				};
>  			};
> 
> -			v2m_sysctl: sysctl at 01000 {
> +			v2m_sysctl: sysctl at 1000 {
>  				compatible = "arm,sp810", "arm,primecell";
>  				reg = <0x01000 0x1000>;
>  				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&smbclk>;
> @@ -105,7 +105,7 @@
>  			};
> 
>  			/* PCI-E I2C bus */
> -			v2m_i2c_pcie: i2c at 02000 {
> +			v2m_i2c_pcie: i2c at 2000 {
>  				compatible = "arm,versatile-i2c";
>  				reg = <0x02000 0x1000>;
> 
> @@ -118,7 +118,7 @@
>  				};
>  			};
> 
> -			aaci at 04000 {
> +			aaci at 4000 {
>  				compatible = "arm,pl041", "arm,primecell";
>  				reg = <0x04000 0x1000>;
>  				interrupts = <11>;
> @@ -126,7 +126,7 @@
>  				clock-names = "apb_pclk";
>  			};
> 
> -			mmci at 05000 {
> +			mmci at 5000 {
>  				compatible = "arm,pl180", "arm,primecell";
>  				reg = <0x05000 0x1000>;
>  				interrupts = <9 10>;
> @@ -138,7 +138,7 @@
>  				clock-names = "mclk", "apb_pclk";
>  			};
> 
> -			kmi at 06000 {
> +			kmi at 6000 {
>  				compatible = "arm,pl050", "arm,primecell";
>  				reg = <0x06000 0x1000>;
>  				interrupts = <12>;
> @@ -146,7 +146,7 @@
>  				clock-names = "KMIREFCLK", "apb_pclk";
>  			};
> 
> -			kmi at 07000 {
> +			kmi at 7000 {
>  				compatible = "arm,pl050", "arm,primecell";
>  				reg = <0x07000 0x1000>;
>  				interrupts = <13>;
> @@ -154,7 +154,7 @@
>  				clock-names = "KMIREFCLK", "apb_pclk";
>  			};
> 
> -			v2m_serial0: uart at 09000 {
> +			v2m_serial0: uart at 9000 {
>  				compatible = "arm,pl011", "arm,primecell";
>  				reg = <0x09000 0x1000>;
>  				interrupts = <5>;
> @@ -162,7 +162,7 @@
>  				clock-names = "uartclk", "apb_pclk";
>  			};
> 
> -			v2m_serial1: uart at 0a000 {
> +			v2m_serial1: uart at a000 {
>  				compatible = "arm,pl011", "arm,primecell";
>  				reg = <0x0a000 0x1000>;
>  				interrupts = <6>;
> @@ -170,7 +170,7 @@
>  				clock-names = "uartclk", "apb_pclk";
>  			};
> 
> -			v2m_serial2: uart at 0b000 {
> +			v2m_serial2: uart at b000 {
>  				compatible = "arm,pl011", "arm,primecell";
>  				reg = <0x0b000 0x1000>;
>  				interrupts = <7>;
> @@ -178,7 +178,7 @@
>  				clock-names = "uartclk", "apb_pclk";
>  			};
> 
> -			v2m_serial3: uart at 0c000 {
> +			v2m_serial3: uart at c000 {
>  				compatible = "arm,pl011", "arm,primecell";
>  				reg = <0x0c000 0x1000>;
>  				interrupts = <8>;
> @@ -186,7 +186,7 @@
>  				clock-names = "uartclk", "apb_pclk";
>  			};
> 
> -			wdt at 0f000 {
> +			wdt at f000 {
>  				compatible = "arm,sp805", "arm,primecell";
>  				reg = <0x0f000 0x1000>;
>  				interrupts = <0>;
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> index 15f4fd3f4695..0c8de0ca73ee 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> @@ -220,7 +220,7 @@
>  		};
>  	};
> 
> -	smb at 08000000 {
> +	smb at 8000000 {
>  		compatible = "simple-bus";
> 
>  		#address-cells = <2>;
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> index bd107c5a0226..65ecf206388c 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -385,7 +385,7 @@
>  		};
>  	};
> 
> -	etb at 0,20010000 {
> +	etb at 20010000 {
>  		compatible = "arm,coresight-etb10", "arm,primecell";
>  		reg = <0 0x20010000 0 0x1000>;
> 
> @@ -399,7 +399,7 @@
>  		};
>  	};
> 
> -	tpiu at 0,20030000 {
> +	tpiu at 20030000 {
>  		compatible = "arm,coresight-tpiu", "arm,primecell";
>  		reg = <0 0x20030000 0 0x1000>;
> 
> @@ -449,7 +449,7 @@
>  		};
>  	};
> 
> -	funnel at 0,20040000 {
> +	funnel at 20040000 {
>  		compatible = "arm,coresight-funnel", "arm,primecell";
>  		reg = <0 0x20040000 0 0x1000>;
> 
> @@ -513,7 +513,7 @@
>  		};
>  	};
> 
> -	ptm at 0,2201c000 {
> +	ptm at 2201c000 {
>  		compatible = "arm,coresight-etm3x", "arm,primecell";
>  		reg = <0 0x2201c000 0 0x1000>;
> 
> @@ -527,7 +527,7 @@
>  		};
>  	};
> 
> -	ptm at 0,2201d000 {
> +	ptm at 2201d000 {
>  		compatible = "arm,coresight-etm3x", "arm,primecell";
>  		reg = <0 0x2201d000 0 0x1000>;
> 
> @@ -541,7 +541,7 @@
>  		};
>  	};
> 
> -	etm at 0,2203c000 {
> +	etm at 2203c000 {
>  		compatible = "arm,coresight-etm3x", "arm,primecell";
>  		reg = <0 0x2203c000 0 0x1000>;
> 
> @@ -555,7 +555,7 @@
>  		};
>  	};
> 
> -	etm at 0,2203d000 {
> +	etm at 2203d000 {
>  		compatible = "arm,coresight-etm3x", "arm,primecell";
>  		reg = <0 0x2203d000 0 0x1000>;
> 
> @@ -569,7 +569,7 @@
>  		};
>  	};
> 
> -	etm at 0,2203e000 {
> +	etm at 2203e000 {
>  		compatible = "arm,coresight-etm3x", "arm,primecell";
>  		reg = <0 0x2203e000 0 0x1000>;
> 
> @@ -583,7 +583,7 @@
>  		};
>  	};
> 
> -	smb at 08000000 {
> +	smb at 8000000 {
>  		compatible = "simple-bus";
> 
>  		#address-cells = <2>;
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> index 1acecaf4b13d..6e69b8e6c1a7 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> @@ -190,7 +190,7 @@
>  		};
>  	};
> 
> -	smb at 08000000 {
> +	smb at 8000000 {
>  		compatible = "simple-bus";
> 
>  		#address-cells = <2>;
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> index b608a03ee02f..c9305b58afc2 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> @@ -300,7 +300,7 @@
>  		};
>  	};
> 
> -	smb at 04000000 {
> +	smb at 4000000 {
>  		compatible = "simple-bus";
> 
>  		#address-cells = <2>;
> --
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
