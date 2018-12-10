Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9FBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:54:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7469120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nBlxmwd4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n/al2t3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7469120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/nFOiGJvO81/iL5JHWF5MMIS2FK2xm0iTxXkwgP9NXM=; b=nBlxmwd4MO2T40
	mMoK32kBkVyCNvY6ABzANF6TeOpO267GtQu2LQMX2TTRWeZhih/zYwFlULY2jnhvXZIHj1Z5D6QCR
	RHdMdJG1+0+JXmBgMj0nNJoan0ULqNBl3SphCH2rUrX/y5yW9w1/Kp2Ych+Qvp9woHq5R0+guqcET
	OmUKwUFt5UQtNEAAchNFfc3OyYVkpFFHl1eTNzCrszQcXnTy1V/nU8dejNmxaFB1XSi/afnn9fZiQ
	wGHNlLXsDgH3fIWU17Ez4pb131npk4Vody6MRPyO/qoJcswXIaFZ1rZDJtr7147dDyc7jOhwcFl1h
	b+4jCB3WAc1bWGJ38z4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWK90-0001g0-FM; Mon, 10 Dec 2018 11:54:38 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWK89-0000f6-ES
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:53:49 +0000
Received: by mail-wm1-x342.google.com with SMTP id a18so10963410wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 03:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YCOZorFflqds8ajAHDAaoT0p9NgnHCX+QglAEJ8Qg/w=;
 b=n/al2t3NVW0ZJ0ItwmFF84wfLAhRNRVoQuVQ/CcY33LEIPT0PtCMQe9E9BWR99xy1E
 uKAQnpIHoYdZGhvt5NXZLWj7DwItZ4PLiFrXb0kgFJTtxjOwzVULh6Itbcdict5HU8Tn
 qAV/IKoHmX6Vp/1kfIkIN9s0aQntk2RW2lClg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YCOZorFflqds8ajAHDAaoT0p9NgnHCX+QglAEJ8Qg/w=;
 b=nm6CqnFoaRIjna7bS8HasC6h1LcSw2tZHiO5Afi52WVD9tjZ9J32d8kMaMTHNuPhUv
 xeB9vD2cW1JXew1Oaw81NpBsmQ+/XT2gqVCLEESiatS8WFBSuDNevdPNXRcEHV+to0gL
 FYcyNydevACRNlvPf7UmUb6EDbUMjcyAOT5QhDKBAM7GIdOJM1v3TZR1rBcztXjH8WRU
 w0OgIaBrgTlua7YkQZwXLeT5Q5oUC1fFGLKT2rV/Vfv97BU8+Pi3MV1PRz/sbINkU9ja
 oxfB0FuHOnLvksVIBxYS5GoTttywOKyYt4A6wFkayad78+FTNqKuni8aX3XYYlYDw2r6
 ZR9g==
X-Gm-Message-State: AA+aEWY4eDx4N97CiuWRQfeyN9Ky+RhLpC16BfmOpXW6qsaEjxqpQ3VV
 cieXNbMzRtKkTkFLG8MM5ghsLA==
X-Google-Smtp-Source: AFSGD/U8grm9cGMe6Y4Sc0MwaFhIdWzVIUZ5SIaZ+q9e4S/oH6tjr2Bm9FBjN1XGD6og/2ml5q9hzQ==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr11014121wmi.102.1544442815538; 
 Mon, 10 Dec 2018 03:53:35 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 03:53:34 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v3 4/6] arm64: dts: allwinner: a64: Add A64 CSI controller
Date: Mon, 10 Dec 2018 17:22:44 +0530
Message-Id: <20181210115246.8188-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210115246.8188-1-jagan@amarulasolutions.com>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_035345_763597_2BF21E28 
X-CRM114-Status: GOOD (  12.68  )
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
H3, but work by lowering clock than default mod clock.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 384c417cb7a2..89a0deb3fe6a 100644
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
@@ -899,6 +905,20 @@
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
