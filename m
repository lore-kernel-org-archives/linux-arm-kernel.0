From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 19 Dec 2016 11:44:41 -0300
Subject: [PATCH 9/9] ARM: dts: dra7: Add an empty chosen node to top level DTSI
In-Reply-To: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
References: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1482158681-4530-10-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 55871eb6e2cc ("ARM: dts: dra7: Remove skeleton.dtsi usage")
removed the skeleton.dtsi usage since we want to get rid of it.

But this can cause issues when booting a kernel with a boot-loader
that doesn't create a chosen node if this isn't present in the DTB
since the decompressor relies on a pre-existing chosen node to be
available to insert the command line and merge other ATAGS info.

Fixes: 55871eb6e2cc ("ARM: dts: dra7: Remove skeleton.dtsi usage")
Reported-by: Pali Rohar <pali.rohar@gmail.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/dra7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index addb7530cfbe..1faf24acd521 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -18,6 +18,7 @@
 
 	compatible = "ti,dra7xx";
 	interrupt-parent = <&crossbar_mpu>;
+	chosen { };
 
 	aliases {
 		i2c0 = &i2c1;
-- 
2.7.4
