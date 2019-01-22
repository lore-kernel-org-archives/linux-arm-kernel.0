Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAACEC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:57:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8100521726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WeIC9/Ub";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i7appmm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8100521726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HHc2tiO2TXZHsfjLjVdO8TlM16E9WMxl3su7v2STVtw=; b=WeIC9/UbnIHGQp
	+dRg41nHYAPiG0Q3Wg75YlzTSh7Oz0q0k6EHHmlIj0gGAmcmJX6cXz+GAtp9ErH+jX1WD7p1/q4zX
	tFiWCZoj/O9rnuJxt95FvCC2WSHFS+i13iYomxNXVfCCNaTpYtBfwpLp83dsbp7488p4LemyQeWVg
	OIN+IBuu+0mqW10VcMuzG6YjGFlfqBPGTChlzC7h92EmHXY688fpRjIh4R5uNCj7jWReeik2+kAiL
	H+BSbRisFemvzl9wQV+HwVWIyRz41avQeHG/bhQTWmmGQ6MPSG9ZvlQ3jm13Ota+6EjF2ymgj6EVT
	iZuMPX/GGPmAI2lgdDkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glzM7-0002Dv-3u; Tue, 22 Jan 2019 16:56:55 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glzM2-0002DZ-Ni
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 16:56:53 +0000
Received: by mail-wm1-x342.google.com with SMTP id d15so14884084wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 08:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mMHMp6e1jPtVKno6swImdJiZYu/m6Vm6Ibs/f50i5Bg=;
 b=i7appmm+C0k0x4NYLpewIcUuOsDw0YxCCVhGf9RI27fUoAy8YhTr4xRh5tSLUjVeNo
 KlBvWJwhv6XXYiTpG+DlKpNSewQ1Hqbd/ElhGk4rhc08Ji003EfgIt1OP9Z0sncdoZF9
 swF7WUgR+qxlPArhQvhKg1UFO2YIv/707qGNGlWHl0InLaFlXETILgAaQ+QqtF43RllW
 WpkFX658coS/g9wXYMo9fKmla0XA6G8staiSbrtAMN8MPg4qNaJGNgEHuSL/2yHokWoN
 z/blX3hBd7AVrf9s0C+cNohKgcc03I9hKorjBhDxG0YWf7ERpD2AkB7pLK5f4asf+sBi
 zjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mMHMp6e1jPtVKno6swImdJiZYu/m6Vm6Ibs/f50i5Bg=;
 b=teMC2L4W385b1l2j+osBqb7uK3N2wo1G4DjBYDJVhQLarT4Wa0pNWnFf6PgwSxtDJ1
 IRcO6H0rVSV4jbUHE9xTnNdvQYbrig3fkG4pK3I/69BV39BwPbYmrmYeiYS/eGgdJj3S
 MSxFVu8nRzgvDQsi3ywMyZGyNZm3mPH1ZcZjO1f6tqK8pxnXFMgTpeb4SLUaqw85XyB3
 dvIkt+QO2p5Cdsi6jcMVq+vBa38wxH8FVmM/5ptsbRfhUxcjuJr4xpb7u6vdNyxw8Vf2
 tQdSQuv0SlRBIo5tUleW2lZGX7VqjosUdoLmk2QRfjSyRoC3ZIEIMeOWHXneLRKiuVAH
 OWzg==
X-Gm-Message-State: AJcUukc4FvZ7kBTH7Dnk5xmGghbXNeaq6c0KYJ+T1fKoBBKg57euJqmU
 28DTbEZGhehLKqQ98iyatQmwAA==
X-Google-Smtp-Source: ALg8bN5rQeszL+fx5ji7m7Qo6WXUPAl7E8c0pN6Iav2XfR7HstQWsNCp1g8PvygvLfEQ+DrJHuws9A==
X-Received: by 2002:a1c:b53:: with SMTP id 80mr4279188wml.121.1548176208376;
 Tue, 22 Jan 2019 08:56:48 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id w6sm53572108wme.46.2019.01.22.08.56.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 08:56:47 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-imx@nxp.com, l.stach@pengutronix.de,
 robh+dt@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 abailon@baylibre.com
Subject: [PATCH] arm64: dts: imx8mq: Fix boot from eMMC
Date: Tue, 22 Jan 2019 16:55:46 +0000
Message-Id: <20190122165546.11712-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_085650_830432_D12FA85C 
X-CRM114-Status: GOOD (  11.89  )
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

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
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
