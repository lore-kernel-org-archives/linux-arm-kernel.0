From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 21 Oct 2016 10:36:39 +0100
Subject: [RFC PATCH 6/8] ARM: virt: select ARM_GIC_V3_ITS
In-Reply-To: <1477042601-15227-1-git-send-email-vladimir.murzin@arm.com>
References: <1477042601-15227-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1477042601-15227-7-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows ARM guests to use GICv3 ITS on an arm64 host

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b5d529f..caef684 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -703,6 +703,7 @@ config ARCH_VIRT
 	select ARM_GIC
 	select ARM_GIC_V2M if PCI
 	select ARM_GIC_V3
+	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
 
-- 
1.7.9.5
