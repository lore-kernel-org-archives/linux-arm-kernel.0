From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 16 Jan 2017 17:02:56 +0100
Subject: [PATCH v1 0/7] DRM: add LTDC support for STM32F4
In-Reply-To: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
References: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
Message-ID: <cf29809f-f951-eeed-5886-02d0a7a1e56f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2017 02:28 PM, Yannick Fertre wrote:
> The purpose of this set of patches is to add a new driver for stm32f429.
> This driver was developed and tested on evaluation board stm32429i.
> 
> Stm32f4 is a MCU platform which don't have MMU so the last patches developed
> by Benjamin Gaignard regarding "DRM: allow to use mmuless devices"
> are necessary.
> 
> The board stm429i embeds a Ampire AM-480272H3TMQW-T01H screen.
> A new simple panel am-480272h3tmqw-t01h have been added to support it.
> 
> Yannick Fertre (7):
>   dt-bindings: display: add STM32 LTDC driver
>   drm/st: Add STM32 LTDC driver
>   dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
>   drm/panel: simple: Add support for Ampire AM-480272H3TMQW-T01H
>   ARM: dts: stm32f429: Add ltdc support
>   ARM: dts: stm32429i-eval: Enable ltdc & simple panel on Eval board
>   ARM: configs: Add STM32 LTDC support in STM32 defconfig
> 
>  .../display/panel/ampire,am-480272h3tmqw-t01h.txt  |    7 +
>  .../devicetree/bindings/display/st,ltdc.txt        |   57 +
>  arch/arm/boot/dts/stm32429i-eval.dts               |   58 +
>  arch/arm/boot/dts/stm32f429.dtsi                   |   25 +-
>  arch/arm/configs/stm32_defconfig                   |    5 +
>  drivers/gpu/drm/Kconfig                            |    2 +
>  drivers/gpu/drm/Makefile                           |    1 +
>  drivers/gpu/drm/panel/panel-simple.c               |   29 +
>  drivers/gpu/drm/st/Kconfig                         |   14 +
>  drivers/gpu/drm/st/Makefile                        |    7 +
>  drivers/gpu/drm/st/drv.c                           |  279 ++++
>  drivers/gpu/drm/st/drv.h                           |   25 +
>  drivers/gpu/drm/st/ltdc.c                          | 1438 ++++++++++++++++++++
>  drivers/gpu/drm/st/ltdc.h                          |   20 +
>  14 files changed, 1966 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
>  create mode 100644 Documentation/devicetree/bindings/display/st,ltdc.txt
>  create mode 100644 drivers/gpu/drm/st/Kconfig
>  create mode 100644 drivers/gpu/drm/st/Makefile
>  create mode 100644 drivers/gpu/drm/st/drv.c
>  create mode 100644 drivers/gpu/drm/st/drv.h
>  create mode 100644 drivers/gpu/drm/st/ltdc.c
>  create mode 100644 drivers/gpu/drm/st/ltdc.h
> 

Hi Yannick,

Shouldn't be more logical to use stm32 for the driver instead of st ?
It would eventually collude with the other STMicroelectronics SoCs and
will be aligned with other drivers like stm32-rtc, stm32-i2c, ...

Neil
