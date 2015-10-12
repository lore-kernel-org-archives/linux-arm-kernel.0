From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 12 Oct 2015 09:21:27 +0100
Subject: [PATCH 0/3] hwrng: stm32 - add support for STM32 HW RNG
In-Reply-To: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
References: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1444638090-22886-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces a driver for the STM32 hardware random number
generator.

v2:

 * Moved binding docs from .../hwrng/ to .../rng/ and renamed to match
   convention in new directory (Rob Herring).
 * Adopted runtime PM and auto-suspend instead of managing the clocks
   from the read function (Linus Walleij). Increased bandwidth by ~30%.
 * Simplified error detection in main read loop (Linus Walleij, Maxime
   Coquelin).
 * Only WARN_ONCE() when hardware failure mechanisms trigger (Maxime
   Coquelin).
 * Simplify end of probe function after cocci warning (Fengguang Wu).
 * Switch to devm_hwrng_register.


Daniel Thompson (3):
  dt-bindings: Document the STM32 HW RNG bindings
  hwrng: stm32 - add support for STM32 HW RNG
  ARM: dts: stm32f429: Adopt STM32 RNG driver

 .../devicetree/bindings/rng/st,stm32-rng.txt       |  21 +++
 arch/arm/boot/dts/stm32f429.dtsi                   |   7 +
 drivers/char/hw_random/Kconfig                     |  12 ++
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/stm32-rng.c                 | 202 +++++++++++++++++++++
 5 files changed, 243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/st,stm32-rng.txt
 create mode 100644 drivers/char/hw_random/stm32-rng.c

--
2.4.3
