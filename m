Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75431C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:27:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A4220868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k5vlzhBg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rdYESubx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WxNuUCnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A4220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FqxwK9TOgx+HGqTcH73rWaRU36DJ5nll/D9Id/P1pCY=; b=k5vlzhBgDinEHu
	a19JNximpr0B0KEZXKBL45nh5o9P0i564PGsppQnDZVo/KEVcquiBiYJ9Nks17fJoe+84RKXZO1qC
	KOBLxkAo/cTLGaOt10zyFyQKI5qJUoofpVfeNhcGxuRmGeodTJMiOw82zyLLl5Q++w4iYFH6AurMR
	z/Fo5vgZ/XA+7wIU6p3r1gABovsBXpjqxR/IZj8C/V9WXjTubRGmcrCw8HqVsFNQL02ldxA/PRMcm
	DCSeccP5Rsq79VONVrsUCNHqhHcuwiDo6uRVR8ZBOM1X0iZRPJ+e6M+Ynn+GpbVHb6tO+dPx1rZMh
	/pSC8rqsm40dnFBVHzGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtgr-0007nM-4Q; Thu, 06 Dec 2018 13:27:41 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtgZ-0007JS-K0
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 13:27:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FDwQO14UGM5SUk/PNniHDmDivUIWcO7xrzPBHqSWB1I=; b=rdYESubx3TQM6PTxAWwjS6CMWL
 hzbHkR8cBwn69niMLa9j7lLa0EvvwlJCUezQl3zUhV3SWTi0IKwUtVmDtesEBJ8mGE9W0/lf+SP+X
 5uGnd+W65vZDvmHLvspO+IESuv+uu/hQHMG9XzzjrxO/mdyDv9Ug2J65WFgIPISodODFztkJUm9PG
 oSTS1aAX4nfCSab1KFaXqYagUc5jsEDwNmVIjpYehqZDPgE8MwYQFtk8vSRitP1p0J3etexcVpq1e
 3xC7ItzBUaCFEbyZteYxKwP4nFn0MnMlCXB7BwdQh4+zzvhHK+zGgeAXO3D08iDI5WdzhPXcWTf3q
 k0wterZQ==;
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtcl-0005kO-H8
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:23:31 +0000
Received: by mail-wr1-x442.google.com with SMTP id j2so506956wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FDwQO14UGM5SUk/PNniHDmDivUIWcO7xrzPBHqSWB1I=;
 b=WxNuUCnT1Nf9o2TGbxbYI6fyfX7UiZEYTyUyDHBaCvdcgoEPT9pKUcO93f18YdNy1G
 LF6hI2nQXeRc02/cfQeU6odDZj7c8Yk1/6jLpT/YEbDCeYaLPYpLTnxrQLlD8GjmgCPJ
 2Hl2+V9JuTenZuY+s7r50Hcpw97U6He8dvIcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FDwQO14UGM5SUk/PNniHDmDivUIWcO7xrzPBHqSWB1I=;
 b=C7U2CaMck1NxBxz6ck7SOX3A5vWcZw20bm8JkvgEkYCvMDN/U2qgc5X6ztwK5H9tr4
 drsL4SFZztuxS7uvO18TbWLRp9VOS2ZteVYG1cCXim5IWl9hYHHYejlC82QfaFA9ELlC
 nBzvsbBMcFxu/5M0xDfO2OPXuXbApd/tmFR2o7LBjBQp6F493dPlcejjCb5MJtlUGTzo
 HmBmuiKLPGWSqiWaSe49jebhoW3d4akwA02RYjFrS/KZG8jnDX3d4hIx65QIDAJtmOvk
 aYMbtNzMveEjUpg+c1jTDmTbWBE5OsknL4OweicUxC130EkS+znLqLRRksixl3ARdOYR
 Rt+g==
X-Gm-Message-State: AA+aEWaNIVtx8LSsDR972zvkMwJH5EQi21mwtARCGmn30YcgNxUDNMT6
 sePNrlUgErGTKJ7lw2t82jWElA==
X-Google-Smtp-Source: AFSGD/WziSFzlMmmeGbA3uX4wV4afbrHFCdKokYZ57bjESEqMLIfMQDgLMLjP2h1+kOtVwmk1vlqwA==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr24199502wrs.7.1544102595481;
 Thu, 06 Dec 2018 05:23:15 -0800 (PST)
Received: from localhost.localdomain (ip-161-243.sn-213-198.clouditalia.com.
 [213.198.161.243])
 by smtp.gmail.com with ESMTPSA id z13sm363769wrq.19.2018.12.06.05.23.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 05:23:14 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 2/3] arm64: dts: allwinner: a64: Add A64 CSI controller
Date: Thu,  6 Dec 2018 18:53:05 +0530
Message-Id: <20181206132306.11843-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181206132306.11843-1-jagan@amarulasolutions.com>
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_132327_567766_3C8685E6 
X-CRM114-Status: GOOD (  14.78  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner A64 CSI controller has similar features as like in
H3, So add support for A64 via H3 fallback.

Also updated CSI_SCLK to use 300MHz via assigned-clocks, since
the default clock 600MHz seems unable to drive the sensor(ov5640)
to capture the image.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Use CSI_SCLK to 300MHz 

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 384c417cb7a2..d7ab0006ebce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -532,6 +532,12 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			csi_pins: csi-pins {
+				pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
+				       "PE7", "PE8", "PE9", "PE10", "PE11";
+				function = "csi0";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
@@ -899,6 +905,23 @@
 			status = "disabled";
 		};
 
+		csi: csi@1cb0000 {
+			compatible = "allwinner,sun50i-a64-csi",
+				     "allwinner,sun8i-h3-csi";
+			reg = <0x01cb0000 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI_SCLK>,
+				 <&ccu CLK_DRAM_CSI>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_CSI>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&csi_pins>;
+			assigned-clocks = <&ccu CLK_CSI_SCLK>;
+			assigned-clock-rates = <300000000>;
+			status = "disabled";
+		};
+
 		hdmi: hdmi@1ee0000 {
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
