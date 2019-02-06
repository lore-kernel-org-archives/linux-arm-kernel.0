Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF549C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:33:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7492081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yqw1xyR3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxo0DPSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7492081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5n6UYfgjpK90ncwDQDUcFxTnVQiM0ddsAv2Y0vQ+Egs=; b=Yqw1xyR3AtUZ3J
	hpwm4gFCrAsTxVMRcEynXnA4yQds7J6p9zj7s6gzIHI+93QZ2IAPWuuI8JFeMPxsrD+t5Yz36DReJ
	nx6YXe/4fd1MmXm9BFCas7+eKQYu7Q5dHUtvj37YYvcaoczedzxska/bimBTpVnEjgbhSBtXoH8F2
	2ww/frPDX6q4cO7TkEaoUc/mOlo7PSE6/foEEiOFYpz4TL72UUFFafEEvG+gWzSkW5EMpvbbNqAUO
	htzmFw3c5Rlb7HrgAwCW/l2SQRGRtX8j4I52Uj09lyzxERKzSO+ccI9xt9ON4cfoZfbaF0Xkc4Ccb
	bw0lwI57S5YBYTWRqI2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grPCD-0003SH-2t; Wed, 06 Feb 2019 15:33:05 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grPC8-0003Rm-GP
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 15:33:03 +0000
Received: by mail-lj1-x243.google.com with SMTP id v14-v6so3642614ljv.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 07:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9HWf7hUgZh6GIFRMufOwE+uKd6NEJBNzajxfUgCI2cM=;
 b=cxo0DPSNn8stamen6WhwIv3zX86XRg+9930fbKrefnz0bJ/hjS+g4d3qLmefhYR9mZ
 yf020WVRim6CsCm3iwTb8nXMc5c9Eal1OPRYqL63eA/EGDvKL6N3yV33TpYMnfGp6YDE
 WB4obuqHDXF8vIgpH2ofSZAcEz6MgvicbZkK+F7dfRCfo9mdmzqJ2URW8oap8q7jj7lM
 A1so2EAggPqlp26C0AZbuMukVtfhQVP5PpTHhNIANfKKikAJrIbvWeDUEa6c4tu2o3MC
 o/OCnkSiK1+EioycQFWvLPuHKkp1WaYbNLUxkXbT4OIBlzSpNfzjLotpQ8JZ8TJCrMVy
 LWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9HWf7hUgZh6GIFRMufOwE+uKd6NEJBNzajxfUgCI2cM=;
 b=hsj7+pzbt9YDW+JsIxxMIKAt7Ry5xxyAXAt5GOVGSA5y1wAyiijc+ChCnkN17bCdbt
 pxX+MC0p0Is6eoG7HdkmzZs5pgQ4S0fm2JoeEyprli8r9Y+kiyPyqrhb+RXSrN/zWBGx
 wPxqQyrl4dG4q33i6XQG4XDHXYsFe1pP/G7sDSZdgCOrHHBPpNgQ71UL65YEUhANL+a4
 mlSmwWbT6XJJaXOdYa0NNDCiDm70F9l2SazzT3j4qn29rFhvDjtmKEuLKDD0wf0fhfgZ
 sqAUd9TfWjPSTj50OkGNH4+Lj25cTu85h+GEkxe4FNMsmfUBv9UleTQB50hyB3qZhHbf
 iuyA==
X-Gm-Message-State: AHQUAuZE7XKqfhBdoSvc3ZDeFo4P0vcnpAMVBOpyXUI67a9vQ6OlHgcv
 ljzC+JskTBzK66IO7ajDuCF0Rg==
X-Google-Smtp-Source: AHgI3Ibd1jaZJlKhRFZcBqMZzXaAu25p0sJrt1IlS940IAP4geo18XOD6RG9rsXyQdMsOTDPD2sGLA==
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr6624228lja.44.1549467177474; 
 Wed, 06 Feb 2019 07:32:57 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id d3sm2660180lfj.39.2019.02.06.07.32.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 07:32:56 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>
