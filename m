From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 19 Dec 2016 11:44:40 -0300
Subject: [PATCH 8/9] ARM: dts: dm816x: Add an empty chosen node to top level
 DTSI
In-Reply-To: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
References: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1482158681-4530-9-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 06bfb9c19957 ("ARM: dts: dm816x: Remove skeleton.dtsi usage")
removed the skeleton.dtsi usage since we want to get rid of it.

But this can cause issues when booting a kernel with a boot-loader
that doesn't create a chosen node if this isn't present in the DTB
since the decompressor relies on a pre-existing chosen node to be
available to insert the command line and merge other ATAGS info.

Fixes: 06bfb9c19957 ("ARM: dts: dm816x: Remove skeleton.dtsi usage")
Reported-by: Pali Rohar <pali.rohar@gmail.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/dm816x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 61dd2f6b02bc..6db652ae9bd5 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -12,6 +12,7 @@
 	interrupt-parent = <&intc>;
 	#address-cells = <1>;
 	#size-cells = <1>;
+	chosen { };
 
 	aliases {
 		i2c0 = &i2c1;
-- 
2.7.4
