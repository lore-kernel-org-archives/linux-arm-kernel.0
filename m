From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  2 Sep 2016 17:34:50 +0100
Subject: [PATCHv2] ARM: dts: explicitly mark skeleton.dtsi as deprecated
Message-ID: <1472834090-24528-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As noted in commit 3ebee5a2e141496b ("arm64: dts: kill skeleton.dtsi"),
there are a number of problems with skeleton.dtsi, and it would be
prefereable to remove it entirely. As there are a large number of
existing users, fixing these up will take a while.

This patch adds a note to arm's skeleton.dtsi noting that this is the
case, to make this more obvious and hopefully minimize new uptake of
skeleton.dtsi in the mean time.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/boot/dts/skeleton.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

Arnd, Olof, could you please pick this up?

Mark.

Changes since v1 [1]:
* Pick up Rob's Acked-by, with his correct address.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/453144.html

diff --git a/arch/arm/boot/dts/skeleton.dtsi b/arch/arm/boot/dts/skeleton.dtsi
index b41d241..28b81d6 100644
--- a/arch/arm/boot/dts/skeleton.dtsi
+++ b/arch/arm/boot/dts/skeleton.dtsi
@@ -1,4 +1,8 @@
 /*
+ * This file is deprecated, and will be removed once existing users have been
+ * updated. New dts{,i} files should *not* include skeleton.dtsi, and should
+ * instead explicitly provide the below nodes only as required.
+ *
  * Skeleton device tree; the bare minimum needed to boot; just include and
  * add a compatible value.  The bootloader will typically populate the memory
  * node.
-- 
1.9.1
