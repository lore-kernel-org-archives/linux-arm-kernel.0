From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 14 Oct 2015 12:44:15 +0200
Subject: [PATCH v1 0/2] Fix display on second resume on 5250-snow
Message-ID: <1444819457-27519-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

as discussed in [0], currently on the second resume from memory the
display is broken on Snow boards (ARM Samsung Series 3 Chromebook).

The reason is that on resume the contents of register SRC_TOP3 aren't
what the kernel thinks they are because the HW (or FW) is doing some
clock reparenting beneath our feet.

This series tasks the kernel to do the reparenting itself so that the HW
state always matches the kernel's internal state.

Thanks,

Tomeu

[0] http://lkml.kernel.org/g/561CDC33.7050103 at collabora.com


Tomeu Vizoso (2):
  clk: samsung: exynos5250: Add DISP1 clocks
  ARM: dts: exynos5250: Add clocks to DISP1 domain

 arch/arm/boot/dts/exynos5250.dtsi      |  4 ++++
 drivers/clk/samsung/clk-exynos5250.c   | 16 +++++++++++++++-
 include/dt-bindings/clock/exynos5250.h |  4 +++-
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.5.0
