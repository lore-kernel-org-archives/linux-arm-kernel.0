From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 12 Jun 2017 12:07:35 +0200
Subject: [PATCH v5 0/5] STM32 Independent watchdog
In-Reply-To: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
References: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
Message-ID: <3b9b5da7-28e4-f349-41a3-1854c374def5@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yannick

On 04/06/2017 02:19 PM, Yannick Fertre wrote:
> Version 5:
> - Update bindings (add field timeout-sec)
> - Update driver (rework start, rework settings & remove max_timeout)
> 
> Version 4:
> - Update bindings (iwdg > watchdog)
> - Update typo
> - Update commit header
> - remove gerrit tags
> - Update driver (remove unnecessary tests) a add watchdog_init_timeout
> 
> Version 3:
> - Update typo into  bindings file
> - Reorder node in devicetree (ordering by address)
> - Remove unnecessary lines in commits
> 
> Version 2:
> - Add commit messages
> 
> Version 1:
> - Initial commit
> 
> The purpose of this set of patches is to add a new watchdog driver for
> stm32f429.
> This driver was developed and tested on evaluation board stm32429i.
> 
> Yannick Fertre (5):
>    dt-bindings: watchdog: Document STM32 IWDG bindings
>    drivers: watchdog: Add STM32 IWDG driver
>    ARM: dts: stm32: Add watchdog support for STM32F429 SoC
>    ARM: dts: stm32: Add watchdog support for STM32F429 eval board
>    ARM: configs: stm32: Add watchdog support in STM32 defconfig
> 
>   .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  19 ++
>   arch/arm/boot/dts/stm32429i-eval.dts               |   5 +
>   arch/arm/boot/dts/stm32f429.dtsi                   |   9 +-
>   arch/arm/configs/stm32_defconfig                   |   1 +
>   drivers/watchdog/Kconfig                           |  12 +
>   drivers/watchdog/Makefile                          |   1 +
>   drivers/watchdog/stm32_iwdg.c                      | 253 +++++++++++++++++++++
>   7 files changed, 299 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>   create mode 100644 drivers/watchdog/stm32_iwdg.c
> 

Patches 3&4 applied on stm32-dt-for-v4.13
Patch 5 applied on stm32-defconfig-for-v4.13

regards
Alex
