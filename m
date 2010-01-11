From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:30 -0800
Subject: [RFC 11/18] arm: msm: add ARCH_MSM_SCORPION to CPU_V7
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-12-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@quicinc.com>

ARCH_MSM_SCORPION supports Qualcomm SnapDragon chipsets.

Signed-off-by: Steve Muckle <smuckle@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mm/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 155c7a3..c721880 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -409,7 +409,8 @@ config CPU_32v6K
 
 # ARMv7
 config CPU_V7
-	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_MSM_SCORPION
+	default y if ARCH_MSM_SCORPION
 	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
-- 
1.6.3.3
