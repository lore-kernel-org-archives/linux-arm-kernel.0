Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F4FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:36:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E0420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MsxG1Tiy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8lXSsyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E0420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zL/sQmgIEPbUGMDFa3HZWSEGKW2Ys3gdobaSpqgQRLs=; b=Msx
	G1TiywuZKRcUM2aTMfZiOaRnxw7VDzLC1Dmq7lhv6H0RdhsF2QsX4f8KLVUyV+tQHA7rsZjkq1kJP
	HJ6tlo3CWnWJ64Ose2ZskeRRNqzHuLuCh9Rk/DSvgauBaVQGhX46K7SuQ2C353rWBzNa+EYtU5XHk
	lzqdSwzWKV5yyEDkMwPkSTvj2dDiTIY1lEJWVvnbffNLdx7sxKxrlwdvor4FhWgu2qMg+gMybCbt/
	GGYwNFqgaWx03zapmXLsEXsapX2lwXKhHUyi7TiXdQCmNeTr4DhvZrGOFt9mp6kqBoZp0Ur5Rd5lv
	XVylLZOPkzbnLVqFivq6i/qfunTFQyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUr1V-00062X-1R; Thu, 06 Dec 2018 10:36:49 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUr1S-00061t-Rp
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:36:48 +0000
Received: by mail-qk1-x741.google.com with SMTP id d19so13726866qkg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=W6Z3MOnJmJ4d+nmZKpoWeZ5AK7gudtGUxpsjDTtu474=;
 b=b8lXSsycZlbHXB4wSSR+4ooQ5YJ8lt9IjlYT622Un/1VZxojpPw3SKzeXkF976NGsi
 D4BiyUESH92IijyjxWwRGLbNfiQqbfHux+GXQXR67VhcdGYJR7+BrPHf5/OlPREdFjl4
 VJb5ygaQlpmxbhqzwCAZ3tOZp66e/eUdpR59V10ohPf0RPtHjuNB+6YCAx/Hib20AMc0
 m63qZNZGAAy+gGpubwzEYXzAzAFn0M4eJi6DdjlKexxNLAbjQjlpd8TdB3u6bMHGHvCE
 b9lr3nT9wlOxPMNeY/73qUU0I1nByzqbOBazy0bqkDus/Mm5SzIP322UeSpadGAzgd6Y
 vQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=W6Z3MOnJmJ4d+nmZKpoWeZ5AK7gudtGUxpsjDTtu474=;
 b=VHqvuPuoiJTOhIthC6oLwTSC6IV8Sz1RQBNjF2/dfFb6Jrf/plJE7U4NEjW0Ulbc/9
 S3kZIcjapJIRTNcFPPluluev50UZhn7YHTe7P1PNZpL35riBZRs5wnZcSvRgqjjwYR25
 H16ZQqFHKtciSF86E8nlHtos/LZgvjTtu3/A7zBlcoGC/12g6ob8WGV27FNu+NrEHkOZ
 is7W8Qej0gj7FrwvVS4KBtN1eXoHHB7aIF2WH0TeViFVFmLfJJTU9cHyeg7icATCXE03
 W8hYTSGeHw8SqpKJZjNjbxKyb7DtPM0M+3tjxx50WHIa+em7EOe2Nb6YJ8ZJaHsp+dnL
 ydMw==
X-Gm-Message-State: AA+aEWZTEJB3GPCfJz4nkVHir/CoxEVqoIuyfrXF1OdatIpHXYQBWcgE
 dctAXoiVc/suEPf41qGFzysVDdf5
X-Google-Smtp-Source: AFSGD/Vs6UMAe/mJnoXlxbKDq07n99u1QV1SxDJ2Wxb+kr7+S4X+1Uw2GymxF/+0qCW9QVmAahRSKQ==
X-Received: by 2002:a37:50c4:: with SMTP id
 e187mr25526055qkb.276.1544092594555; 
 Thu, 06 Dec 2018 02:36:34 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id q54sm14935131qtb.64.2018.12.06.02.36.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 06 Dec 2018 02:36:33 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] ARM: imx6qdl-sabresd: Use GPIO_ACTIVE_HIGH for regulators
Date: Thu,  6 Dec 2018 08:36:41 -0200
Message-Id: <1544092601-10244-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_023646_924691_6E7E3465 
X-CRM114-Status: GOOD (  11.29  )
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
Cc: Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Passing GPIO_ACTIVE_HIGH as GPIO flags for the GPIO controlled
regulator improves the readability, so use it instead of the
hardcoded number.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 187548d..8930aec 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -22,7 +22,7 @@
 		regulator-name = "usb_otg_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 22 0>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		vin-supply = <&swbst_reg>;
 	};
@@ -32,7 +32,7 @@
 		regulator-name = "usb_h1_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio1 29 0>;
+		gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		vin-supply = <&swbst_reg>;
 	};
@@ -40,7 +40,7 @@
 	reg_audio: regulator-audio {
 		compatible = "regulator-fixed";
 		regulator-name = "wm8962-supply";
-		gpio = <&gpio4 10 0>;
+		gpio = <&gpio4 10 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
@@ -51,7 +51,7 @@
 		regulator-name = "MPCIE_3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 19 0>;
+		gpio = <&gpio3 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
