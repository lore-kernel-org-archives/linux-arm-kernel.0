Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A35BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:09:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F1C218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tdUYdh4l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DmmYfIN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F1C218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ocEKRN0wPPfkLnCe2KQRw9FVXw9jmMOciu8q9+tAmQ=; b=tdUYdh4lI1NO4z
	p3sftN+8ztuWBpO2xxG/ME3sBPDLTHByFLF1SHM4BRfz770knPnIYnFmxYeekY7WYL00XtLQdVlZR
	gPBIFddGNqrfa5tLUNRnDNsBRUQ7hhsX+mJSx1TREUNVBhdZGgo8hy38cJieT48d5ukYCWCYspwV3
	zizKh52Ht0qyquZBGb/2JsUP4RPt0boFrMdXwV/JPnoHtNa3p1RUsN9kASmqCyhaAVt68A1igInER
	p3DMb2aN2ce4D0BNmZwULm2v4ERLpneqnbrKV5Jlix96ghM+IETUVhlbJu4b8UPhWbOOES1+BqtdV
	lVKZqBkp8DP4CnG1mOGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjRJ-0002cf-F7; Thu, 24 Jan 2019 18:09:21 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjQY-00021H-GM
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:08:37 +0000
Received: by mail-pl1-x641.google.com with SMTP id z23so3256132plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 10:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NEU2q7n4hfFLUiueQNI1eh+ct5ZyqUAqwbpoXVCvd3w=;
 b=DmmYfIN+j9ZEn9AycYhh+oQLaiMR+WzLL6ulCg8pbm+6zc5hWK3SnV745n8gpHX5yI
 aWXPeS9W76canA/iD6sWdIDGOidx4AoConbrLTc8kAA+Hzl+jPokuq1XeTTJqd7YQGri
 fwpq2odXSNDCmVn75UxdLTbuN3oliSA0ZYhYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NEU2q7n4hfFLUiueQNI1eh+ct5ZyqUAqwbpoXVCvd3w=;
 b=UGUcE9/1Y5dIgQanPe48WIBnzbZ93F8n6CkTgos+NliMg8Df1lTvKHs/TKymXZPDd1
 Or08NM/EL6w0qe4a3YZKXkx5zSV1ANlpOFU4leaTMZo5zGWpxJfYbYbbs2eIbZH30ubw
 hzmQrkBKh+AN0mHeFlkANUOfR52vSmK66+ANu4rThFPr8CwJemMznydNx+lqkySD/ArF
 8WuqIPwokTQkSupfdweOs6QmghqBqVUddJLbN2j9Zt7No7f1JQw1RSQBwLHpy9Z435i/
 Bkr8IaT5iTd5O97le5PPEJvQh6Q0OjZpIRDQqsphSGPfplwfvXeZQ/DBrLRaPpE3yOQp
 8LKg==
X-Gm-Message-State: AJcUukeiJY9E9WHfgpMUPee1W4RfwqAG+LHxIH7QTtb7SkcQOrWByLgg
 zW8UT/DHx84GrnGKAo2zbFIH9g==
X-Google-Smtp-Source: ALg8bN5m1LCpFgDwm/rki6V7Cb60EEp+UcVRffG3MI8h8p1Nqbwy+jaBiydaG6pEp2rSv+/zh5ZrEw==
X-Received: by 2002:a17:902:e08b:: with SMTP id
 cb11mr7603740plb.263.1548353313969; 
 Thu, 24 Jan 2019 10:08:33 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id k15sm36141551pfb.147.2019.01.24.10.08.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 10:08:33 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 3/5] arm64: dts: allwinner: a64: Add A64 CSI controller
Date: Thu, 24 Jan 2019 23:37:34 +0530
Message-Id: <20190124180736.28408-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124180736.28408-1-jagan@amarulasolutions.com>
References: <20190124180736.28408-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_100834_704497_4389A57E 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add dts node details for Allwinner A64 CSI controller.

A64 CSI has similar features as like in H3, but the CSI_SCLK
need to update it to 300MHz than default clock rate.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 839b2ae88583..62fdf850e9e5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -558,6 +558,12 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			csi_pins: csi-pins {
+				pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
+				       "PE7", "PE8", "PE9", "PE10", "PE11";
+				function = "csi";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
@@ -925,6 +931,20 @@
 			status = "disabled";
 		};
 
+		csi: csi@1cb0000 {
+			compatible = "allwinner,sun50i-a64-csi";
+			reg = <0x01cb0000 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI_SCLK>,
+				 <&ccu CLK_DRAM_CSI>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_CSI>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&csi_pins>;
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
