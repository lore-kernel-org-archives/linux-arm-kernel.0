From: gerg@snapgear.com (gerg at snapgear.com)
Date: Thu, 25 Oct 2012 15:19:34 +1000
Subject: [PATCH v2] ARM: add back in KS8695 based SnapGear board entries
Message-ID: <1351142374-15435-1-git-send-email-gerg@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

As of linux-3.7-rc1 configuring to build for the Micrel KS8695 based
SnapGear board types will result in a build failure:

  CC      arch/arm/mach-ks8695/board-sg.o
arch/arm/mach-ks8695/board-sg.c:88: error: ?MACH_TYPE_LITE300? undeclared here (not in a function)
arch/arm/mach-ks8695/board-sg.c:100: error: ?MACH_TYPE_SG310? undeclared here (not in a function)
arch/arm/mach-ks8695/board-sg.c:112: error: ?MACH_TYPE_SE4200? undeclared here (not in a function)

Add the removed SnapGear board IDs back into the mach-types file.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
v2: update commit log to reflect actual compile error now

 arch/arm/tools/mach-types |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 831e1fd..df1aefb 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -95,6 +95,7 @@ lpd7a400		MACH_LPD7A400		LPD7A400		389
 lpd7a404		MACH_LPD7A404		LPD7A404		390
 csb337			MACH_CSB337		CSB337			399
 mainstone		MACH_MAINSTONE		MAINSTONE		406
+lite300			MACH_LITE300		LITE300			408
 xcep			MACH_XCEP		XCEP			413
 arcom_vulcan		MACH_ARCOM_VULCAN	ARCOM_VULCAN		414
 nomadik			MACH_NOMADIK		NOMADIK			420
@@ -160,6 +161,7 @@ trizeps4		MACH_TRIZEPS4		TRIZEPS4		776
 cpuat91			MACH_CPUAT91		CPUAT91			787
 iq81340sc		MACH_IQ81340SC		IQ81340SC		799
 iq81340mc		MACH_IQ81340MC		IQ81340MC		801
+se4200			MACH_SE4200		SE4200			809
 micro9			MACH_MICRO9		MICRO9			811
 micro9l			MACH_MICRO9L		MICRO9L			812
 omap_palmte		MACH_OMAP_PALMTE	OMAP_PALMTE		817
@@ -268,6 +270,7 @@ dns323			MACH_DNS323		DNS323			1542
 omap3_beagle		MACH_OMAP3_BEAGLE	OMAP3_BEAGLE		1546
 nokia_n810		MACH_NOKIA_N810		NOKIA_N810		1548
 pcm038			MACH_PCM038		PCM038			1551
+sg310			MACH_SG310		SG310			1564
 ts209			MACH_TS209		TS209			1565
 at91cap9adk		MACH_AT91CAP9ADK	AT91CAP9ADK		1566
 mx31moboard		MACH_MX31MOBOARD	MX31MOBOARD		1574
-- 
1.7.0.4
