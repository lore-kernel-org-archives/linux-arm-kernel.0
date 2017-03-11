From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 10 Mar 2017 16:24:21 -0800
Subject: [PATCH 3/3] ARM64: dts: meson-gx: Prepend GX generic compatible
 like other nodes
In-Reply-To: <1489055948-10656-4-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 9 Mar 2017 11:39:08 +0100")
References: <1489055948-10656-1-git-send-email-narmstrong@baylibre.com>
 <1489055948-10656-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2zigsbqyy.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Could use a bit more changelog here  (in order to support generic
drivers that work for all GX family, blah, blah...)

Kevin

> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 06d70bf..a010ab9 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -233,7 +233,7 @@
>  			};
>  
>  			i2c_A: i2c at 8500 {
> -				compatible = "amlogic,meson-gxbb-i2c";
> +				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
>  				reg = <0x0 0x08500 0x0 0x20>;
>  				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
>  				#address-cells = <1>;
> @@ -279,7 +279,7 @@
>  			};
>  
>  			i2c_B: i2c at 87c0 {
> -				compatible = "amlogic,meson-gxbb-i2c";
> +				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
>  				reg = <0x0 0x087c0 0x0 0x20>;
>  				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>;
>  				#address-cells = <1>;
> @@ -288,7 +288,7 @@
>  			};
>  
>  			i2c_C: i2c at 87e0 {
> -				compatible = "amlogic,meson-gxbb-i2c";
> +				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
>  				reg = <0x0 0x087e0 0x0 0x20>;
>  				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>;
>  				#address-cells = <1>;
> @@ -297,7 +297,7 @@
>  			};
>  
>  			spifc: spi at 8c80 {
> -				compatible = "amlogic,meson-gxbb-spifc";
> +				compatible = "amlogic,meson-gx-spifc", "amlogic,meson-gxbb-spifc";
>  				reg = <0x0 0x08c80 0x0 0x80>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -325,7 +325,7 @@
>  		};
>  
>  		sram: sram at c8000000 {
> -			compatible = "amlogic,meson-gxbb-sram", "mmio-sram";
> +			compatible = "amlogic,meson-gx-sram", "amlogic,meson-gxbb-sram", "mmio-sram";
>  			reg = <0x0 0xc8000000 0x0 0x14000>;
>  
>  			#address-cells = <1>;
> @@ -333,12 +333,12 @@
>  			ranges = <0 0x0 0xc8000000 0x14000>;
>  
>  			cpu_scp_lpri: scp-shmem at 0 {
> -				compatible = "amlogic,meson-gxbb-scp-shmem";
> +				compatible = "amlogic,meson-gx-scp-shmem", "amlogic,meson-gxbb-scp-shmem";
>  				reg = <0x13000 0x400>;
>  			};
>  
>  			cpu_scp_hpri: scp-shmem at 200 {
> -				compatible = "amlogic,meson-gxbb-scp-shmem";
> +				compatible = "amlogic,meson-gx-scp-shmem", "amlogic,meson-gxbb-scp-shmem";
>  				reg = <0x13400 0x400>;
>  			};
>  		};
> @@ -390,7 +390,7 @@
>  			};
>  
>  			ir: ir at 580 {
> -				compatible = "amlogic,meson-gxbb-ir";
> +				compatible = "amlogic,meson-gx-ir", "amlogic,meson-gxbb-ir";
>  				reg = <0x0 0x00580 0x0 0x40>;
>  				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
>  				status = "disabled";
