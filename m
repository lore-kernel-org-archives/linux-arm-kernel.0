Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFC0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:31:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384AC2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BY+9LPx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384AC2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VvOaT9NF0qhOr2gfItgx/ual1I4pqird2uuCWSFqtJ0=; b=BY+9LPx668ZYf5
	Fu2eISu46HXPUsfhY9eC10Nff5LYVYcl8F1FBMoeevZqs3g99L1G2h5oD5wF+rjucZW3u8M8/fOHt
	AzWT8314a+d+Ux4D27G3wJOz7LNa1i3NX748BO0bDEIWjrKwh7GW9OnaD5XWeJopGpOhZ1ITNA4vs
	OK0J8jAUOkqYUpoWn6OlGxh994o1UhNy+JgbYQ3uzFMUFPY8ooeOqsoYoghLnLefolFbJIM8s4BU7
	7JW+0Opwf91Y/d/msWkpmnr0fClt3AYJojloMu9FCZKae80s3P2zKFpa0C4hEfTkazHWTwBzC2DyK
	hHsCm9rEqqD8x8WQ9M8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufSG-0002h3-6E; Fri, 15 Feb 2019 15:31:08 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufSD-0002gH-1Q
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:31:07 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3B55EE0004;
 Fri, 15 Feb 2019 15:30:50 +0000 (UTC)
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>
Subject: [PATCH] ARM: dts: armada-xp: fix Armada XP boards NAND description
Date: Fri, 15 Feb 2019 16:30:42 +0100
Message-Id: <20190215153042.8973-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_073105_377573_70E4FC84 
X-CRM114-Status: GOOD (  10.06  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 3b79919946cd2cf4dac47842afc9a893acec4ed7 ("ARM: dts:
armada-370-xp: update NAND node with new bindings") updated some
Marvell Armada DT description to use the new NAND controller bindings,
but did it incorrectly for a number of boards: armada-xp-gp,
armada-xp-db and armada-xp-lenovo-ix4-300d. Due to this, the NAND is
no longer detected on those platforms.

This commit fixes that by properly using the new NAND DT binding. This
commit was runtime-tested on Armada XP GP, the two other platforms are
only compile-tested.

Fixes: 3b79919946cd2 ("ARM: dts: armada-370-xp: update NAND node with new bindings")
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/arm/boot/dts/armada-xp-db.dts            | 46 +++++-----
 arch/arm/boot/dts/armada-xp-gp.dts            | 13 +--
 .../boot/dts/armada-xp-lenovo-ix4-300d.dts    | 85 ++++++++++---------
 3 files changed, 76 insertions(+), 68 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index f3ac7483afed..5d04dc68cf57 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -144,30 +144,32 @@
 				status = "okay";
 			};
 
-			nand@d0000 {
+			nand-controller@d0000 {
 				status = "okay";
-				label = "pxa3xx_nand-0";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				nand-on-flash-bbt;
-
-				partitions {
-					compatible = "fixed-partitions";
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					partition@0 {
-						label = "U-Boot";
-						reg = <0 0x800000>;
-					};
-					partition@800000 {
-						label = "Linux";
-						reg = <0x800000 0x800000>;
-					};
-					partition@1000000 {
-						label = "Filesystem";
-						reg = <0x1000000 0x3f000000>;
 
+				nand@0 {
+					reg = <0>;
+					label = "pxa3xx_nand-0";
+					nand-rb = <0>;
+					nand-on-flash-bbt;
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						partition@0 {
+							label = "U-Boot";
+							reg = <0 0x800000>;
+						};
+						partition@800000 {
+							label = "Linux";
+							reg = <0x800000 0x800000>;
+						};
+						partition@1000000 {
+							label = "Filesystem";
+							reg = <0x1000000 0x3f000000>;
+						};
 					};
 				};
 			};
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 1139e9469a83..b4cca507cf13 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -160,12 +160,15 @@
 				status = "okay";
 			};
 
-			nand@d0000 {
+			nand-controller@d0000 {
 				status = "okay";
-				label = "pxa3xx_nand-0";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				nand-on-flash-bbt;
+
+				nand@0 {
+					reg = <0>;
+					label = "pxa3xx_nand-0";
+					nand-rb = <0>;
+					nand-on-flash-bbt;
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index bbbb38888bb8..87dcb502f72d 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -81,49 +81,52 @@
 
 			};
 
-			nand@d0000 {
+			nand-controller@d0000 {
 				status = "okay";
-				label = "pxa3xx_nand-0";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				nand-on-flash-bbt;
-
-				partitions {
-					compatible = "fixed-partitions";
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					partition@0 {
-						label = "u-boot";
-						reg = <0x00000000 0x000e0000>;
-						read-only;
-					};
-
-					partition@e0000 {
-						label = "u-boot-env";
-						reg = <0x000e0000 0x00020000>;
-						read-only;
-					};
-
-					partition@100000 {
-						label = "u-boot-env2";
-						reg = <0x00100000 0x00020000>;
-						read-only;
-					};
-
-					partition@120000 {
-						label = "zImage";
-						reg = <0x00120000 0x00400000>;
-					};
-
-					partition@520000 {
-						label = "initrd";
-						reg = <0x00520000 0x00400000>;
-					};
 
-					partition@e00000 {
-						label = "boot";
-						reg = <0x00e00000 0x3f200000>;
+				nand@0 {
+					reg = <0>;
+					label = "pxa3xx_nand-0";
+					nand-rb = <0>;
+					nand-on-flash-bbt;
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						partition@0 {
+							label = "u-boot";
+							reg = <0x00000000 0x000e0000>;
+							read-only;
+						};
+
+						partition@e0000 {
+							label = "u-boot-env";
+							reg = <0x000e0000 0x00020000>;
+							read-only;
+						};
+
+						partition@100000 {
+							label = "u-boot-env2";
+							reg = <0x00100000 0x00020000>;
+							read-only;
+						};
+
+						partition@120000 {
+							label = "zImage";
+							reg = <0x00120000 0x00400000>;
+						};
+
+						partition@520000 {
+							label = "initrd";
+							reg = <0x00520000 0x00400000>;
+						};
+
+						partition@e00000 {
+							label = "boot";
+							reg = <0x00e00000 0x3f200000>;
+						};
 					};
 				};
 			};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
