From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 12 Jun 2017 14:00:27 +0200
Subject: [PATCH v7 0/9] STM32 LCD-TFT display controller
In-Reply-To: <1492164819-10513-1-git-send-email-yannick.fertre@st.com>
References: <1492164819-10513-1-git-send-email-yannick.fertre@st.com>
Message-ID: <2abef21d-5ce8-3bd2-7918-4fefcf2a5858@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yannick

On 04/14/2017 12:13 PM, Yannick Fertre wrote:
...
> 
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
> 
> Yannick Fertre (9):
>    drm/cma: Update DEFINE_DRM_GEM_CMA_FOPS to add get_unmapped_area
>    drm/fb-cma-helper: Add drm_fb_cma_get_gem_addr()
>    dt-bindings: display: Add STM32 LTDC driver
>    drm/stm: Add STM32 LTDC driver
>    MAINTAINERS: add maintainers for DRM STM driver
>    ARM: dts: stm32: Add ltdc support on stm32f429 MCU
>    ARM: dts: stm32: Enable ltdc & simple panel on stm32f429-Eval board
>    ARM: configs: stm32: Add DRM support in STM32 defconfig
>    ARM: configs: stm32: Add simple panel support in STM32 defconfig
> 
For STM32 machine part:

Patches 6 & 7 applied on stm32-dt-for-v4.13

Patches 8 & 9 will not be applied:
As SDRAM used on STM32 MCUs is small, I don't want to penalize other users:
  - by increasing static kernel size
  - by enabling devices which consume dynamically lot of memory

User will be free to enable it through menuconfig.

Regards
Alex
