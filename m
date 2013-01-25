From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 25 Jan 2013 16:20:13 +0530
Subject: [PATCH 2/6] ARM: davinci: da850: add DT node for I2C0
In-Reply-To: <1359027324-14534-1-git-send-email-manishv.b@ti.com>
References: <1359027324-14534-1-git-send-email-manishv.b@ti.com>
Message-ID: <51026365.1020402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/24/2013 5:05 PM, Vishwanathrao Badarkhe, Manish wrote:
> Add I2C0 device tree node information to da850-evm.
> Also, add I2C0 pin muxing information in da850-evm.
> 
> Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
> ---
> Depends on patch 
> http://comments.gmane.org/gmane.linux.davinci/25993
> 
>  arch/arm/boot/dts/da850-evm.dts |   15 +++++++++++++++
>  arch/arm/boot/dts/da850.dtsi    |   10 ++++++++++
>  2 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 8cac9d2..3d8290a 100755
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -27,5 +27,20 @@
>  		serial2: serial at 1d0d000 {
>  			status = "okay";
>  		};
> +		i2c0 at 1c22000 {

This should be
		i2c0: i2c at 1c22000

to follow the convention elsewhere in file.

> +			status = "okay";
> +		};
> +	};
> +};
> +&pmx_core {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +		&i2c0_pins
> +	>;
> +
> +	i2c0_pins: pinmux_i2c0_pins{
> +		pinctrl-single,bits = <
> +			0x10 0x00002200 0x0000ff00	/* I2C0_SDA,I2C0_SCL */
> +		>;

This should go into the dtsi file. See the discussion on NAND DT support
submitted by Anil Kumar.

Thanks,
Sekhar

PS: You are using an old address for Kevin Hilman. The MAINTAINERS file
has been updated for a long time now. Liam's address is also wrong but I
don't have his updated e-mail.
