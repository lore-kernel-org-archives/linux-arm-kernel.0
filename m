Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2D1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:25:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E0320661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QnEuECYP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqY2imP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E0320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lfgm8ASS9ocDwGz3r3K9pBWMN+eBWEdT47pMkMciVTU=; b=QnEuECYPDecpWX
	G8mr/SAzS3DfHpTQjA034amHtsV2MtJH6++sPoXD2KCjROD3nJxuoIolbaMC1ViN9lz5a+WwaalXu
	eoZZg66lxqyr7KeRvR3AkA8tK700UevSd39blfwoW2EH09sv+5vBzHpkUNSyAQyMo6mMPzDJ7N2Hp
	PZVWefRju86boVwSM58lcRcmpHwNsRgE6Sy8sylUPxJAZaXe0RepZfFcL+fYgQOR9OdcfBQn2y9ei
	eMehxUCaIy3oHbWMdHuIOq2POWQA7Ps3MTxDl/SEM8yz32M5l6ejVppz/C2kh8rfTQ0ZHgWRxL65H
	qYER8NFztsG8zORI2QHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVl2U-0006nA-MA; Sat, 08 Dec 2018 22:25:34 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVl0O-0003LW-0B
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 22:23:33 +0000
Received: by mail-lf1-x144.google.com with SMTP id p86so5461438lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SXLqZDlfykCHPKFucxFJPc50KKjUz6UX5Nb1b4FXJ2w=;
 b=BqY2imP7sYwWoF/7Xeael0aIxqyOD/Z3UH9rKjP+Cbbxk9Ac89brCMCI1We0Z9MhES
 ug8XCRTiGOKzQRV+vUSsKyhkq6SfP9T6ZhRwgfeAcVFGkbORKw5MoXkmWZUFidBJ58AH
 gnfRFLx0IsCnbodMpnekQBSNu+/bT0flDxVbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SXLqZDlfykCHPKFucxFJPc50KKjUz6UX5Nb1b4FXJ2w=;
 b=SAoLOHqUKShOVjQvyAEqMkWnKB7THjsF4eywLG5Uo1tukegftga04STSF+D2yJiJgV
 G4zYFSb01WJUy2i08gmC9jJWSpGiDBxFPhKtSPhWjZxdgaf3fuhmf8+q30EzPFZZMTx8
 MG21HOQjPOD1ftAMOmnGaIjhE7eJwykf49fSVX3wRgPckHZVO9HCYoRc34PXiz3maAgu
 c3lHKNF/whcdxIU1jIlUEw91EhUuK2TiJbwo6kkMEUI/A9lNc0H4MkvyXmCL3HzRirWI
 ZmI1H9Ydg86dr252iFnn+aANzYnhyjEuWfduZXMGTmBKY7w+BVCS7jbf4AzyhAvhBCCn
 IR/A==
X-Gm-Message-State: AA+aEWaym4yCtiTTkxk2GzejrjhgS61+ZJgJfzWf15nox/b8gmCypazY
 wIpwALfiDf91r9PaStBXx8byFspgToh0Zw==
X-Google-Smtp-Source: AFSGD/U+bP4S/3y17CaTzHOQ90AaE85QwGSKMAegg+LFlMOxtGGxqiGDsM5AhdTZDH5+oPxLnR4n7A==
X-Received: by 2002:a19:cd50:: with SMTP id d77mr3810048lfg.125.1544307790825; 
 Sat, 08 Dec 2018 14:23:10 -0800 (PST)
