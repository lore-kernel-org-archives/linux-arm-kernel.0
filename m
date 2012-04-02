From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  2 Apr 2012 15:31:04 +0100
Subject: [PATCH 2/2] ARM: ux500: Fix unmet direct dependency
In-Reply-To: <1333377064-8093-1-git-send-email-lee.jones@linaro.org>
References: <1333377064-8093-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1333377064-8093-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change to a Kconfig configuration saw MACH_U8500
remove TPS6105X selection. In doing so Kconfig stopped
selecting REGULATORS, which is still required. This patch
sees UX500_SOC_DB8500 implicitly select it instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 880d02e..ef7099e 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -17,6 +17,7 @@ config UX500_SOC_DB5500
 config UX500_SOC_DB8500
 	bool
 	select MFD_DB8500_PRCMU
+	select REGULATOR
 	select REGULATOR_DB8500_PRCMU
 	select CPU_FREQ_TABLE if CPU_FREQ
 
-- 
1.7.5.4
