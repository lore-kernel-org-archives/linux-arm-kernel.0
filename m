From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:31 -0700
Subject: [PATCH 07/47] davinci: am18x/da850/omap-l138: use 'NOM' voltage
	defined in datasheet as min voltage
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-8-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

For each DA850 OPP, the normal ('NOM') voltage defined in the tecnical
reference manual (TRM) is actually the minimum voltage the frequency
is supported at.

The minimum ('MIN') voltage defined in TRM is meant to take care of
voltage fluctuations and the device should not be run at this voltage
for extended periods of time.

Fix the OPP definitions to define the cvdd_min as the normal voltage
defined in the datasheet.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da850.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 868227e..6932d80 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -851,7 +851,7 @@ static const struct da850_opp da850_opp_300 = {
 	.prediv		= 1,
 	.mult		= 25,
 	.postdiv	= 2,
-	.cvdd_min	= 1140000,
+	.cvdd_min	= 1200000,
 	.cvdd_max	= 1320000,
 };
 
@@ -860,7 +860,7 @@ static const struct da850_opp da850_opp_200 = {
 	.prediv		= 1,
 	.mult		= 25,
 	.postdiv	= 3,
-	.cvdd_min	= 1050000,
+	.cvdd_min	= 1100000,
 	.cvdd_max	= 1160000,
 };
 
@@ -869,7 +869,7 @@ static const struct da850_opp da850_opp_96 = {
 	.prediv		= 1,
 	.mult		= 20,
 	.postdiv	= 5,
-	.cvdd_min	= 950000,
+	.cvdd_min	= 1000000,
 	.cvdd_max	= 1050000,
 };
 
-- 
1.7.2.1
