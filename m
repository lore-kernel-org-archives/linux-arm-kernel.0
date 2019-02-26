Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCB7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:06:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2D3213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JmYntONk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n5U5o1Wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2D3213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fHppMx5el6c60xQh9Bue8+k6W3E2dW1FLC1QKgu5O+M=; b=JmYntONk66SyqG
	1CryuHlLrwNMYqmdawj74GzV3SCKe94w+EdMEZJTJG7wlSAwgFzvNbHhxsbIZpK+ltdFhJN/srO2V
	+AZ29tyYSHj24BIXnr/TbNaBJdZjTvZR+DkscdCES2eQpDPmEJG9KgoNRRgGldbK25+4cOcg22GFH
	D+oZhmkG3ROcIOSQq0D2GfDCdlH6s11Y0iGVF1hUa9x8ZEjGGPrF0TdrMRS6rAIqnphbm/hsvUUqu
	hc6NxRHzFEX0YSRSeU29BhVt60zbAT1M9PWF8eub79edoxltRomwJnrBhSPkBiCwje5z73qzHwWP7
	WfKYIs8U201W/DW8Ydag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyYgY-0000cW-DF; Tue, 26 Feb 2019 09:05:58 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyYgU-0000bb-Tb
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 09:05:56 +0000
Received: by mail-wm1-x341.google.com with SMTP id m1so1572881wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 01:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XkBqMt+FwQo334QxKCWaa5Jo/x47chluO4rcb31rNIw=;
 b=n5U5o1WkVC7m/0LltzLD7+I4Bksrgtfu3rV1lcmQrspLOjrZQ3fizq3IT05ZDEGs+p
 umshrVtvKnzZzYel8MwFXiI4QW1aNGi4Nhze3SvvKeVHnxdWJ0s6Exkv78uJSOtbij/0
 OaoVzEp0p+xlzIDx30EujYlglVM7zsOstoT3onDkezQSlvJgcucav5uFcAkhK3KPcvYN
 LpkCc6cnum0VpKlgXYMD2sDR+3xDli7PRYwxnfoGYBUrom6zZyeZ659XachILjMpgpDZ
 yuU1fPoUC/KXjiaWGs6yzITxe9oVpvIEzCBxNb8PTdluvrW7jB764bxVVC27+zrr53iV
 8tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XkBqMt+FwQo334QxKCWaa5Jo/x47chluO4rcb31rNIw=;
 b=SD9urByDAv4XDgp3CHMsJFWMkkX9EOS6Wz5PDYjSOo54qgmJosA+KLEbChZ5nm8sGS
 Hj9+Jgcoi7tE37lwHfsAAwvhQB0FrhjkpnJURnXn2ZIkP7yw8CMKwsdSNJqmunGl3xLG
 Km0N29OPJT13YTwS2vSnqmJkNp22u2w6d7gOPbEuqXNdTpcHVleCyYu8BXYfv0noIz3P
 bt46luYS+5tlH4aLWNUO1FCIbtSO2f8TiR4I32Kjuy0NnAaCjT1cJJI2Rj8d3lDXPQiS
 ryX9ub66CUIFb7bIsopXmXeKVrIKA6YTQkxu6fogYP6iM6wpcFc79D9hn3zG+RamypD3
 wigQ==
X-Gm-Message-State: AHQUAuape9QD0q2jDpYyIdpHbNMCWz3wH1lhuXGM2fjKG0QTkLVMFbd9
 v9yEt5QJzdfPaobnLYt8Woe0Pg==
X-Google-Smtp-Source: AHgI3Ia2/PVY0RtjVvhNDmZX62p3jpd4RCjTdbRrCLVkXT+s6TLD6arZjbuAenrzkUIj2nwJ90xbaw==
X-Received: by 2002:a1c:449:: with SMTP id 70mr1935795wme.118.1551171953244;
 Tue, 26 Feb 2019 01:05:53 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id x12sm20831257wrs.84.2019.02.26.01.05.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 01:05:52 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq: Add on-chip OTP controller node
Date: Tue, 26 Feb 2019 09:04:48 +0000
Message-Id: <20190226090448.24364-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_010554_955305_CC327911 
X-CRM114-Status: GOOD (  10.65  )
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

Add the node for the OTP controller.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9155bd4784eb..6a1cc183a301 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -244,6 +244,14 @@
 				reg = <0x30340000 0x10000>;
 			};
 
+			ocotp: ocotp-ctrl@30350000 {
+				compatible = "fsl,imx8mq-ocotp", "syscon";
+				reg = <0x30350000 0x10000>;
+				clocks = <&clk IMX8MQ_CLK_OCOTP_ROOT>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+
 			anatop: syscon@30360000 {
 				compatible = "fsl,imx8mq-anatop", "syscon";
 				reg = <0x30360000 0x10000>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