Received: from localhost.bredbandsbolaget
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id b69sm1310884lfl.28.2018.12.08.14.23.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 08 Dec 2018 14:23:09 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/5] ARM: dts: Enable Gemini flash access
Date: Sat,  8 Dec 2018 23:22:58 +0100
Message-Id: <20181208222301.5303-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208222301.5303-1-linus.walleij@linaro.org>
References: <20181208222301.5303-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_142324_103006_605D4057 
X-CRM114-Status: GOOD (  21.12  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
 LEDE Development List <openwrt-devel@lists.openwrt.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some Gemini platforms have a parallel NOR flash which conflicts
with use cases reusing some of the flash lines (such as CE1)
for GPIO.

Fix this on the D-Link DIR-685 and Itian SQ201 by creating
"enabled" and "disabled" states for the flash pin control
handle, and rely on the flash handling code to switch this
in and out when accessed so these lines can be used
for GPIO when flash is not accessed, and enable flash
access.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 35 +++++++++++++++-------
 arch/arm/boot/dts/gemini-sq201.dts         | 31 ++++++++++---------
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index 502a361d1fe9..318e9b2ba7dc 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -64,7 +64,6 @@
 		gpio-sck = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		gpio-miso = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		gpio-mosi = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-		/* Collides with pflash CE1, not so cool */
 		cs-gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 
@@ -253,15 +252,18 @@
 	soc {
 		flash@30000000 {
 			/*
-			 * Flash access is by default disabled, because it
-			 * collides with the Chip Enable signal for the display
-			 * panel, that reuse the parallel flash Chip Select 1
-			 * (CS1). Enabling flash makes graphics stop working.
-			 *
-			 * We might be able to hack around this by letting
-			 * GPIO poke around in the flash controller registers.
+			 * Flash access collides with the Chip Enable signal for
+			 * the display panel, that reuse the parallel flash Chip
+			 * Select 1 (CS1). We switch the pin control state so we
+			 * enable these pins for flash access only when we need
+			 * then, and when disabled they can be used for GPIO which
+			 * is what the display panel needs.
 			 */
-			/* status = "okay"; */
+			status = "okay";
+			pinctrl-names = "enabled", "disabled";
+			pinctrl-0 = <&pflash_default_pins>;
+			pinctrl-1 = <&pflash_disabled_pins>;
+
 			/* 32MB of flash */
 			reg = <0x30000000 0x02000000>;
 
@@ -327,7 +329,6 @@
 						"gpio0cgrp",
 						"gpio0egrp",
 						"gpio0fgrp",
-						"gpio0ggrp",
 						"gpio0hgrp";
 					};
 				};
@@ -342,6 +343,18 @@
 						groups = "gpio1bgrp";
 					};
 				};
+				/*
+				 * These GPIO groups will be mapped in over some
+				 * of the flash pins when the flash is not in
+				 * active use.
+				 */
+				pflash_disabled_pins: pinctrl-pflash-disabled {
+					mux {
+						function = "gpio0";
+						groups = "gpio0ggrp", "gpio0igrp", "gpio0jgrp",
+							 "gpio0kgrp";
+					};
+				};
 				pinctrl-gmii {
 					mux {
 						function = "gmii";
@@ -430,7 +443,7 @@
 		};
 
 		display-controller@6a000000 {
-			status = "okay";
+			status = "disabled";
 
 			port@0 {
 				reg = <0>;
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index 3787cf3763c4..af4be6ecb02c 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -41,14 +41,12 @@
 		compatible = "gpio-leds";
 		led-green-info {
 			label = "sq201:green:info";
-			/* Conflict with parallel flash */
 			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 		led-green-usb {
 			label = "sq201:green:usb";
-			/* Conflict with parallel and NAND flash */
 			gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 			linux,default-trigger = "usb-host";
@@ -126,15 +124,10 @@
 
 	soc {
 		flash@30000000 {
-			/*
-			 * Flash access can be enabled, with the side effect
-			 * of disabling access to GPIO LED on GPIO0[20] which
-			 * reuse one of the parallel flash chip select lines.
-			 * Also the default firmware on the machine has the
-			 * problem that since it uses the flash, the two LEDS
-			 * on the right become numb.
-			 */
-			/* status = "okay"; */
+			status = "okay";
+			pinctrl-names = "enabled", "disabled";
+			pinctrl-0 = <&pflash_default_pins>;
+			pinctrl-1 = <&pflash_disabled_pins>;
 			/* 16MB of flash */
 			reg = <0x30000000 0x01000000>;
 
@@ -184,9 +177,7 @@
 					mux {
 						function = "gpio0";
 						groups = "gpio0fgrp",
-						"gpio0ggrp",
-						"gpio0hgrp",
-						"gpio0kgrp";
+						"gpio0hgrp";
 					};
 				};
 				/*
@@ -199,6 +190,18 @@
 						groups = "gpio1dgrp";
 					};
 				};
+				/*
+				 * These GPIO groups will be mapped in over some
+				 * of the flash pins when the flash is not in
+				 * active use.
+				 */
+				pflash_disabled_pins: pinctrl-pflash-disabled {
+					mux {
+						function = "gpio0";
+						groups = "gpio0ggrp", "gpio0igrp", "gpio0jgrp",
+							 "gpio0kgrp";
+					};
+				};
 				pinctrl-gmii {
 					mux {
 						function = "gmii";
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
