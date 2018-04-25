From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 25 Apr 2018 16:53:30 +0100
Subject: [PATCH/RFC] ARM: shmobile: defconfig: Enable LPAE
Message-ID: <1524671610-13908-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On iWave's iwg20d DDR1 512MB memory cannot be accessed with 32-bit
addresses, hence we need LPAE.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
This information is mentioned in the "RZ/G Series User?s Manual: Hardware",
Chapter 2, Area Map. Is this patch going to break the functionality of other
boards? Comments welcome.

 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index dd95d39..21b25e9 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -23,6 +23,7 @@ CONFIG_ARCH_R8A7792=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
+CONFIG_ARM_LPAE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_PCI=y
-- 
2.7.4
