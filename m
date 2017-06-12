From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 12 Jun 2017 12:03:31 +0200
Subject: [PATCH v5 0/8] Add support for DCMI camera interface of
 STMicroelectronics STM32 SoC series
In-Reply-To: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
References: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <f50a3320-a0ef-bdef-d236-f57fd477bccc@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugues

On 05/05/2017 05:31 PM, Hugues Fruchet wrote:
> This patchset introduces a basic support for Digital Camera Memory Interface
> (DCMI) of STMicroelectronics STM32 SoC series.
> 
> This first basic support implements RGB565 & YUV frame grabbing.
> Cropping and JPEG support will be added later on.
> 
> This has been tested on STM324x9I-EVAL evaluation board embedding
> an OV2640 camera sensor.
> 
.....
> 
> Hugues Fruchet (8):
>    dt-bindings: Document STM32 DCMI bindings
>    [media] stm32-dcmi: STM32 DCMI camera interface driver
>    ARM: dts: stm32: Enable DCMI support on STM32F429 MCU
>    ARM: dts: stm32: Enable DCMI camera interface on STM32F429-EVAL board
>    ARM: dts: stm32: Enable STMPE1600 gpio expander of STM32F429-EVAL
>      board
>    ARM: dts: stm32: Enable OV2640 camera support of STM32F429-EVAL board
>    ARM: configs: stm32: STMPE1600 GPIO expander
>    ARM: configs: stm32: DCMI + OV2640 camera support
> 
>   .../devicetree/bindings/media/st,stm32-dcmi.txt    |   46 +
>   arch/arm/boot/dts/stm32429i-eval.dts               |   56 +
>   arch/arm/boot/dts/stm32f429.dtsi                   |   37 +
>   arch/arm/configs/stm32_defconfig                   |    9 +
>   drivers/media/platform/Kconfig                     |   12 +
>   drivers/media/platform/Makefile                    |    2 +
>   drivers/media/platform/stm32/Makefile              |    1 +
>   drivers/media/platform/stm32/stm32-dcmi.c          | 1403 ++++++++++++++++++++
>   8 files changed, 1566 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
>   create mode 100644 drivers/media/platform/stm32/Makefile
>   create mode 100644 drivers/media/platform/stm32/stm32-dcmi.c
> 

Patches 3, 4, 5, 6 applied on stm32-dt-for-v4.13

Patch 7 applied on stm32-defconfig-for-v4.13

Patch 8 will not be applied: As SDRAM used on STM32 MCUs is small,
I don't want to penalize other users:
  - by increasing static kernel size
  - by enabling devices which consume dynamically lot of memory

User will be free to enable it through menuconfig.

Regards
Alex
