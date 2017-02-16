From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 16 Feb 2017 19:21:23 +0100
Subject: [PATCH 3/4] ARM: da850-evm: add a fixed regulator for the UI board IO
 expander
In-Reply-To: <1487269285-6948-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487269285-6948-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487269285-6948-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this regulator the tca6416 GPIO expander on the UI board can't
be probed in board file mode and we're not getting VPIF IRQs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 0b9ff2a..1b6a07b 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -828,6 +828,9 @@ static struct regulator_consumer_supply fixed_supplies[] = {
 
 	/* Baseboard 1.8V: 5V -> TPS73701DCQ -> 1.8V */
 	REGULATOR_SUPPLY("DVDD", "1-0018"),
+
+	/* Dummy regulator for the UI board IO expander. */
+	REGULATOR_SUPPLY("vcc", "1-0020"),
 };
 
 /* TPS65070 voltage regulator support */
-- 
2.9.3
