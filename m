From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 26 Dec 2017 14:45:36 +0200
Subject: [PATCH] ARM: pxa: cm-x300: remove inline directive
Message-ID: <20171226124536.5973-1-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cm_x300_u2d_init() function is only used through its function pointer
that is passed through platform_data structure to the driver.
Therefore it can never be inlined.
Remove the inline directive.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 868448d2cd82..912e905a6af6 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -509,7 +509,7 @@ static int cm_x300_ulpi_phy_reset(void)
 	return 0;
 }
 
-static inline int cm_x300_u2d_init(struct device *dev)
+static int cm_x300_u2d_init(struct device *dev)
 {
 	int err = 0;
 
-- 
2.13.6
