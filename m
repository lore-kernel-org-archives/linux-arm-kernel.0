From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 28 Mar 2017 20:00:57 -0700
Subject: [PATCH v3 0/5] STM32 Independant watchdog
In-Reply-To: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
References: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1390e264-2b54-c07b-89d3-9f5dd7d7254e@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject: s/Independant/Independent/

On 03/22/2017 08:04 AM, Yannick Fertre wrote:
> Version 3:
> - Update typo into  bindings file
> - Reorder node in devicetree (ordering by address)
> - Remove unecessary lines in commits
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
>   dt-bindings: Document STM32 IWDG bindings
>   drivers: watchdog: Add STM32 IWDG driver
>   ARM: dts: stm32: Add watchdog support for STM32F429 SoC
>   ARM: dts: stm32: Add watchdog support for STM32F429 eval board
>   ARM: configs: Add watchdog support in STM32 defconfig
>
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  15 ++
>  arch/arm/boot/dts/stm32429i-eval.dts               |   4 +
>  arch/arm/boot/dts/stm32f429.dtsi                   |   9 +-
>  arch/arm/configs/stm32_defconfig                   |   1 +
>  drivers/watchdog/Kconfig                           |  11 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/stm32_iwdg.c                      | 289 +++++++++++++++++++++
>  7 files changed, 329 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
>  create mode 100644 drivers/watchdog/stm32_iwdg.c
>
