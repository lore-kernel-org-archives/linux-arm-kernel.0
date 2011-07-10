From: ido@wizery.com (Ido Yariv)
Date: Sun, 10 Jul 2011 16:14:38 +0300
Subject: [PATCH v2 5/6] arm: davinci: DA850: Add GPIO pinmux configuration for
	wl1271
In-Reply-To: <1310303679-17936-1-git-send-email-ido@wizery.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
Message-ID: <1310303679-17936-6-git-send-email-ido@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wl1271 daughter board makes use of a few GPIOs:
GPIO6_9 is used for powering down/up the WLAN functionality.
GPIO6_10 is used as an input IRQ line from the WLAN chip.

Add the required pinmux configuration for these GPIOs.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 arch/arm/mach-davinci/da850.c            |    2 ++
 arch/arm/mach-davinci/include/mach/mux.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index f6eafb4..bfe9b71 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -590,6 +590,8 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, GPIO3_13,	7,	8,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_0,		10,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_1,		10,	24,	15,	8,	false)
+	MUX_CFG(DA850, GPIO6_9,		13,	24,	15,	8,	false)
+	MUX_CFG(DA850, GPIO6_10,	13,	20,	15,	8,	false)
 	MUX_CFG(DA850, GPIO6_13,	13,	8,	15,	8,	false)
 	MUX_CFG(DA850, RTC_ALARM,	0,	28,	15,	2,	false)
 #endif
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 7fb7f1e..a7e92fc 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -924,6 +924,8 @@ enum davinci_da850_index {
 	DA850_GPIO3_13,
 	DA850_GPIO4_0,
 	DA850_GPIO4_1,
+	DA850_GPIO6_9,
+	DA850_GPIO6_10,
 	DA850_GPIO6_13,
 	DA850_RTC_ALARM,
 };
-- 
1.7.4.1
