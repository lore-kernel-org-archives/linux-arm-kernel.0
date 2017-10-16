From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 16 Oct 2017 18:16:26 +0200
Subject: [PATCHv2 0/7] Add support for USB OTG on STM32F7
In-Reply-To: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
References: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <f80312bc-e9bd-2216-404c-016a6ad690a3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie,

On 08/28/2017 04:20 PM, Amelie Delaunay wrote:
> The STM32F7 MCU family embeds two DWC2 USB OTG cores. One core is USB
> OTG FS and the other is USB OTG HS. The USB FS core only works with its
> internal phy whilst the USB HS core can work in HS with external ULPI phy
> or in FS/LS with the on-chip FS phy.
> 
> Amelie Delaunay (7):
>    dt-bindings: usb: Document the STM32F7 DWC2 USB OTG HS core binding
>    usb: dwc2: add support for STM32F7 USB OTG HS
>    ARM: dts: stm32: Add USB HS support for STM32F746 MCU
>    ARM: dts: stm32: Enable USB HS on stm32746g-eval
>    ARM: dts: stm32: Enable USB HS on stm32f746-disco
>    ARM: dts: stm32: Add USB FS support for STM32F746 MCU
>    ARM: dts: stm32: Enable USB FS on stm32f746-disco
> 
>   Documentation/devicetree/bindings/usb/dwc2.txt |  2 +
>   arch/arm/boot/dts/stm32746g-eval.dts           | 16 ++++++
>   arch/arm/boot/dts/stm32f746-disco.dts          | 30 ++++++++++
>   arch/arm/boot/dts/stm32f746.dtsi               | 80 ++++++++++++++++++++++++++
>   drivers/usb/dwc2/params.c                      | 11 ++++
>   5 files changed, 139 insertions(+)
> 

Patches 3 to 7 applied on stm32-dt-for-v4.15 branch.
Currently USB stack is not enabled by default (and will not be). If you 
plan to use USB don't forget to create a reserved memory region for DMA 
pool (as DMA and caches are not friends on cortex-M7) in devicetree.
Reserved memory region for DMA pool support will be added in stm32F7 and 
stm32H7 devicetree as soon series "ARM: NOMMU: MPU updates" from 
Vladimir Murzin will be merged.

Regards
Alex
