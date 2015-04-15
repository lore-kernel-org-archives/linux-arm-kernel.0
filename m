From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 15 Apr 2015 12:40:47 +0200
Subject: [PATCH] ARM: mvebu: armada-xp-openblocks-ax3-4: Disable internal RTC
Message-ID: <1429094447-4324-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no crystal connected to the internal RTC on the Open Block
AX3. So let's disable it in order to prevent the kernel probing the
driver uselessly. Eventually this patches removes the following
warning message from the boot log:
"rtc-mv d0010300.rtc: internal RTC not ticking"

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.8 +
---
Hi,

I plan to add this patch to mvebu/fixes once the v4.1-rc1 will be
released. I don't expect much comments about it, but there is time
for them if needed until the next PR.

Thanks,

Gregory


 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 0c76d9f05fd0..f4838ebd918b 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -105,6 +105,10 @@
 		};
 
 		internal-regs {
+			rtc at 10300 {
+				/* No crystal connected to the internal RTC */
+				status = "disabled";
+			};
 			serial at 12000 {
 				status = "okay";
 			};
-- 
2.1.0