Subject: [PATCH] ARM: dts: qcom-apq8060: Fix up interrupt parents
Date: Wed,  6 Feb 2019 16:32:50 +0100
Message-Id: <20190206153250.16495-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_073300_569381_6E1D520F 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Brian Masney <masneyb@onstation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Before we fixed up the interrupt hierarchy for the SSBI
GPIO controller, we had to use the PM8058 directly to pick
interrupts. After making the interrupt controller work properly,
we can reference the real interrupt parent.

Cc: Brian Masney <masneyb@onstation.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Brian: please include this at the end of your series.
---
 .../arm/boot/dts/qcom-apq8060-dragonboard.dts | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 497bb065eb9d..4e6c50d45cb2 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -93,9 +93,8 @@
 		vdd-supply = <&pm8058_l14>; // 2.85V
 		aset-gpios = <&pm8058_gpio 35 GPIO_ACTIVE_LOW>;
 		capella,aset-resistance-ohms = <100000>;
-		/* GPIO34 has interrupt 225 on the PM8058 */
 		/* Trig on both edges - getting close or far away */
-		interrupts-extended = <&pm8058 225 IRQ_TYPE_EDGE_BOTH>;
+		interrupts-extended = <&pm8058_gpio 34 IRQ_TYPE_EDGE_BOTH>;
 		/* MPP05 analog input to the XOADC */
 		io-channels = <&xoadc 0x00 0x05>;
 		io-channel-names = "aout";
@@ -515,9 +514,8 @@
 				ak8975@c {
 					compatible = "asahi-kasei,ak8975";
 					reg = <0x0c>;
-					/* FIXME: GPIO33 has interrupt 224 on the PM8058 */
-					interrupt-parent = <&pm8058>;
-					interrupts = <224 IRQ_TYPE_EDGE_RISING>;
+					interrupt-parent = <&pm8058_gpio>;
+					interrupts = <33 IRQ_TYPE_EDGE_RISING>;
 					pinctrl-names = "default";
 					pinctrl-0 = <&dragon_ak8975_gpios>;
 					vid-supply = <&pm8058_lvs0>; // 1.8V
@@ -526,9 +524,8 @@
 				bmp085@77 {
 					compatible = "bosch,bmp085";
 					reg = <0x77>;
-					/* FIXME: GPIO16 has interrupt 207 on the PM8058 */
-					interrupt-parent = <&pm8058>;
-					interrupts = <207 IRQ_TYPE_EDGE_RISING>;
+					interrupt-parent = <&pm8058_gpio>;
+					interrupts = <16 IRQ_TYPE_EDGE_RISING>;
 					reset-gpios = <&tlmm 86 GPIO_ACTIVE_LOW>;
 					pinctrl-names = "default";
 					pinctrl-0 = <&dragon_bmp085_gpios>;
@@ -539,12 +536,11 @@
 					compatible = "invensense,mpu3050";
 					reg = <0x68>;
 					/*
-					 * GPIO17 has interrupt 208 on the
-					 * PM8058, it is pulled high by a 10k
+					 * GPIO17 is pulled high by a 10k
 					 * resistor to VLOGIC so needs to be
 					 * active low/falling edge.
 					 */
-					interrupts-extended = <&pm8058 208 IRQ_TYPE_EDGE_FALLING>;
+					interrupts-extended = <&pm8058_gpio 17 IRQ_TYPE_EDGE_FALLING>;
 					pinctrl-names = "default";
 					pinctrl-0 = <&dragon_mpu3050_gpios>;
 					vlogic-supply = <&pm8058_lvs0>; // 1.8V
@@ -589,11 +585,10 @@
 				compatible = "smsc,lan9221", "smsc,lan9115";
 				reg = <2 0x0 0x100>;
 				/*
-				 * GPIO7 has interrupt 198 on the PM8058
 				 * The second interrupt is the PME interrupt
 				 * for network wakeup, connected to the TLMM.
 				 */
-				interrupts-extended = <&pm8058 198 IRQ_TYPE_EDGE_FALLING>,
+				interrupts-extended = <&pm8058_gpio 7 IRQ_TYPE_EDGE_FALLING>,
 						    <&tlmm 29 IRQ_TYPE_EDGE_RISING>;
 				reset-gpios = <&tlmm 30 GPIO_ACTIVE_LOW>;
 				vdd33a-supply = <&dragon_veth>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
