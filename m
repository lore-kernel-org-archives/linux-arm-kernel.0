Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A84BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:07:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFDC20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OdSuHiT8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJJzBkP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFDC20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VS8/DC7SjWnA0hA9h8nlw+7/RkgvQKjyt0wiY1G1r9E=; b=OdSuHiT8SL2/bZ
	SyWkhIQUbM7BYj2EhMrLQk7ti63Ink1Bqw64/3y7X4oPusyGM4S1DvGd8WF5eQvWgLk/1+K45rKHP
	eX7UgwSyqC8Z8VbIetwwyauxqdtT5mVi4YUm2dd0O/0uOVIHRreOcHqezNMY2SaGXmYoHp8/Sa28I
	uLNomjjKv8fHiuoDadYl7H6WkIvoV8jsxiBe5X5cAv3mjWCkNoF1TUAEem3+R1fYW9DRWQRO7dfyh
	b+oYl+Iv1RFhYUaALxSri4SBNKaX8IcG+eoByEVUXI/ahbpylVieag+0MmojjkWu745J1CgEN/Ui4
	xf070zSvyHoPf7fZFouA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goniY-0003uR-Nq; Wed, 30 Jan 2019 11:07:42 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonfm-0000Zq-T7
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 11:05:02 +0000
Received: by mail-wm1-x343.google.com with SMTP id t200so21280890wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 03:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zk7ukQ/wi6+kO+yJuF8Jy/OYQIA9+hoCg3pOYSfcHV0=;
 b=RJJzBkP1VFrV1bGyq2WrgWESqwOHk+fdoCzkezB4562BomTI0ch1I7ui27c7NIhCf6
 N9FMxKgx+m3SNqu/YuT4IPsISCAZAHz3AW/ApOhvRE+ESHBFVXAe6jhG6wig9KlWyEON
 jLU7lXET9W62N/NjbvPYC8S2OBrqIwd2Chzdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zk7ukQ/wi6+kO+yJuF8Jy/OYQIA9+hoCg3pOYSfcHV0=;
 b=USjGOrKlBTv1cFQ4nowoy1kaoHNOz7xQBRdj5C9yWuupnWpED1E+TNGDZJceUsj1H0
 t83ooqWvBhTgst6zuP5ktRo1YyjlP2Q3TVcsgqNcCSNoNfxldyPYNrlMyHIuFwIiIJ6x
 +k77WHoMsOmpztEslry+WT46KNqe+llzKhXXqsXWJLI1aGlWkqX8u54jeyYxOwvf18py
 qLCXXKodzV/NQbsFHPQ+sYjDgJKU+YuLTGaci3Dw6D3fBlcIzoD7rlOqSwcPK3FOzino
 kYYt78XWak9vJhNGF+EvwIIejyo4BllWiQ4KaAOFNsB7TXYJOI41XTGI7H3Ta9x7ABFk
 HBSw==
X-Gm-Message-State: AJcUukf6IMr4cD7rnD4qnzEJGg1FeMDD2BgcWrKeEqeEUeif8066RVCh
 f2UBX+EdycZBopsfq0zNL2abQw==
X-Google-Smtp-Source: ALg8bN6TO1FbNtMlIVAjW1BVMM3oHyWOjmaELAmNdxvrNWJv7TnKOomM9mKtRD4mFZlffvniflMouQ==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr26518104wmf.6.1548846287340; 
 Wed, 30 Jan 2019 03:04:47 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w16sm1138208wrp.1.2019.01.30.03.04.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 03:04:46 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH v2 5/6] arm64: dts: apq8096-db820c: Add HDMI display support
Date: Wed, 30 Jan 2019 11:04:36 +0000
Message-Id: <20190130110437.5424-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
References: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_030451_264443_2E0D30E9 
X-CRM114-Status: GOOD (  11.23  )
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
Cc: linux-arm-msm@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Archit Taneja <architt@codeaurora.org>

The APQ8096 DB820c platform provides HDMI output. The MDSS block on
8x96 supports a direct HDMI out. Populate the MDSS, MDP and HDMI DT
nodes. Also, add the HDMI HPD and DDC pinctrl nodes with the bias
and driver strength specified for this platform.

Signed-off-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../boot/dts/qcom/apq8096-db820c-pins.dtsi    | 52 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi  | 27 ++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
index 6a573875d45a..1c0d06f59d00 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
@@ -62,4 +62,56 @@
 			bias-disable;
 		};
 	};
+
+	hdmi_hpd_active: hdmi_hpd_active {
+		mux {
+			pins = "gpio34";
+			function = "hdmi_hot";
+		};
+
+		config {
+			pins = "gpio34";
+			bias-pull-down;
+			drive-strength = <16>;
+		};
+	};
+
+	hdmi_hpd_suspend: hdmi_hpd_suspend {
+		mux {
+			pins = "gpio34";
+			function = "hdmi_hot";
+		};
+
+		config {
+			pins = "gpio34";
+			bias-pull-down;
+			drive-strength = <2>;
+		};
+	};
+
+	hdmi_ddc_active: hdmi_ddc_active {
+		mux {
+			pins = "gpio32", "gpio33";
+			function = "hdmi_ddc";
+		};
+
+		config {
+			pins = "gpio32", "gpio33";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	hdmi_ddc_suspend: hdmi_ddc_suspend {
+		mux {
+			pins = "gpio32", "gpio33";
+			function = "hdmi_ddc";
+		};
+
+		config {
+			pins = "gpio32", "gpio33";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 6d50449fbcdf..1e78f0b47c89 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -452,6 +452,33 @@
 				perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
 			};
 		};
+
+		mdss@900000 {
+			status = "okay";
+
+			mdp@901000 {
+				status = "okay";
+			};
+
+			hdmi-phy@9a0600 {
+				status = "okay";
+
+				vddio-supply = <&pm8994_l12>;
+				vcca-supply = <&pm8994_l28>;
+				#phy-cells = <0>;
+			};
+
+			hdmi-tx@9a0000 {
+				status = "okay";
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&hdmi_hpd_active &hdmi_ddc_active>;
+				pinctrl-1 = <&hdmi_hpd_suspend &hdmi_ddc_suspend>;
+
+				core-vdda-supply = <&pm8994_l12>;
+				core-vcc-supply = <&pm8994_s4>;
+			};
+		};
 	};
 
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
