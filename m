From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Nov 2014 11:21:13 +0000
Subject: [PATCH 02/19] clk: samsung: Add binding documentation for
 Exynos5433 clock controller
In-Reply-To: <1417073716-22997-3-git-send-email-cw00.choi@samsung.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <1417073716-22997-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <20141127112113.GC857@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 07:34:59AM +0000, Chanwoo Choi wrote:
> This patch add binding documentation for Exynos5433 clock controller.
> Exynos5433 has various clock domains So, this documentation explains
> the detailed clock domains ans usage guide.
> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
> ---
>  .../devicetree/bindings/clock/exynos5433-clock.txt | 106 +++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/exynos5433-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
> new file mode 100644
> index 0000000..72cd0ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
> @@ -0,0 +1,106 @@
> +* Samsung Exynos5433 CMU (Clock Management Units)
> +
> +The Exynos5433 clock controller generates and supplies clock to various
> +controllers within the Exynos5433 SoC.
> +
> +Required Properties:
> +
> +- compatible: should be one of the following.
> +  - "samsung,exynos5433-cmu-top"   - clock controller compatible for CMU_TOP
> +    which generates clocks for IMEM/FSYS/G3D/GSCL/HEVC/MSCL/G2D/MFC/PERIC/PERIS
> +    domains and bus clocks.
> +  - "samsung,exynos5433-cmu-cpif"  - clock controller compatible for CMU_CPIF
> +    which generates clocks for LLI (Low Latency Interface) IP.
> +  - "samsung,exynos5433-cmu-mif"   - clock controller compatible for CMU_MIF
> +    which generates clocks for DRAM Memory Controller domain.
> +  - "samsung,exynos5433-cmu-peric" - clock controller compatible for CMU_PERIC
> +    which generates clocks for UART/I2C/SPI/I2S/PCM/SPDIF/PWM/SLIMBUS IPs.
> +  - "samsung,exynos5433-cmu-peris" - clock controller compatible for CMU_PERIS
> +    which generates clocks for PMU/TMU/MCT/WDT/RTC/SECKEY/TZPC IPs.
> +  - "samsung,exynos5433-cmu-fsys"  - clock controller compatible for CMU_FSYS
> +    which generates clocks for USB/UFS/SDMMC/TSI/PDMA IPs.
> +
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +- #clock-cells: should be 1.
> +
> +Each clock is assigned an identifier and client nodes can use this identifier
> +to specify the clock which they consume.
> +
> +All available clocks are defined as preprocessor macros in
> +dt-bindings/clock/exynos5433.h header and can be used in device
> +tree sources.

That header should be added as part of this patch, otehrwise this is
incomplete.

Mark.
