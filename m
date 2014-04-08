From: adam@baker-net.org.uk (Adam Baker)
Date: Tue, 08 Apr 2014 23:34:32 +0100
Subject: [PATCH v2 3/3] ARM: kirkwood: rename kirwood-nsa310-common to
 3x0-common
In-Reply-To: <53446D6E.7070909@baker-net.org.uk>
References: <5341C91D.4060007@baker-net.org.uk>
 <1396820569-3841-1-git-send-email-linux@baker-net.org.uk>
 <1396820569-3841-3-git-send-email-linux@baker-net.org.uk>
 <20140408192625.GD29372@lunn.ch> <53446D6E.7070909@baker-net.org.uk>
Message-ID: <53447978.2020206@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Rename the include file kirkwood-nsa310-common.dtsi as
 it is now also used for NSA320. There is also an NSA325
 but that appears not to be as similar so is unlikely to
 want to share an include file.

Signed-off-by: Adam Baker <linux@baker-net.org.uk>
---
I've discovered that if I don't change the git repository but pass the -M option
to git format-patch it generates a patch that describes the rename rather than
deleting and re-adding the entire file.
---
 arch/arm/boot/dts/kirkwood-nsa310.dts                                |    2 +-
 arch/arm/boot/dts/kirkwood-nsa310a.dts                               |    2 +-
 arch/arm/boot/dts/kirkwood-nsa320.dts                                |    2 +-
 .../dts/{kirkwood-nsa310-common.dtsi => kirkwood-nsa3x0-common.dtsi} |    0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/boot/dts/{kirkwood-nsa310-common.dtsi => kirkwood-nsa3x0-common.dtsi} (100%)

diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 372f701..989846a 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-#include "kirkwood-nsa310-common.dtsi"
+#include "kirkwood-nsa3x0-common.dtsi"
 
 / {
 	compatible = "zyxel,nsa310", "marvell,kirkwood-88f6281", "marvell,kirkwood";
diff --git a/arch/arm/boot/dts/kirkwood-nsa310a.dts b/arch/arm/boot/dts/kirkwood-nsa310a.dts
index ead7a36..d0a6025 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310a.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310a.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-#include "kirkwood-nsa310-common.dtsi"
+#include "kirkwood-nsa3x0-common.dtsi"
 
 /*
  * There are at least two different NSA310 designs. This variant does
diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts b/arch/arm/boot/dts/kirkwood-nsa320.dts
index 6c8f692..fc20baf 100644
--- a/arch/arm/boot/dts/kirkwood-nsa320.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
@@ -11,7 +11,7 @@
 
 /dts-v1/;
 
-#include "kirkwood-nsa310-common.dtsi"
+#include "kirkwood-nsa3x0-common.dtsi"
 
 / {
 	model = "Zyxel NSA320";
diff --git a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
rename to arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
-- 
1.7.10.4
