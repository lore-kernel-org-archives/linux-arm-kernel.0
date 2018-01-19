From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 19 Jan 2018 15:02:54 +0100
Subject: [PATCH v5 0/7] ARM: stm32: add initial STM32MPU support
In-Reply-To: <1516114580-2424-1-git-send-email-ludovic.Barre@st.com>
References: <1516114580-2424-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <d93e6536-cdc3-b055-395e-a98915c1a875@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic

On 01/16/2018 03:56 PM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series extends the existing STM32 microcontrollers (MCUs)
> family to microprocessors (MPUs). The MPU platform (based on
> Arm Cortex-A) is a continuation of the MCU one (based on Arm
> Cortex-M) in that it shares a wide number of hardware blocks.
> 

If not other majors comments on the series I will apply it in my next 
pull request (for v4.17).

Regards
Alex

> change v5:
> -fix serial3 aliases by serial0
>   
> change v4:
> -Add all available uarts in stm32mp157c
> -Move uart aliases to board files
> 
> change v3:
> -Remove bootargs
> -Remove armv7m_restart and Share stm32_compat for mcu/mpu
> -Modify stm32 kconfig with Arnd template
> -Remove patch below (Linus W: Patch applied)
>   devicetree: bindings: Document supported STM32 SoC family
>   pinctrl: stm32: Add STM32MP157 MPU support
> 
> change V2:
> -Add stm32 documentation in this serie to avoid merge conflict
> thread: "https://patchwork.kernel.org/patch/10102573/";
> -Split bindings (stm32.txt) to separate patches.
> -Remove ARCH_STM32_MCU/MPU flags
> -Adopt rst format for Documentation/arm/stm32 files
> -s/STMicrolectronics/STMicroelectronics/g
> 
> Ludovic Barre (7):
>    Documentation: arm: stm32: move to rst format
>    ARM: stm32: prepare stm32 family to welcome armv7 architecture
>    dt-bindings: stm32: add support of STM32MP157
>    ARM: stm32: add initial support for STM32MP157
>    ARM: configs: multi_v7: add stm32 support
>    ARM: dts: stm32: add stm32mp157c initial support
>    ARM: dts: stm32: add initial support of stm32mp157c eval board
> 
>   Documentation/arm/stm32/overview.rst            |  34 +++++
>   Documentation/arm/stm32/overview.txt            |  33 ----
>   Documentation/arm/stm32/stm32f429-overview.rst  |  26 ++++
>   Documentation/arm/stm32/stm32f429-overview.txt  |  22 ---
>   Documentation/arm/stm32/stm32f746-overview.rst  |  33 ++++
>   Documentation/arm/stm32/stm32f746-overview.txt  |  34 -----
>   Documentation/arm/stm32/stm32h743-overview.rst  |  34 +++++
>   Documentation/arm/stm32/stm32h743-overview.txt  |  30 ----
>   Documentation/arm/stm32/stm32mp157-overview.rst |  19 +++
>   Documentation/devicetree/bindings/arm/stm32.txt |   1 +
>   arch/arm/boot/dts/Makefile                      |   6 +-
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi       | 185 ++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts           |  32 ++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts           |  21 +++
>   arch/arm/boot/dts/stm32mp157c.dtsi              | 194 ++++++++++++++++++++++++
>   arch/arm/configs/multi_v7_defconfig             |   3 +
>   arch/arm/mach-stm32/Kconfig                     |  38 +++--
>   arch/arm/mach-stm32/board-dt.c                  |   5 +-
>   18 files changed, 614 insertions(+), 136 deletions(-)
>   create mode 100644 Documentation/arm/stm32/overview.rst
>   delete mode 100644 Documentation/arm/stm32/overview.txt
>   create mode 100644 Documentation/arm/stm32/stm32f429-overview.rst
>   delete mode 100644 Documentation/arm/stm32/stm32f429-overview.txt
>   create mode 100644 Documentation/arm/stm32/stm32f746-overview.rst
>   delete mode 100644 Documentation/arm/stm32/stm32f746-overview.txt
>   create mode 100644 Documentation/arm/stm32/stm32h743-overview.rst
>   delete mode 100644 Documentation/arm/stm32/stm32h743-overview.txt
>   create mode 100644 Documentation/arm/stm32/stm32mp157-overview.rst
>   create mode 100644 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-ed1.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-ev1.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c.dtsi
> 
