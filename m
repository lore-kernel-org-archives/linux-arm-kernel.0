Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5075CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:56:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E418218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NkuuAoA0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dpIuy37N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E418218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7zyjA3YESxEu9jGfgl7g94qexmYFGsrYl87p9M22uBE=; b=NkuuAoA0b2XZm3
	RJGfteaVCcwEreyznuYw2/o8uvDe4L+fJ2C5mlXv12ne0AJLbOJoBdvEmUr21liPyNDHQ4l5hzy+l
	9fjwLAp21UqvD9Feh77cxefABym983ajdrQPmmy7RZgY8zn4O0fXVklND9f5bKAZre6SdWkVq6Kvu
	hnyAzsSF8i6MvLpFFikoHKQLPeOF2OrEiFAisinp39XiznyjNTWiEFOF3Ufe5QnIIntyj3M1N2+5m
	cT38bYDtpoBtwKsER11LJc7GpCD2/pi0ndR9rWdBjH0eaP/7BSEypnerbDEYi9B1PKW4b0vqQe2zh
	LQ/O4RpeYz91SM3ni24g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn1xr-0004At-1V; Fri, 25 Jan 2019 13:56:11 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn1xm-0004AY-Tt
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 13:56:09 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so6794704wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 05:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H9q253Xhsu6ZAWsihih6N4y3fqjjJWJUB47BAzk0ADc=;
 b=dpIuy37NtoJ8C087/ujjPcXlF+qKWFmtP1scM/QK30VhneqLFq/FE1i8xhm+5AV9jx
 3pIIfrYXvWHiuoygrCUBCAh6gugZeRqZ5lpcW4G4YOpCI5SuD8xb32mGyLcPQlP6J4Dv
 zMjGEWB0BGwwSW+2SD5bLJSBVy8Z0UQov66CHEz48DgovObfLo3I9Dt0+9WiQqrZ1piZ
 DbCRHULFMb2kubo6+EFc3T2G1SlNdJoH4eqZZDJnVXVTlUIcEPbzW0OutNHjgg6Zy90H
 3f3TfsAG6i6AsWkRlADsyu6dmm2obHKvhZuVlIzE2QSP8zh/LEWU/mW4wemZr/mHtqp8
 HsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H9q253Xhsu6ZAWsihih6N4y3fqjjJWJUB47BAzk0ADc=;
 b=ciWUd0wwqgZHNslGX1HTT3CL1cbRzQmWBHpMWqVQRFVH+JcL8+bPDnlQ8V0jic60AG
 k/GXqRQpV2BX9hO2vCiv0AbIjcuetc0CF5D5gn4+h+HoUckHADgYe5dnbDaTzvUAa9CK
 93+n1jgLG2vkHlnKTDWYUGxd8+I3heFVTkvLAJRjAYZadWIy1LM76VIL7i7zZS0R+vXq
 eoXj8KfpcXfLEt9438ih0VYi5kJrq1895GBmv1Ntd6CHk8uOOXj7WHHsfTB6iiVu2e0r
 aK7MVHY4aK3YWTdopw+8kvoTCD5q8A3hyXVand5omqAAh4RObcla3icWsP/MvWpHfFpI
 Jhhw==
X-Gm-Message-State: AJcUukcps26CpZAViNV18nv/kK8tnLga7oVnqa1Qj5QAa0LgDNXGiMOv
 fOmRWGQnaM09dWre3WKHWkEdOQ==
X-Google-Smtp-Source: ALg8bN61KOHfsJF7X3ocJ97hZjQNkuoplk82zkHqtUnQyPuqQAU7CVyiKtzE949MvmspfF5hPBC0fA==
X-Received: by 2002:a1c:834c:: with SMTP id f73mr7077110wmd.126.1548424563996; 
 Fri, 25 Jan 2019 05:56:03 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id c21sm83338556wre.71.2019.01.25.05.56.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 05:56:02 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 festevam@gmail.com, spencercw@gmail.com, abailon@baylibre.com,
 aisheng.dong@nxp.com
Subject: [PATCH v2] arm64: dts: imx8mq: Fix boot from eMMC
Date: Fri, 25 Jan 2019 13:55:58 +0000
Message-Id: <20190125135558.3451-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_055607_009660_B9C9492F 
X-CRM114-Status: GOOD (  11.41  )
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

The boot from eMMC is currently broken on the NXP i.MX8MQ EVK board.
When trying to boot from eMMC it fails with:

...
[    1.271938] mmc1: Tuning failed, falling back to fixed sampling clock
[    1.287429] print_req_error: I/O error, dev mmcblk1, sector 1 flags 0
[    1.306833] mmc1: Tuning failed, falling back to fixed sampling clock
[    1.322325] print_req_error: I/O error, dev mmcblk1, sector 2 flags 0
[    1.329559] Buffer I/O error on dev mmcblk1, logical block 0, async page read
[    1.336714]  mmcblk1: unable to read partition table
...

The problem is the result of a partial misconfiguration of the pins and
the missing assigned clock rate.

Fixes: 9079aca4aacd ("arm64: add support for i.MX8M EVK board")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
Tested-by: Chris Spencer <christopher.spencer@sea.co.uk>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 44 ++++++++++----------
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    |  2 +
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 64acccc4bfcb..f74b13aa5aa5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -227,34 +227,34 @@
 
 	pinctrl_usdhc1_100mhz: usdhc1-100grp {
 		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xcd
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xcd
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xcd
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xcd
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xcd
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xcd
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xcd
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xcd
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x8d
 			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
 		>;
 	};
 
 	pinctrl_usdhc1_200mhz: usdhc1-200grp {
 		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xdf
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xdf
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xdf
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xdf
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xdf
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xdf
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xdf
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xdf
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x9f
 			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
 		>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 8e9d6d5ed7b2..b6d31499fb43 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -360,6 +360,8 @@
 				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
 				         <&clk IMX8MQ_CLK_USDHC1_ROOT>;
 				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
+				assigned-clock-rates = <400000000>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step = <2>;
 				bus-width = <4>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
