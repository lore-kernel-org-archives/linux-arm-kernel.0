From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Oct 2014 17:08:44 +0100
Subject: [PATCH 6/6] ARM: mvebu: update mvebu_v7_defconfig for Armada 370 audio
In-Reply-To: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414512524-24466-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the Armada 370 DB audio complex is represented fully in
Device Tree using the simple-card DT binding, this commit updates
mvebu_v7_defconfig to no longer select the Armada 370 DB audio machine
driver, and instead select the appropriate audio controller and codec
drivers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index ed0a0d1..ba43804 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -85,7 +85,9 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_KIRKWOOD_SOC=y
-CONFIG_SND_KIRKWOOD_SOC_ARMADA370_DB=y
+CONFIG_SND_SOC_CS42L51_I2C=y
+CONFIG_SND_SOC_SPDIF=y
+CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MVEBU=y
-- 
2.0.0
