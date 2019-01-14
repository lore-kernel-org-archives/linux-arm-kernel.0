Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E67C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AE02173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fG+z0ykN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wb1K3ojJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AE02173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=P3ddFKEo3uEzlCp3Q8UnBijb4NKv9maj8c4we37VViI=; b=fG+z0ykNteEOzl2eFNRawmH69N
	crdmA/NAvdFSCsasiIFoZwAzQU9oQBEx1gIqDVX10w0CRucL78VoujRFpEcFZuBu52SraY1tQixOu
	35TYEbBu8VB603fjTOeWjJyebB1s2E/nhy/DUgmHDR467hKnBFfMVihlWzsdOl5I/g6DzySnvkyTE
	D3VS+zd8bOtb639430lIvk9gni1ID5GG46WifqI1r5CVWYpb7BLrkNCx+ZGIs71KCNiWUAjiZJPeN
	1bO6sGa+zndLrXt9zGVnLLJ/GOg/bCgG7QkT7LFEoow7JzmwCZDj5pi+uYt4cavVWaE9r+HvcRYlD
	FKAzYStw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gizNe-0000Ha-D3; Mon, 14 Jan 2019 10:22:06 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gizMx-00086Z-5x
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:21:28 +0000
Received: by mail-pf1-x441.google.com with SMTP id z9so10155803pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8ySRluh8UnQNx0w0kOBma0DodxOKHroSYUhNhVj/8Uo=;
 b=Wb1K3ojJ9WYDw5IY72tUVaBYTEMiIkllvaeXLbjWrD0awjhnlymmOz78d1twh1VRej
 q98292ySiZa4HFm1KDcBpfS51UIR8EqCWP3s4U2fsXYE4HpDyfJb+D9AZfhDkIgm2Bnq
 I0bLkoEYseF1uAjrnRMdWN8nxGiAvrU2LMRXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8ySRluh8UnQNx0w0kOBma0DodxOKHroSYUhNhVj/8Uo=;
 b=kzZJM+MUdhL5eYpoi5zPVCQ/CYmA0z/pWcXkXB9zNa55WEOO8xsz3oDZnbOZkG3z0j
 c5wR5GbZsT5KC15J4DvCIHp14S2b+9PUoO8kYLR4zm1CC1RTVEccukcNxltPOUS0CwAI
 MEYEtpd73QJM1XDdTUxaifTHbmyEYHF650BIdI0g6NQq4Dn7d+RLUGfrEBES1xoXiIre
 Jcu3wYgU9GiFABbVIgph2OeuxVZsxFOXEsIljVsJn+6QETOOv6RkPpQs0eus+6EAOTLa
 CESFFWZacNDPwk91haJuglPNNMaS76QZbNRm0clPIakTUjy1pVDCTBESUshFGQY0INx3
 cxFA==
X-Gm-Message-State: AJcUukdiYmMyqTyAd0mIwI4RxqL+NIfv1VM1YLlVCBhO36XoNGUZ8Ul0
 TPCUenhiB4ER6lQAizxfWSTp5uOBNA==
X-Google-Smtp-Source: ALg8bN7Q/Gzeiu84Y9s0Sq+NX0l3zeR8XI82rdejLcqZl7gExEX60Z+D2M/jufxy8H6U4FFRLi3q/A==
X-Received: by 2002:a63:fb4c:: with SMTP id w12mr12202724pgj.321.1547461282130; 
 Mon, 14 Jan 2019 02:21:22 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
 by smtp.gmail.com with ESMTPSA id 15sm36429pfr.55.2019.01.14.02.21.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 02:21:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH v2 3/3] arm64: dts: freescale: Add devicetree for Oxalis
Date: Mon, 14 Jan 2019 15:50:53 +0530
Message-Id: <20190114102053.16013-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_022123_913466_ED5265AE 
X-CRM114-Status: GOOD (  16.23  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add devicetree support for Oxalis SoM board from EBS-SYSTART. This
board is one of the 96Boards Enterprise Edition platform. Below are some
of the key features of this board:

* SoC: NXP Layerscape LS1012A
* RAM: 1GB DDR3L
* PMU: NXP VR5100
* Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
* Connectivity: 2x Ethernet
* USB: 2x USB3.0

More information about this board can be found in 96Boards product
page: https://www.96boards.org/product/oxalis/

Ethernet and SPI flash are not supported yet!

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index f9be2426f83c..d8152cc06b3f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frwy.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-oxalis.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
new file mode 100644
index 000000000000..7c726267ec8f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Oxalis
+ *
+ * Copyright (c) 2019 Manivannan Sadhasivam
+ *
+ */
+
+/dts-v1/;
+
+#include "fsl-ls1012a.dtsi"
+
+/ {
+	model = "Oxalis";
+	compatible = "ebs-systart,oxalis", "fsl,ls1012a";
+
+	sys_mclk: clock-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker Ext",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"Microphone Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Speaker Ext", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+			frame-master;
+			bitclock-master;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&codec>;
+			frame-master;
+			bitclock-master;
+			system-clock-frequency = <25000000>;
+		};
+	};
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	codec: audio-codec@a {
+		#sound-dai-cells = <0>;
+		compatible = "fsl,sgtl5000";
+		reg = <0xa>;
+		VDDA-supply = <&reg_1p8v>;
+		VDDIO-supply = <&reg_1p8v>;
+		clocks = <&sys_mclk>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&sai2 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
