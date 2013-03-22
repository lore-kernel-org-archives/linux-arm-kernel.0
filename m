From: ian@slimlogic.co.uk (Ian Lartey)
Date: Fri, 22 Mar 2013 13:36:03 +0000
Subject: [PATCH v9 01/11] mfd: palmas: is_palmas_charger needed by multiple
 drivers
In-Reply-To: <1363959373-10671-1-git-send-email-ian@slimlogic.co.uk>
References: <1363959373-10671-1-git-send-email-ian@slimlogic.co.uk>
Message-ID: <1363959373-10671-2-git-send-email-ian@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

is_palmas_charger checks for the presence of charging
functionality in the device

Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
Signed-off-by: Ian Lartey <ian@slimlogic.co.uk>
Acked-by: Laxman Dewangani <ldewangan@nvidia.com>
---
 include/linux/mfd/palmas.h |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 3bbda22..4a066d0 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -1,9 +1,10 @@
 /*
  * TI Palmas
  *
- * Copyright 2011 Texas Instruments Inc.
+ * Copyright 2011-2013 Texas Instruments Inc.
  *
  * Author: Graeme Gregory <gg@slimlogic.co.uk>
+ * Author: Ian Lartey <ian@slimlogic.co.uk>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under  the terms of the GNU General  Public License as published by the
@@ -22,6 +23,15 @@
 
 #define PALMAS_NUM_CLIENTS		3
 
+/* The ID_REVISION NUMBERS */
+#define PALMAS_CHIP_OLD_ID		0x0000
+#define PALMAS_CHIP_ID			0xC035
+#define PALMAS_CHIP_CHARGER_ID		0xC036
+
+#define is_palmas(a)	(((a) == PALMAS_CHIP_OLD_ID) || \
+			((a) == PALMAS_CHIP_ID))
+#define is_palmas_charger(a) ((a) == PALMAS_CHIP_CHARGER_ID)
+
 struct palmas_pmic;
 struct palmas_gpadc;
 struct palmas_resource;
-- 
1.7.0.4
