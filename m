From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Jun 2014 15:43:19 +0200
Subject: [PATCH 1/3] ARM: at91/dt: sam9x5: correct PLLA ICPLL and OUT values
In-Reply-To: <1402667001-11207-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1402667001-11207-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1402667001-11207-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ICPLL can only take 0 or 1, it got mixed with OUT which can be in the [0-3]
range.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 1a57298636a5..d6133f497207 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -140,8 +140,8 @@
 								       595000000 650000000 3 0
 								       545000000 600000000 0 1
 								       495000000 555000000 1 1
-								       445000000 500000000 1 2
-								       400000000 450000000 1 3>;
+								       445000000 500000000 2 1
+								       400000000 450000000 3 1>;
 				};
 
 				plladiv: plladivck {
-- 
1.9.1
