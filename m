From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 02 Sep 2016 18:54:36 +0900
Subject: [PATCH v2 5/7] arm64: dts: exynos: Add dts files for Samsung
 Exynos5433 64bit SoC
In-Reply-To: <20160826161442.GB15511@kozik-book>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-6-git-send-email-cw00.choi@samsung.com>
 <CGME20160826161551epcas1p2386a62f005140f42c03d3ff1c679ebe6@epcas1p2.samsung.com>
 <20160826161442.GB15511@kozik-book>
Message-ID: <57C94C5C.8070406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 08? 27? 01:14, Krzysztof Kozlowski wrote:
> On Wed, Aug 24, 2016 at 10:49:09PM +0900, Chanwoo Choi wrote:
>> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
>> Octa-core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
>> PSCI (Power State Coordination Interface) v0.1.
>>
>> This patch includes following Device Tree node to support Exynos5433 SoC:
>> 1. Octa cores for big.LITTLE architecture
>> - Cortex-A53 LITTLE Quad-core
>> - Cortex-A57 big Quad-core
>> - Support PSCI v0.1
>>
>> 2. Clock controller node
>> - CMU_TOP   : clocks for IMEM/FSYS/G3D/GSCL/HEVC/MSCL/G2D/MFC/PERIC/PERIS
>> - CMU_CPIF  : clocks for LLI (Low Latency Interface)
>> - CMU_MIF   : clocks for DRAM Memory Controller
>> - CMU_PERIC : clocks for UART/I2C/SPI/I2S/PCM/SPDIF/PWM/SLIMBUS
>> - CMU_PERIS : clocks for PMU/TMU/MCT/WDT/RTC/SECKEY/TZPC
>> - CMU_FSYS  : clocks for USB/UFS/SDMMC/TSI/PDMA
>> - CMU_G2D   : clocks for G2D/MDMA
>> - CMU_DISP  : clocks for DECON/HDMI/DSIM/MIXER
>> - CMU_AUD   : clocks for Cortex-A5/BUS/AUDIO
>> - CMU_BUS{0|1|2} : clocks for global data buses and global peripheral buses
>> - CMU_G3D   : clocks for 3D Graphics Engine
>> - CMU_GSCL  : clocks for GSCALER
>> - CMU_APOLLO: clocks for Cortex-A53 Quad-core processor.
>> - CMU_ATLAS : clocks for Cortex-A57 Quad-core processor,
>>               CoreSight and L2 cache controller.
>> - CMU_MSCL  : clocks for M2M (Memory to Memory) scaler and JPEG IPs.
>> - CMU_MFC   : clocks for MFC (Multi-Format Codec) IP.
>> - CMU_HEVC  : clocks for HEVC(High Efficiency Video Codec) decoder IP.
>> - CMU_ISP   : clocks for FIMC-ISP/DRC/SCLC/DIS/3DNR IPs.
>> - CMU_CAM0  : clocks for MIPI_CSIS{0|1}/FIMC_LITE_{A|B|D}/FIMC_3AA{0|1} IPs.
>> - CMU_CAM1  : clocks for COrtex-A5/MIPI_CSIS2/FIMC_LITE_C/FIMC-FD IPs.
>>
>> 3. pinctrl node for GPIO
>> - alive/aud/cpif/ese/finger/fsys/imem/nfc/peric/touch pad
>>
>> 4. Timer
>> - ARM architecture timer (armv8-timer)
>> - MCT (Multi Core Timer) timer
>>
>> 5. Interrupt controller (GIC-400)
>>
>> 6. BUS devices
>> - HS-I2C (High-Speed I2C) device
>> - SPI (Serial Peripheral Interface) device
>>
>> 7. Sound devices
>> - I2S bus
>> - LPASS (Low Power Audio Subsystem)
>>
>> 8. Power management devices
>> - CPUFREQ for for Cortex-A53/A57
>> - TMU (Thermal Management Unit) for Cortex-A53/A57, G3D, ISP
>>
>> 9. Display controller devices
>> - DECON (Display and enhancement controller) for panel output
>> - DSI (Display Serial Interface)
>> - MIC (Mobile Image Compressor)
>>
>> 10. USB
>> - USB 3.0 DRD (Dual Role Device) controller
>> - USB 3.0 Host controller
>>
>> 11. Storage devices
>> - MSHC (Mobile Stoarage Host Controller)
>>
>> 12. Misc devices
>> - UART device
>> - ADC (Analog Digital Converter)
>> - PWM (Pulse Width Modulation)
>> - ADMA (Advanced DMA) and PDMA (Peripheral DMA)
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
>> Signed-off-by: Inha Song <ideal.song@samsung.com>
>> Signed-off-by: Ingi kim <ingi2.kim@samsung.com>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  792 ++++++++++++
>>  .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |   23 +
>>  .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |   22 +
>>  arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     |  306 +++++
>>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 1327 ++++++++++++++++++++
>>  5 files changed, 2470 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi
> 
> I got only one question:
> 
>  +
>> +		cooling-maps {
>> +			map0 {
>> +				/* Set maximum frequency as 1300MHz  */
>> +				trip = <&apollo_alert_0>;
>> +				cooling-device = <&cpu0 0 0>;
> 
> Is cooling level=0 really a cooling level? I think it does nothing so it
> should be just removed.

You are right. I'll modify it for big cores as following: 
- cooling-device = <&cpu4 1 2>;

Also, I'll use the only 5 step cooling level instead of 7 step.
for LITTLE cores.


For big cores:
	cooling-maps {
		map0 {
			/* Set maximum frequency as 1800MHz  */
			trip = <&atlas0_alert_0>;
			cooling-device = <&cpu4 1 2>;
		};
		map1 {
			/* Set maximum frequency as 1700MHz  */
			trip = <&atlas0_alert_1>;
			cooling-device = <&cpu4 2 3>;
		};
		map2 {
			/* Set maximum frequency as 1600MHz  */
			trip = <&atlas0_alert_2>;
			cooling-device = <&cpu4 3 4>;
		};
		map3 {
			/* Set maximum frequency as 1500MHz  */
			trip = <&atlas0_alert_3>;
			cooling-device = <&cpu4 4 5>;
		};
		map4 {
			/* Set maximum frequency as 1400MHz  */
			trip = <&atlas0_alert_4>;
			cooling-device = <&cpu4 5 7>;
		};
		map5 {
			/* Set maximum frequencyas 1200MHz  */
			trip = <&atlas0_alert_5>;
			cooling-device = <&cpu4 7 9>;
		};
		map6 {
			/* Set maximum frequency as 1000MHz  */
			trip = <&atlas0_alert_6>;
			cooling-device = <&cpu4 9 14>;
		};
	};


For LITTLE cores:
	cooling-maps {
		map0 {
			/* Set maximum frequency as 1200MHz  */
			trip = <&apollo_alert_2>;
			cooling-device = <&cpu0 1 2>;
		};
		map1 {
			/* Set maximum frequency as 1100MHz  */
			trip = <&apollo_alert_3>;
			cooling-device = <&cpu0 2 3>;
		};
		map2 {
			/* Set maximum frequency as 1000MHz  */
			trip = <&apollo_alert_4>;
			cooling-device = <&cpu0 3 4>;
		};
		map3 {
			/* Set maximum frequency as 900MHz  */
			trip = <&apollo_alert_5>;
			cooling-device = <&cpu0 4 5>;
		};
		map4 {
			/* Set maximum frequency as 800MHz  */
			trip = <&apollo_alert_6>;
			cooling-device = <&cpu0 5 9>;
		};
	};

> 
> The same for big cluster.
> 
> Rest looks good.
> 
> BR,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

-- 
Best Regards,
Chanwoo Choi
