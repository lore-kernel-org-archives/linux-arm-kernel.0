From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 28 Feb 2017 17:01:55 +0100
Subject: [PATCH v4 1/6] ARM: davinci: da8xx: allow having multiple pdata-quirks
In-Reply-To: <1488297720-4558-1-git-send-email-bgolaszewski@baylibre.com>
References: <1488297720-4558-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1488297720-4558-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently bail-out after applying a single quirk. We will want
to reuse the function doing the vpif capture registration so remove
the break; and continue iterating over the quirk array.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/pdata-quirks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index 5b57da4..36fb217 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -23,7 +23,6 @@ static void pdata_quirks_check(struct pdata_init *quirks)
 		if (of_machine_is_compatible(quirks->compatible)) {
 			if (quirks->fn)
 				quirks->fn();
-			break;
 		}
 		quirks++;
 	}
-- 
2.9.3
