From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Apr 2016 20:21:34 +0530
Subject: [PATCH 2/3] ARM: DTS: da850: add node for i2c1
In-Reply-To: <1459525325-25470-3-git-send-email-petr@barix.com>
References: <1459525325-25470-1-git-send-email-petr@barix.com>
 <1459525325-25470-3-git-send-email-petr@barix.com>
Message-ID: <570673F6.1090508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 April 2016 09:12 PM, Petr Kulhavy wrote:
> da850 has two I2C controllers, but the node for i2c1 was missing.
> Add node for i2c1 controller and i2c1 pinmux pins.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 42948496b8f7..136c422204d3 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -63,6 +63,12 @@
>  					0x10 0x00002200 0x0000ff00
>  				>;
>  			};
> +			i2c1_pins: pinmux_i2c1_pins {
> +				pinctrl-single,bits = <

> +				/* I2C1_SDA,I2C1_SCL */
> +				0x10 0x00440000 0x00ff0000

Indented these two lines one tab like its done elsewhere in the file and
applied.

Thanks,
Sekhar
