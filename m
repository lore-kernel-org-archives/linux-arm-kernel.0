From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:45 +0200
Subject: [PATCH v2 20/30] ARM: shmobile: armadillo800eva-reference: Initialise
 TMU device using DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-21-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise TMU device using DT when booting armadillo800eva
using DT-reference. This device was previously enabled when
booting with legacy-C but not with DT-reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index f47ab76..c430197 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -205,6 +205,10 @@
 	};
 };
 
+&tmu0 {
+	status = "okay";
+};
+
 &pfc {
 	ether_pins: ether {
 		renesas,groups = "gether_mii", "gether_int";
-- 
2.0.0.rc2
