Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A9DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:51:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA7F21929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kzgrdYJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA7F21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4ErN4RxL++SmtUQ32rFmF435wCPdUe6VubWnKqCmS7Y=; b=kzgrdYJeqvpPObSkhLDLB+miWl
	XqJmsvJHkcJ3e+KZm6G1Bd62tAvbiSZp/tAba0xKZBipGzhiWJXm8pzCDA4telDUjnh9rBSc1C3yQ
	H9Z2tmD+MWivk2ThVbGCoiIVl4xjZlKa7r4VmckVS43XZAGUj2PhA0pG4eTmr7DSkv46KJetWQuDt
	CNFHV3R1EHBK/bpuBxwTrBM+9hPwy4mhOBeN1RjgvcL9rVmd64xE8jN+MpINiul6+PDBjFR3XADU0
	1o7wz3r9dvNBTk33bS2IwVX3yVR7w1nOk41ke5oHg3pLuAJ322kug8uwbVsedxE8lWzt81YHg34lO
	1xZNbQjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guc1z-0008I0-9Z; Fri, 15 Feb 2019 11:51:47 +0000
Received: from olimex.com ([184.105.72.32])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guc1G-0007XA-MK
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 11:51:14 +0000
Received: from localhost.localdomain ([195.238.85.143])
 by olimex.com with ESMTPSA
 (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD)
 (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 15 Feb 2019 03:50:45 -0800
From: Stefan Mavrodiev <stefan@olimex.com>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Lee Jones <lee.jones@linaro.org>,
 linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), 
 linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC DEVICE
 DRIVERS), 
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC
 support)
Subject: [PATCH v2 3/8] dt-bindings: leds: Add binding for axp20x-led device
 driver
Date: Fri, 15 Feb 2019 13:50:08 +0200
Message-Id: <20190215115013.11098-4-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215115013.11098-1-stefan@olimex.com>
References: <20190215115013.11098-1-stefan@olimex.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_035103_289267_6183C07F 
X-CRM114-Status: GOOD (  10.82  )
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
Cc: Stefan Mavrodiev <stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the devicetree bindings for charge led indicator found
on most of X-Powers AXP20X PMICs.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 .../devicetree/bindings/leds/leds-axp20x.txt  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-axp20x.txt b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
new file mode 100644
index 000000000000..5a83ad06796d
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
@@ -0,0 +1,74 @@
+Device Tree Bindings for LED support on X-Powers PMIC
+
+Most of the X-Powers PMICs have integrated battery charger with LED indicator.
+The output is open-drain, so the state is either high-Z or output-low. The
+driver is a subnode of AXP20X MFD driver, since it uses shared bus with all
+other cells.
+The LED can be controlled either manually or automatically. Then in automatic
+(controlled by the charger) there are two indication modes:
+
+Mode-A
+======
+- output-low:		Charging
+- high-Z		Not charging
+- 1Hz flashing:		Abnormal alarm
+- 4Hz flashing		Overvoltage alarm
+
+Mode-B
+======
+- output-low:		Battery full
+- high-Z		Not charging
+- 1Hz flashing:		Charging
+- 4Hz flashing		Overvoltage or abnormal alarm
+
+The control and the mode can be changed from sysfs.
+
+For AXP20X MFD bindings see:
+Documentation/devicetree/bindings/mfd/axp20x.txt
+
+Required properties:
+- compatible : Must be "x-powers,axp20x-led"
+
+Supported common LED properties, see ./common.txt for more informationn
+- label : See Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
+- default-state: See Documentation/devicetree/bindings/leds/common.txt
+
+Optional properties:
+- x-powers,charger-mode: 0 for Mode-A, 1 for Mode-B
+			 If omitted, then the control is set to manual mode.
+			 On invalid value, Mode-A is used.
+
+
+Example:
+
+	axp803: pmic@3a3 {
+		compatible = "x-powers,axp803";
+
+		...
+
+		led@0 {
+			compatible = "x-powers,axp20x-led";
+			status = "okay";
+
+			label = "axp20x:yellow:chgled";
+			linux,default-trigger = "timer";
+			default-state = "on";
+		};
+	};
+
+or
+
+	axp803: pmic@3a3 {
+		compatible = "x-powers,axp803";
+
+		...
+
+		led@0 {
+			compatible = "x-powers,axp20x-led";
+			status = "okay";
+
+			label = "axp20x:yellow:chgled";
+			x-powers,charger-mode = <1>;
+		};
+	};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
