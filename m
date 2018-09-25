From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 25 Sep 2018 15:53:30 +0200
Subject: [PATCH] arm64: amlogic: Rename spi pinmux group
In-Reply-To: <20180924094523.20573-1-thierry.reding@gmail.com>
References: <20180924094523.20573-1-thierry.reding@gmail.com>
Message-ID: <cf080df1-ee10-cfa8-9bc1-d5b77415990e@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24/09/2018 11:45, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The name "spi" is reserved for nodes representing an SPI controller.
> Rename the "spi" pinmux group to "spi-miso" to avoid the issue and for
> consistency with other pinmux groups.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Rob,
> 
> do you think perhaps DTC is being a little too strict here? Seems to me
> like the check could be limited to nodes that have a name and a unit
> address, the assumption being that an SPI controller would always have
> some sort of register space that requires a reg property and therefore
> also a unit address.
> 
> Thierry
> 
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Rob has already submitted similar fix and was merged by kevin.

Neil

> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 98cbba6809ca..3cd4475ca027 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -390,7 +390,7 @@
>  			};
>  		};
>  
> -		spi_pins: spi {
> +		spi_pins: spi-miso {

The name "spi-miso" is wrong since it also has spi-mosi...

>  			mux {
>  				groups = "spi_miso",
>  					"spi_mosi",
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index c87a80e9bcc6..911fd3412788 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -337,7 +337,7 @@
>  			};
>  		};
>  
> -		spi_pins: spi {
> +		spi_pins: spi-miso {
>  			mux {
>  				groups = "spi_miso",
>  					"spi_mosi",
> 
