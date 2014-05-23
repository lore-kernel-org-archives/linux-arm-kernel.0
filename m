From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 23 May 2014 23:19:29 +0200
Subject: [PATCH v10 2/3] clk: exynos5410: register clocks using common
 clock framework
In-Reply-To: <1400841343-6016-3-git-send-email-t.dakhran@samsung.com>
References: <1400841343-6016-1-git-send-email-t.dakhran@samsung.com>
 <1400841343-6016-3-git-send-email-t.dakhran@samsung.com>
Message-ID: <537FBB61.6070201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarek,

Thanks for keeping up with addressing my comments. See below.

On 23.05.2014 12:35, Tarek Dakhran wrote:
> The EXYNOS5410 clocks are statically listed and registered
> using the Samsung specific common clock helper functions.
> 
> Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
> Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
> ---
>  .../devicetree/bindings/clock/exynos5410-clock.txt |   51 +++++
>  drivers/clk/samsung/Makefile                       |    1 +
>  drivers/clk/samsung/clk-exynos5410.c               |  209 ++++++++++++++++++++
>  include/dt-bindings/clock/exynos5410.h             |   33 ++++
>  4 files changed, 294 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
>  create mode 100644 drivers/clk/samsung/clk-exynos5410.c
>  create mode 100644 include/dt-bindings/clock/exynos5410.h
> 

The driver itself looks good, but binding documentation seems to be
outdated. The part about external clocks, more specifically.

> diff --git a/Documentation/devicetree/bindings/clock/exynos5410-clock.txt b/Documentation/devicetree/bindings/clock/exynos5410-clock.txt
> new file mode 100644
> index 0000000..82337c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/exynos5410-clock.txt
> @@ -0,0 +1,51 @@
> +* Samsung Exynos5410 Clock Controller
> +
> +The Exynos5410 clock controller generates and supplies clock to various
> +controllers within the Exynos5410 SoC.
> +
> +Required Properties:
> +
> +- compatible: should be "samsung,exynos5410-clock"
> +
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +- #clock-cells: should be 1.
> +
> +All available clocks are defined as preprocessor macros in
> +dt-bindings/clock/exynos5410.h header and can be used in device
> +tree sources.
> +
> +External clock:
> +There is clock that is generated outside the SoC. It is expected
> +that it is defined using standard clock bindings with following
> + - compatible: should be "samsung,exynos5410-oscclk"

^^^^^

> +
> +Example 1: An example of a clock controller node is listed below.
> +
> +	clock: clock-controller at 0x10010000 {
> +		compatible = "samsung,exynos5410-clock";
> +		reg = <0x10010000 0x30000>;
> +		#clock-cells = <1>;
> +	};
> +
> +Example 2: Required external clock.
> +
> +	fixed-rate-clocks {
> +		oscclk {
> +			compatible = "samsung,exynos5410-oscclk";
> +			clock-frequency = <24000000>;
> +		};
> +	};

^^^^^

Best regards,
Tomasz
