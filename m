From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 19 Dec 2016 11:44:38 -0300
Subject: [PATCH 6/9] ARM: dts: am4372: Add an empty chosen node to top level
 DTSI
In-Reply-To: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
References: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1482158681-4530-7-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 75813028bbd7 ("ARM: dts: am4372: Remove skeleton.dtsi usage")
removed the skeleton.dtsi usage since we want to get rid of it.

But this can cause issues when booting a kernel with a boot-loader
that doesn't create a chosen node if this isn't present in the DTB
since the decompressor relies on a pre-existing chosen node to be
available to insert the command line and merge other ATAGS info.

Fixes: 75813028bbd7 ("ARM: dts: am4372: Remove skeleton.dtsi usage")
Reported-by: Pali Rohar <pali.rohar@gmail.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ac55f93fc91e..2df9e6050c2f 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -16,6 +16,7 @@
 	interrupt-parent = <&wakeupgen>;
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen { };
 
 	memory at 0 {
 		device_type = "memory";
-- 
2.7.4
