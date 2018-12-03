Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9DBC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96D820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BZWiW48+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aVmN+pEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96D820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5PPPVLFJMoC6PtAwHlKsUeRZYgZAqCfQYYzZFzWeK4k=; b=BZWiW48+e3i1Y9
	DItQ+mMbjZuKJxVZvgvr/x/yFqp6O+Ngh0OMjXSth/eRZ17ANp2kuSG15OBeMtGKi8aim1bGp9Ccz
	ezG/lP6PkUhg3lhBV38jlIzCjYlnSSY7ftm0lwYmofI9IKsYsF7SV3RTSUYNGrHbRicpMmaxC+3EX
	YQIkczMB7HwVkgclAggFFCc1DFcC+MuILG/aoVF23dyC/TZFi8jC466XhxrDm5jTxjW9b+ZFEUm01
	+SB2iOFEkLCNkZGA1nPqmYRI13fiCl19x9meN0iZ6NhMqqZJ5CULziVJaPHjZhSViC7xSQF+SUTkJ
	XUJuzwa9/Xb7ruY9l1bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTl9o-0002NW-6I; Mon, 03 Dec 2018 10:08:52 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTl97-0001Ly-BK
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:08:10 +0000
Received: by mail-wm1-x342.google.com with SMTP id z18so5089798wmc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SaTHXuzdJjMTWekY2/DsirLmYaUh6d39j/40yOw9ADA=;
 b=aVmN+pEPQpdTu26ytBH6ev469JzbamvV7CCnubiDPyOpmzonabtdr3gd//ELjNxIgM
 cGOYPfwYML5EoVHTlkG1sAAYiQOBPai3zb+4elxLYiyRImtP/NYnSgIMLs0a01woZb/z
 o8vORLdcIToa0TyHYyYc+IFw9CPmu207BMDx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SaTHXuzdJjMTWekY2/DsirLmYaUh6d39j/40yOw9ADA=;
 b=pEAuqQMgIFhHGuIRBsnlM3/+Z6L4eWkf/xVaM1p9Vx9tW03OEnMM1PRfNBHACdpoyJ
 RY7uOcP/mhI4pvSWZztcmsn8M1KlWZfnaVrdM3DGUGZqwx+m55gGD4S9PQmrUh+a29LT
 EiGD5/SqhoNm1JfWUglVJ9ubc/b6shuOcQKwjsVT9KQAKAZeg1n8DK6wdrQBOL+h5+Ld
 EYphrNJBlcA5cfhxUI8kxCGbg4DUK8qWIpMF0AArdgtiRvBTk+iLNHhgTHCw0Cv/DUtK
 GXOIcEy92T8QRFsxz9hTTHpvEyZYVbA481LIjxrxNXkfSz+yMGZwAO3gEOkH10fJJg4Q
 iKCA==
X-Gm-Message-State: AA+aEWbT/k/ImkXz39mINza/5RNOICrWIMY9FmHj0zW+BllRS0md7CZt
 KBatd7joggHpY1P+cFIEcX2Cnw==
X-Google-Smtp-Source: AFSGD/XXID2lcNa2SrO9/ABXfaFcfhJBWMw99ZZqav47P2OVn/8dG2m9kDDGnVhHa33Fr1z3Y/KK/A==
X-Received: by 2002:a1c:b687:: with SMTP id g129mr7464602wmf.59.1543831680419; 
 Mon, 03 Dec 2018 02:08:00 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.07.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:07:59 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: allwinner: a64: Add A64 CSI controller
Date: Mon,  3 Dec 2018 15:37:46 +0530
Message-Id: <20181203100747.16442-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_020809_385982_AE09872D 
X-CRM114-Status: GOOD (  13.16  )
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

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 384c417cb7a2..d32ff694ac5c 100644
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
@@ -899,6 +905,21 @@
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
