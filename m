From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 14 Aug 2015 01:47:12 +0300
Subject: [PATCH v2] ARM: shmobile: silk: add SDHI1 DT support
In-Reply-To: <2757472.iuyUyRzJ3z@wasted.cogentembedded.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <2757472.iuyUyRzJ3z@wasted.cogentembedded.com>
Message-ID: <55CD1E70.6050103@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/11/2015 01:44 AM, Sergei Shtylyov wrote:

> Define the SILK board dependent part of the SDHI1 (connected to micro-SD slot)
> device nodes along with the necessary voltage regulators.
>
> Based on the original patch by Vladimir Barinov
> <vladimir.barinov@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against 'renesas-devel-20150810-v4.2-rc6' tag of Simon Horman's
> 'renesas.git' repo plus the R8A7794/SILK QSPI patches just re-posted. It needs
> the R8A7794 GPIO patches in order to compile.
>
> Changes in version 2:
> - removed not working SDHI0 stuff, renamed the patch;
> - replaced SDHI1's "wp-gpios" property with "disable-wp".
>
>   arch/arm/boot/dts/r8a7794-silk.dts |   40 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
> +++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
[...]
> @@ -39,6 +40,29 @@
>   		regulator-boot-on;
>   		regulator-always-on;
>   	};

    Oops, need a newline here. I'll repost.

> +	vcc_sdhi1: regulator at 3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "SDHI1 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&gpio4 26 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vccq_sdhi1: regulator at 4 {
> +		compatible = "regulator-gpio";
> +
> +		regulator-name = "SDHI1 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <3300000 1
> +			  1800000 0>;
> +	};
>   };
>
>   &extal_clk {
[...]

MBR, Sergei
