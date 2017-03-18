From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sat, 18 Mar 2017 16:43:03 +0100
Subject: [PATCH v2 3/4] ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
In-Reply-To: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
References: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
Message-ID: <20170318154305.28348-4-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Now that the gpio driver also supports PWM operation, enable the PWM
framework and fan driver in mvebu_v7_defconfig.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427297/
[Ralph Sennhauser: add fan driver to defconfig]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index f1a0e25..6955370 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -135,6 +135,8 @@ CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
+CONFIG_PWM=y
+CONFIG_SENSORS_PWM_FAN=y
 CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
-- 
2.10.2
