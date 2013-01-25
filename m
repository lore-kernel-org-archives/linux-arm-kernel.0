From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 25 Jan 2013 16:04:22 +0530
Subject: [PATCH] ARM: davinci: da850: add RTC driver DT entries
In-Reply-To: <1359094430-14724-1-git-send-email-mrugesh.mk@ti.com>
References: <1359094430-14724-1-git-send-email-mrugesh.mk@ti.com>
Message-ID: <51025FAE.3060503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/25/2013 11:43 AM, Mrugesh Katepallewar wrote:
> Add RTC DT entries in da850 dts file.
> 
> Signed-off-by: Mrugesh Katepallewar <mrugesh.mk@ti.com>
> ---
> Applies on top of v3.8-rc4 of linus tree.
> 
> Tested on da850-evm device.
> 
> Test Procedure:
> date [YYYY.]MM.DD-hh:mm[:ss]
> hwclock -w
> reset board and check system time.
> 
> :100644 100644 37dc5a3... b16efd4... M	arch/arm/boot/dts/da850-evm.dts
> :100644 100644 640ab75... a8eb1b1... M	arch/arm/boot/dts/da850.dtsi
>  arch/arm/boot/dts/da850-evm.dts |    3 +++
>  arch/arm/boot/dts/da850.dtsi    |    8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 37dc5a3..b16efd4 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -24,5 +24,8 @@
>  		serial2: serial at 1d0d000 {
>  			status = "okay";
>  		};
> +		rtc at 1c23000 {
> +			status = "okay";
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 640ab75..a8eb1b1 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -56,5 +56,13 @@
>  			interrupt-parent = <&intc>;
>  			status = "disabled";
>  		};
> +		rtc at 1c23000 {
> +			compatible = "ti,da830-rtc";
> +			reg = <0x23000 0x1000>;
> +			interrupts = <19
> +				      19>;

Why two interrupts of the same number? If there is only one interrupt
line then only one should be specified, no?

Thanks,
Sekhar
