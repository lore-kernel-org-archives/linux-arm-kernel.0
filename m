Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A53C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A422081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMkjwYYi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ii0NZecZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A422081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mznTWh00cQSZmJTITY1lizCmDYFLs7SUmADg7LjGBNY=; b=BMkjwYYiGB0iKQ
	anAlxNNEgK7cV3Xp9qihn20PVQI3ewoa86BLEbNNDm6NR/8A1aENTF/TqCFr8A+Q1fP5Ww2wNVUqF
	lPU4fpVW/POfFhkH5q4cnv11k/aeHhzrO5YV82f1MJaZw/huGudRQqj6CujW54//JCppOM2cKMMXA
	fjIEWvEy2xvkUGDZg30l/tOkaMTDrQBTy/ArshgGAYRFFdV6xQBAXCEx32DuKfJrQt+QtFCHBCeg+
	Y0PQP39iDs2Gk49QkvVcYD1BNf2L8TdYX9VYic8K7TvQPNnvWO7ZWj6K34HmT67UMTkzz9/kRf/bw
	Ws1fOuJqdo+wNGvlhuAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZVv-0004I2-Dn; Sun, 02 Dec 2018 21:42:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZVg-0003wX-QT
 for linux-arm-kernel@bombadil.infradead.org; Sun, 02 Dec 2018 21:42:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SSJcnJIlvA4z4mukhMH1EJTr/0iElpSHaSOrD3HzAZg=; b=ii0NZecZLH3i0V8Bx/Lvo1X48x
 QcXojF1kVq/x7j0g6I/OBa4+5DFFc8C6RDOrh3rQnE2eIlWNMOEvbuECj6S+Eq2Sn3Mh7GRsTKfg3
 UuT+vZOc282W18wbNA9OyaSKy3DSaLStPlLLtE3EH6t9cbWsHqQ2W0kWnoFCYH/ZOOUgh7jIqW0+w
 pBU2sETbRl0GcNL5Ui2cUpYi0sd4nn2ePCdUBXPZ8rp2rLHk6uRR0SwWq6fixcaJJErinzuCzzaVX
 MSWVEqQfwe3QkpVJsUoyxGpPMlOQgpNiggxHyDwVn0f6mh1PWVD4uXVgRM3cn8lEAYVpyEw2aaB/w
 +mhi27rg==;
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZFw-0001XY-JZ
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:26:26 +0000
Received: by mail-qk1-f193.google.com with SMTP id 189so6216246qkj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=SSJcnJIlvA4z4mukhMH1EJTr/0iElpSHaSOrD3HzAZg=;
 b=JOUjmfDbFm0bsfS6/hpw1lAPykCWeIwGutApGWbtL7IQtILh371Q78aU2BSASu4K5v
 jC5TYTZqZiTpS/PlOxJv+knqWIA3QQ9nAzTG/kdwXrxcgFTApW49HNb+iEPN280elfqt
 U3zvpB9w5+C74dbgbJu4iZin9dng8ZFZ4nD/qDRFebFQwDjANKB/9dt6ekGRUVL6F4zP
 Y5eSburg1jwjvRTZ1H5/XTmDL8+s6J6g4cCgKtbl0HzOjI3m56cZAIGXzj+4YF9BMQ7J
 S8v8zQEUSlYbvIBmSVFc5224x5KgO5qYzU3tvSegUmr7W6zMItdgrcbbg+0slhXUD4y0
 ASoQ==
X-Gm-Message-State: AA+aEWaTY6z7IgvC1iJbFjO/eRnyTpITZzS9Eh9HPtA43dg5+EDoHx2p
 oo1acAx/rRKRlC+L0k3B39FuRM3T
X-Google-Smtp-Source: AFSGD/UU7E+CEOKGvU9LmjKiLwMWvJTFo6OgPGEo9uSi8ADcHcxaK9h3Rq/du2jaYVq2eN1++HWvrQ==
X-Received: by 2002:a37:d91:: with SMTP id 139mr13066177qkn.26.1543785972922; 
 Sun, 02 Dec 2018 13:26:12 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id s9sm7408116qta.35.2018.12.02.13.26.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:26:12 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:26:06 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/9] ARM: dts: imx7d-pico: Improve WiFi regulator name
Date: Sun,  2 Dec 2018 19:25:17 -0200
Message-Id: <20181202212520.16650-7-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_212624_635031_FC88FF33 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are different models of WiFi being used in the SoM and the
handle name was too restrictive. This reworks it to a more generic and
meaningful name.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx7d-pico.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 35791a1adabf..417f034fb354 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -13,11 +13,11 @@
 		reg = <0x80000000 0>;
 	};
 
-	reg_ap6212: regulator-ap6212 {
+	reg_wlreg_on: regulator-wlreg_on {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_ap6212>;
-		regulator-name = "AP6212";
+		pinctrl-0 = <&pinctrl_reg_wlreg_on>;
+		regulator-name = "wlreg_on";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio4 16 GPIO_ACTIVE_HIGH>;
@@ -241,7 +241,7 @@
 	non-removable;
 	keep-power-in-suspend;
 	wakeup-source;
-	vmmc-supply = <&reg_ap6212>;
+	vmmc-supply = <&reg_wlreg_on>;
 	mmc-pwrseq = <&usdhc2_pwrseq>;
 	status = "okay";
 };
@@ -302,7 +302,7 @@
 		>;
 	};
 
-	pinctrl_reg_ap6212: regap6212grp {
+	pinctrl_reg_wlreg_on: regregongrp {
 		fsl,pins = <
 			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x59
 		>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
