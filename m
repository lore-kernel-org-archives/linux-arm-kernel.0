From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 23 Aug 2016 11:58:47 +0900
Subject: [PATCH 5/7] arm64: dts: exynos: Add dts files for Samsung
 Exynos5433 64bit SoC
In-Reply-To: <b4bb1d48-ce1f-0ddf-9e96-3e2ad29bc3fa@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471329328-26842-1-git-send-email-cw00.choi@samsung.com>
 <CGME20160819105049epcas1p424a9e752b59645c675d44d9802f9d775@epcas1p4.samsung.com>
 <b4bb1d48-ce1f-0ddf-9e96-3e2ad29bc3fa@samsung.com>
Message-ID: <57BBBBE7.8080601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 2016? 08? 19? 19:48, Marek Szyprowski wrote:
> Hello,
> 
> 
> On 2016-08-16 08:35, Chanwoo Choi wrote:
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
>>                CoreSight and L2 cache controller.
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
>> - IOMMU for GSCL/DECON/TV/MFC/JPEG/FLITE/3AA/FIMC
> 
> I would prefer to instantiate only SYSMMU controllers for the devices that
> have been already added, so initially there will by only SYSMMUs for DECON.
> Other (GSCL, TV, MFC, JPEG, CAMERA ISP) can be added later together with
> respective master device nodes.

OK. I'll remove all SYSMMU dt nodes from exynos5433.dtsi
on next version.

[snip]

-- 
Best Regards,
Chanwoo Choi
