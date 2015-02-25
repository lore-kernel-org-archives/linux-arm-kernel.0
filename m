From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 25 Feb 2015 22:58:02 +0100
Subject: [PATCH 4/4] ARM: mvebu: fix routing for analog audio input of Armada
 370 DB platform
In-Reply-To: <1424901482-3809-1-git-send-email-mw@semihalf.com>
References: <y>
 <1424901482-3809-1-git-send-email-mw@semihalf.com>
Message-ID: <1424901482-3809-5-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 370 DB sound complex comprise routing for audio card with a
description for analog input line with two left channels instead of a pair
left-right. This commit introduces routing for the right channel.

Fixes: a6b334514be2 ("use simple-card DT binding for audio on Armada 370 DB")

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Cc: <stable@vger.kernel.org> # v3.19+
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index e993c46..d6e72a4 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -190,7 +190,7 @@
 			"Out Jack", "HPL",
 			"Out Jack", "HPR",
 			"AIN1L", "In Jack",
-			"AIN1L", "In Jack";
+			"AIN1R", "In Jack";
 		status = "okay";
 
 		simple-audio-card,dai-link at 0 {
-- 
1.8.3.1
