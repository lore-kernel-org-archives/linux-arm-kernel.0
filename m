Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10191C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:44:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD0A2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nffTlcJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD0A2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EmbYgTmQfiZZhkO7mYWDbYaqvNGlUz3wj91Matd8dpA=; b=nffTlcJCwsur+Fai1sgVqALGII
	kD7qTYD+U+dXJomixK3RGzvmUkend8iIpN8lsPHFUn8oSTErIq4IvVHLN6MVxkikD1ZoJtkE0kaOT
	x+7sxHuN2DKl5mgWtpNPHED8Kt63c6J5n8mfxvlayaxAlPEKQBeQa4QGBHuCoL9giKAFzjEUsBwFp
	Xlf9YRXSuMKW89VTs0nZB2eEmdyC/El9Yw6VkczzewK059cNBo3qvdaoxsRPBoSFikwJfYd6K+l5r
	z1RqVYlMgxr0IOsX6S/q1JWpt7WYzrjL3NmfJPrKJ2QPMQge7duaHR710ue/3HiqCjGVocIL5kVkH
	Tqr7rFPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIee-0006QM-GC; Sat, 12 Jan 2019 12:44:48 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIe3-0005sk-Jd; Sat, 12 Jan 2019 12:44:15 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MsIfc-1hXFfJ1zr8-00tiod; Sat, 12 Jan 2019 13:43:59 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/6] ARM: dts: bcm283x: Fix DTC warning for memory node
Date: Sat, 12 Jan 2019 13:43:23 +0100
Message-Id: <1547297008-2740-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:m5PXnYOzUn8RRTmCqRKOFExPJaNp0DdLxyKAIZf66qbtTC2Kwdn
 VyZLfI2pGBbHMFNiJDHBqHthbnu1WgPUMjcVRzZiWor4kcK3fjheT0306uv9RWpnHlgz2Wu
 8NkKHkDU26kZrrmYbtfKIYc4gJ8uEuvpDmA0nm9m9eiGINW9BBGmH34OB2LzxKRdz3RYQjk
 0Bp99FTc1Evx1XZZmr1vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AZVoUr0OV8c=:l2whGjTRwQ0ijNyYEBfhbh
 jy0bH5tS2EGw9TNEqSEoHoyX0CjVGU7EVi8L4PKR43vq/Yuz0yn2ouIzgoFxOVRQVl2uBasX0
 SlTVk79ECLSyvk/T2hzzdMngzWmYBtPbVzF+tQO4cZgnEHFA7OYQLG714VMuyd6ZPRWwJwQlM
 fCMJjvl0Aw2b57E1+fkUSb9nFNB9R+Z6qxmHSoZifzykeTh6/xtoM5RE5F9ewlR5W/qFcS7ej
 wPca65DjBXdYUv8ghIcuM6SVUF3qStTxY8TFgOCtlTPqTbsWQSkw7B7z3KK4N7MaB9hgo+5rW
 H/VjaHdmoMmswUGgT0VtuD3Tu1hZU4UmoFjaDjsVky6juSgIfZPDoiVyfGLKNgtQq7Dhsk8Us
 ZXc3iviiuQH4GY2PmEFqHAKpjmZNxJyAPqQlETOt7EorAhQLOWVZGZJU4Sokzwz17Jz+J6KC7
 eN++aLE3MBm241/k8YYCoJOEBJIbkesfm3SgdjSGfcjbUS20iqf3moNHMoSRAZdfaYZeIzjbP
 EPhQRsaXunMYLlsipP4/KKupfUdZxBJNljMLofkGn1oJLYjlB1C2aLvXZyYCc6y5h+rHwwH9v
 a38rl9wVLNgyNHuwZAHX+z+V9Kn/UY23/fZj9zHGHn7Mwmn4Ohirr4KAiT2fEmPbyvOMpjXhu
 LvvoCCmISIjlJykgW/jWqeEnUDzgIls+mBe3Vv0F8AvltMyqDbZkzoH/0HXynQy1iJ03tgigu
 5jyRqRJ6efIA3d4hp4dXHw+gd1xkJ49KPkg7US2FA4bRdAc2cOV77VU0sUU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_044412_170065_6199F88A 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: Gottfried Haider <gottfried.haider@gmail.com>, devicetree@vger.kernel.org,
 Stefan Wahren <stefan.wahren@i2se.com>, Phil Elwell <phil@raspberrypi.org>,
 bcm-kernel-feedback-list@broadcom.com, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Compiling the bcm283x DTS with W=1 leads to the following warning:

Warning (unit_address_vs_reg): /memory: node has a reg or ranges property,
but no unit name

Fix this by adding the unit address.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi         | 2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts      | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index c6e2b23..e490f2a 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,7 +1,7 @@
 #include <dt-bindings/power/raspberrypi-power.h>
 
 / {
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0 0x10000000>;
 	};
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index ac4408b..871fc4a 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -9,7 +9,7 @@
 	compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
 	model = "Raspberry Pi 2 Model B";
 
-	memory {
+	memory@0 {
 		reg = <0 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
index e9fadd3..7f4437a 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
@@ -13,7 +13,7 @@
 		stdout-path = "serial1:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
index 42bb090..7d65013 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
@@ -14,7 +14,7 @@
 		stdout-path = "serial1:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index 0c155dd..9abb9c5 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -14,7 +14,7 @@
 		stdout-path = "serial1:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi b/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
index 4a89a18..81399b2 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
+++ b/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
@@ -4,7 +4,7 @@
 #include "bcm2836-rpi.dtsi"
 
 / {
-	memory {
+	memory@0 {
 		reg = <0 0x40000000>;
 	};
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
