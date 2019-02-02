Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CF7C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:42:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74559217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OZ1Oa9jd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UQQv45Wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74559217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=59ztnAp29DYE2nBuMutRY+rE/rVIQKoAEoq62ok6raU=; b=OZ1Oa9jdVGvqQ8
	2VnrunhLeL0kaQvYsSrnpiTAwudAX3HC0Ku43Tib4C3CB3XB/4T90Kozl+rjatGckJruKTm9h2QKM
	lx+gPxOkiAPcAqcQsfaylQUuW0PfUCnXv4kP2auUPV11hOOFWGrUFLR/wPVjrnXKM5PNK4h+M9/8A
	ND1aw+OqrPiFtiWa6qk9M6A7ltAMOStTD0canWl1jCdQSvHW9VnPbODY3SrufODN1G+DkrRjolAVc
	bT/myX+pZhAVQA8ZhNT/QUJ/GlAY4hCqYLQgoUdQ9GFOMtMMOuhRQ8tC/8WVFhancH1P7A/UYhZTx
	3MdKT6cYVSrJKINFUSww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpwUi-0006aB-RD; Sat, 02 Feb 2019 14:42:08 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpwUf-0006Xu-1b
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 14:42:07 +0000
Received: by mail-ed1-x543.google.com with SMTP id h50so7837525ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 06:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KOcJQWtqQqQBHBEfBC/qJKYI5ZjuvdLpdUJeTQtA9QY=;
 b=UQQv45Wr28gYCUm8ajIlZOvVlGfVhOxYTIEAyUc3aGBeRxqI6DYHVa9h10lI2meX8Q
 uo5zYLQCXZ5coGu7fGNQ0JW/7s+mlbTptqT/WbacqhanXTVrbbpmCODGRJAZVsXwSMfN
 TKnpky7AsbYkEmk8FNL5UOU7eqstkFGZb8EwiHczNRuxSnzDPAXqZlpoXAiLSdV6gvS2
 EoLA0+qzzTQkdIpSrOyNuEMkMv+P6UMQzLKeikL4fpDi2vu3NwjkRNL0zr3dDOOew/4S
 Hm+apjXhJmEleYkmqf4qQbLDlaJF8gAGtxca0E6fEqV9rEepG5xD7yHCOBLaF4JC04Lq
 7MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KOcJQWtqQqQBHBEfBC/qJKYI5ZjuvdLpdUJeTQtA9QY=;
 b=VCEyRMjKGf26/nyVo5czzdUo5580rJ+2/vt61XjqU42oY1w65/ZhKQ4qc+O75zNueX
 ckN5q+29AhSZw2cdkt3eNCMfYBFDH1pzgAGHRcbBmaIaFBjIrQs8HELPghdjLJ1Wo9va
 B115IkdO8lDBV85eeuQN88ZRyRChGX4ESUbxpXGp/SgiDeAMHDxcEApZJzX/i20NMa1F
 93QU/JwMMzDBJKT7n/rlZ83mqqtZxWbSA4Idzg0Z0w73xm5lwb1nPm+IGPiTssT7QoeI
 MDaznYrtXL8benyA8XLFRCNaAbrnLM9mn/jVm5BvDSBRhw68VSfuy/CedPktGW0rq9iR
 yynQ==
X-Gm-Message-State: AJcUukcc4XvBKXz6I85A9kg5La7DDqoUz14ZSPUu5miTsZ1kOSWq+kDH
 ivIPTeqwD2/13eNR2i3I8kaxtA==
X-Google-Smtp-Source: ALg8bN5Z5fpVWoPvpfAaeZ1j5N4cxH5N1aKWWh0cz74FwXbk0GdsZ8t29iET+7TFRQrAeR436IdCwA==
X-Received: by 2002:a50:8bb5:: with SMTP id m50mr42453421edm.211.1549118522908; 
 Sat, 02 Feb 2019 06:42:02 -0800 (PST)
Received: from xps.fosdem.net ([2001:67c:1810:f051:b8ff:4dac:8778:256f])
 by smtp.gmail.com with ESMTPSA id g20sm2667821edr.47.2019.02.02.06.42.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 06:42:02 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] arm64: dts: imx8mq: Add ARM PMU node
Date: Sat,  2 Feb 2019 14:41:58 +0000
Message-Id: <20190202144158.7149-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_064205_137089_3B356F85 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the node for the ARM Performance Monitor Units.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index dbedc4a5e7fb..c34cabe9b356 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -118,6 +118,13 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		interrupt-affinity = <&A53_0>, <&A53_1>, <&A53_2>, <&A53_3>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
