Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF39C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:41:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B4C20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K0d6Hjub";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swn7pd6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B4C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=x2ZRIDRTZdMZl/9vp/xy4y+4LNVnJKJL3k9LaewDmGw=; b=K0d
	6HjubEgz2hR80fK5ZuJkporyJ2E72qmOGlpTOlb0jQyH5nBpux+QfFuAG71w2kLNAqgafcgC/XbN9
	ttPZVLpXRc9/ksASnROI3qj+WRFxJkT7u8lTTZpELyWN+qAyBaWEHuag591g4psCMrtaFlSDzWG1u
	xZxRDxwsDPLh1X94HbJXZzy7OwqaJY0GFRrkRdMk+mGyOIbjYhUSuQ/E2Sjlc92jxPtWSZEP+RDXU
	WLueN1Iw2lr5jNW+eb6JIZyjHBanWCtVUNmVPRaQi/H1JRUDe2b1towUk8UWEb9F6SdJP8PsIMO1L
	6gtt162b9885U6UssRVDPEaoumFAPpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV3HB-00011d-1c; Thu, 06 Dec 2018 23:41:49 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV3H7-00010s-NK
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 23:41:47 +0000
Received: by mail-qt1-x842.google.com with SMTP id n32so2577344qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 15:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=65OySHwP01W2oeN/WHBaJuainbpDFmce48CFKYF+oaI=;
 b=swn7pd6osX+mqSihIiu+elu63nvzeCf7Cija7JO/LacpJqi4rdp3/4RbjE3n3JN/Nh
 GeGOvzeU3D2wtxagYYgM4rK0BYNaLy45sgtnrZGXpybWTlsnkjWN8SrySY/14Kyya/zh
 NOA3+e2NkBYssf3YB02otf+lkdQozGarv+Pqm6+LlApm3qUgoiflT4JLPPOq1aM7Cr91
 SrE+mq1Am7JGCXRrsO/b+S4I2ghFx/KbkxfHCI+79RgQIw+JUYNrWQR9O/MJm32AakgJ
 xKhkeiMzsvm6kifRmXTD3CcBzYrnAD4MFpLTaOQ3uuoqHW4J5IQon0Tp0hVCLuSn1Z/a
 hjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=65OySHwP01W2oeN/WHBaJuainbpDFmce48CFKYF+oaI=;
 b=D5zkgQV4KeonTe71iU6XDCI61c9DiJmyM8SoEB00PNudxzrvEIP6Yks1ayUK+lPSuR
 vUVlA8WwTHccrinTuXeEZskvqDpryzYKByAmWGLjXOHAqri7NQjtuHn9JTMxIDMrix3Q
 wE370Mt2v82g6GRNQG+/rFn7xKGM36grikenhhOmhbUyaSPXb2Y8CkQpYe46efwO/wm8
 tKGTozmjpQ1OAiaqUt7wfBBS4wd6KT4TGCokUtEUJ9mPl5gtfOc7d9UvkKZdT11zOZE8
 9BftOXP4df1i3ZOIotr7b4kOKPFlhWPU+fhxSL+vtTq5TKzkC47xxBDN0zBhFcvl4+CO
 oTtQ==
X-Gm-Message-State: AA+aEWYALWTsQFltBf8UDG3vYAvc1YpaTHmsBYx6Z4igxhRc4Cb9elW+
 RTRV9+vjlRY4mpy9SNCLCNY=
X-Google-Smtp-Source: AFSGD/VBfWsjVPKMV2611XSj52zV6eXvk5rZ69JMlLBxlodm05YKRMX15VIqCieUn10lYgCoHMJ8Ew==
X-Received: by 2002:ac8:3e1a:: with SMTP id z26mr29967327qtf.180.1544139693253; 
 Thu, 06 Dec 2018 15:41:33 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id f189sm1099237qkb.4.2018.12.06.15.41.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 06 Dec 2018 15:41:32 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio" for hpa1
Date: Thu,  6 Dec 2018 21:41:17 -0200
Message-Id: <1544139677-16904-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_154145_787980_583032BA 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: andrew.smirnov@gmail.com, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org, cphealy@gmail.com,
 l.stach@pengutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

TPA6130A2 SD pin on RDU1 is not really controlled by SoC and instead
is only meant to notify the system that audio was "muted" by external
actors. To accommodate that, drop "power-gpio" property of hpa1 node as
well as specify a name for that GPIO so that userspace can access it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 28e9dca..a8220f0 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -478,6 +478,15 @@
 };
 
 &gpio1 {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "hp-amp-shutdown-b", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "";
+
 	unused-sd3-wp-gpio {
 		/*
 		 * See pinctrl_esdhc1 below for more details on this
@@ -496,9 +505,6 @@
 	hpa1: amp@60 {
 		compatible = "ti,tpa6130a2";
 		reg = <0x60>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ampgpio>;
-		power-gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 		Vdd-supply = <&reg_3p3v>;
 	};
 
@@ -672,7 +678,10 @@
 };
 
 &iomuxc {
-	pinctrl_ampgpio: ampgpiogrp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX51_PAD_GPIO1_9__GPIO1_9		0x5e
 		>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
