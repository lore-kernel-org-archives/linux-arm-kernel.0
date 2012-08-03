From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 Aug 2012 22:15:15 +0800
Subject: [PATCH 2/2] ARM: imx/pcm043: add oftree support
In-Reply-To: <1343922986-32469-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343922986-32469-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343922986-32469-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120803141512.GC23791@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 05:56:26PM +0200, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/dts/phytec-pcm043.dtsi |   49 ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 arch/arm/boot/dts/phytec-pcm043.dtsi
> 
> diff --git a/arch/arm/boot/dts/phytec-pcm043.dtsi b/arch/arm/boot/dts/phytec-pcm043.dtsi
> new file mode 100644
> index 0000000..420627c
> --- /dev/null
> +++ b/arch/arm/boot/dts/phytec-pcm043.dtsi
> @@ -0,0 +1,49 @@
> +/include/ "imx35.dtsi"
> +
> +/ {
> +	soc {
> +		aips at 40000000 { /* AIPS1 */
> +			i2c at 43f80000 {
> +				status = "okay";
> +
> +				tempsens at 4a {
> +					compatible = "maxim,ds75";
> +					reg = <0x4a>;
> +				};

Again, please put a new line between nodes.

> +				rtc8564 at 51 {
> +					compatible = "nxp,pcf8563";
> +					reg = <0x51>;
> +				};
> +				at24 at 52 {
> +					compatible = "at,24c32";
> +					reg = <0x52>;
> +					pagesize = <32>;
> +				};
> +			};
> +			uart at 43f90000 {
> +				status = "okay";
> +			};
> +			uart at 43f94000 {
> +				status = "okay";
> +			};
> +		};
> +		spba at 50000000 {
> +			uart at 5000c000 {
> +				status = "okay";
> +			};
> +			fec at 50038000 {
> +				status = "okay";
> +			};
> +		};
> +
> +		nor at a0000000 {
> +			compatible = "cfi-flash";
> +			reg = <0xa0000000 0x2000000>;
> +			bank-width = <2>;
> +		};
> +
We should be able to see how this device is connected to SoC with this
node under proper interface and bus topology.

> +		nand at bb000000 {
> +			status = "okay";
> +		};

Ditto.

> +	};
> +};
> -- 
> 1.7.10.4
> 

-- 
Regards,
Shawn
