From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 21 Jun 2010 23:02:03 +0200
Subject: [PATCH] pxa3xx: Fix HSIO bus x24 multiplier
Message-ID: <1277154123-31532-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The value should be 24, not 0 in the possibilities array. It was just a silly
mistake.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/pxa3xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index acfa9f7..fa00148 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -52,7 +52,7 @@
 static unsigned char smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
 
 /* crystal frequency to HSIO bus frequency multiplier (HSS) */
-static unsigned char hss_mult[4] = { 8, 12, 16, 0 };
+static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
 
 /*
  * Get the clock frequency as reflected by CCSR and the turbo flag.
-- 
1.7.1
