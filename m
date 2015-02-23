From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 23 Feb 2015 16:59:27 +0100
Subject: [PATCH 1/3] ARM: shmobile: Enable R-Mobile reset driver in
 multiplatform defconfig
In-Reply-To: <1424707169-23007-1-git-send-email-geert+renesas@glider.be>
References: <1424707169-23007-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1424707169-23007-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used on R-Mobile APE6 (r8a73a4), R-Mobile A1 (r8a7740), and
SH-Mobile AG5 (sh73a0).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To actually work, this depends on:
  - commit fa0f8d6700857457 ("power: reset: Add reset driver for
    R-Mobile platforms"), which is in v4.0-rc1,
  - the system-controller node in the SoC's .dtsi, which was added for
    PM domain support in:
      - r8a73a4-multiplatform-for-v3.21 (r8a73a4),
      - v4.0-rc1 (r8a7740),
      - sh73a0-multiplatform-for-v3.21 (sh73a0).

Irrespectively of that, it's safe to apply anyway.
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index fb7aa02125c4e695..a904c90f957931d8 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -109,6 +109,9 @@ CONFIG_SPI_SH_HSPI=y
 CONFIG_GPIO_EM=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_PCF857X=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_RMOBILE=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
-- 
1.9.1
