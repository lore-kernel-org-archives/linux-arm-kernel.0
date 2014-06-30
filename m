From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 30 Jun 2014 12:30:51 +0100
Subject: [PATCH v7 0/4] arm: Fix DEBUG_LL for multi-platform kernels (without
 PL01X)
In-Reply-To: <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
References: <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset removes some single-platform compatibility tricks related
to DEBUG_LL and, as a result, allows multi_v7_defconfig derived builds
to enable DEBUG_LL. Currently the user selected kbuild setting is
ignored and the PL01X's DEBUG_LL stub is silently selected instead. This
is a pain if your hardware doesn't have this cell, not least because it
takes a little time to figure out that kbuild built the wrong code.

Changes since v6:
- Removed a patch to limit DEBUG_LL_UART_NONE to platforms that support
  it because it almost time to drop DEBUG_LL_UART_NONE anyway (only
  four platforms still use it).
- Rebased on latest mainline (v3.16rc3).

Changes since v5:

- Shortened the list of platforms that can select DEBUG_LL_UART_NONE
  (changes Arnd Bergmann)
- Rebased on latest mainline (v3.15rc7).

Changes since v4:

- Rebased to latest mainline (and tested again). No functional changes.

Changes since v3:

- Converted from a single patch to a series.
- Tested defconfig builds of all impacted platforms.

Changes since v2:

- Switch from def_bool to bool (thanks Russell King)

Changes since v1:

- Remove pointless single platform support (thanks Arnd Bergmann)

Daniel Thompson (4):
  ARM: versatile: Enable DEBUG_LL_UART_PL01X
  ARM: ep93xx: Enable DEBUG_LL_UART_PL01X
  arm: Seperate DEBUG_UART_PHYS from DEBUG_LL on EP93XX
  arm: Fix DEBUG_LL for multi-platform kernels (without PL01X)

 arch/arm/Kconfig.debug               | 10 +++-------
 arch/arm/configs/ep93xx_defconfig    |  1 +
 arch/arm/configs/versatile_defconfig |  1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

--
1.9.3
