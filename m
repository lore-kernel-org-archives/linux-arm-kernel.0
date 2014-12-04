From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu,  4 Dec 2014 14:10:02 +0300
Subject: [PATCH 3/3] ARM: pxa: add regulator_has_full_constraints to spitz
 board file
In-Reply-To: <1417691402-28166-1-git-send-email-dbaryshkov@gmail.com>
References: <1417691402-28166-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1417691402-28166-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add regulator_has_full_constraints() call to spitz board file to let
regulator core know that we do not have any additional regulators left.
This lets it substitute unprovided regulators with dummy ones.

This fixes the following warnings that can be seen on spitz if
regulators are enabled:

ads7846 spi2.0: unable to get regulator: -517
spi spi2.0: Driver ads7846 requests probe deferral

Cc: stable at vger.kernel.org
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 840c3a4..f4f713b 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -970,6 +970,8 @@ static void __init spitz_init(void)
 	spitz_nor_init();
 	spitz_nand_init();
 	spitz_i2c_init();
+
+	regulator_has_full_constraints();
 }
 
 static void __init spitz_fixup(struct tag *tags, char **cmdline)
-- 
2.1.3
