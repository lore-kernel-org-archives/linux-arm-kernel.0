From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jan 2015 22:58:07 +0100
Subject: [PATCH 04/17] ARM: at91: fix sam9n12 and sam9x5 arm_pm_idle
In-Reply-To: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421359100-8930-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sam9n12 and sam9x5 don't set arm_pm_idle because of an oversight, fix that.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-at91/at91sam9n12.c | 5 +++++
 arch/arm/mach-at91/at91sam9x5.c  | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
index b5ea69a3eaf6..276b8f0e4183 100644
--- a/arch/arm/mach-at91/at91sam9n12.c
+++ b/arch/arm/mach-at91/at91sam9n12.c
@@ -15,6 +15,11 @@
 /* --------------------------------------------------------------------
  *  AT91SAM9N12 processor initialization
  * -------------------------------------------------------------------- */
+static void __init at91sam9n12_initialize(void)
+{
+	arm_pm_idle = at91sam9_idle;
+}
 
 AT91_SOC_START(at91sam9n12)
+	.init = at91sam9n12_initialize,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 7b60a529db01..7b6fb1bca505 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -16,5 +16,11 @@
  *  AT91SAM9x5 processor initialization
  * -------------------------------------------------------------------- */
 
+static void __init at91sam9x5_initialize(void)
+{
+	arm_pm_idle = at91sam9_idle;
+}
+
 AT91_SOC_START(at91sam9x5)
+	.init = at91sam9x5_initialize,
 AT91_SOC_END
-- 
2.1.0
