Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89346C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:25:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE582147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eQG1fh4t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFtmYHyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE582147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VS8/DC7SjWnA0hA9h8nlw+7/RkgvQKjyt0wiY1G1r9E=; b=eQG1fh4t6fIzHa
	qH/wUHfy+wX4EItNOXtnwqEis+YB70IsqplMuyiXT24dFbKP7JvNlJWNbwmg9Iyk3WezNJbj08tz8
	5/LScX3IzYjJbQot62nkZQS80bh9nw7q8BAPoB5da4226OX0bWQxlcnwkHCTlv7nA5XiasxbvSWYo
	z9kX/UsYJHnQlFPcv5MMHpK75ClY15j8pSEfuKV7FokwZV4dGBGBXlfWXSEXrZ9Q1hgdapfa/kL7p
	TO7emE/YV8oPJ6nTfj8c6lNU710FPrmmuCn5di76uTK8Gq4yB2Ps7sk+CDQz9AzRBbX36z8F5s5Xb
	MLeqWHUtBy19d+3douuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTOY-0005gd-Pl; Tue, 29 Jan 2019 13:25:42 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTMr-00037R-Ry
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:24:00 +0000
Received: by mail-wm1-x343.google.com with SMTP id g67so17759115wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 05:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zk7ukQ/wi6+kO+yJuF8Jy/OYQIA9+hoCg3pOYSfcHV0=;
 b=EFtmYHyvZYYKy5TBu8vq14EO6NSaXU97FGvpI4ek4T57Em0myXQoBF8xgnOWUr7shB
 aNoMTyq31Opj5ZRzcs2E79MPmWlBpuNuyYIQKaAJXYhyx4mWBp6CBa/tX582vHp2CNOX
 A0NgdPjq0tRYR6zyTRe/PjFVnTa3i7MfOZH4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zk7ukQ/wi6+kO+yJuF8Jy/OYQIA9+hoCg3pOYSfcHV0=;
 b=k5X8LzuZpsaSUBYrlLbS3brtJtYabqqY6pzOP0x6dMfMZg6Xmhm7wOBMhWW0e/ksYu
 fuSht9ExDa41+FZ3pt2rmtPnE8z35+LYJccc+xaIVKK/PoG6ys8YFZXLWkiRIlyYHpWW
 8MKLxpy2CnjMyBYicHca3QovKFe8Lcc+jDmLCVVlPOmrTDBJNAL7jf1vky1c4mbJnZaU
 rxNz6JG+2KlZqdHVLTqFCsssYLN3YlvnlArQ647JWdYZbkD/POnNh0lNRydaESGrhyTo
 76ag847/mGxp2MpoIa4I2KV1doCH+hWe4WS69zcOKZRVf3xySQjufZEqCXtjM5O5eYf1
 QGXg==
X-Gm-Message-State: AJcUukd0acR1gNKEtS/CaffBZx2XQL6cdy5DTcdvu+82XSov9w6WdErR
 9c/ll+BIm7Xdxyf0gFFJ61a/MMAPIgY=
X-Google-Smtp-Source: ALg8bN7wfvQnk+/U6acRCbLaLDfFfeYyiFhSDLFivxKm269KH9OThGvDWL2PZiV1uSLldRhMYnYL6Q==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr21139115wmf.22.1548768236470; 
 Tue, 29 Jan 2019 05:23:56 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w80sm3739628wme.38.2019.01.29.05.23.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 29 Jan 2019 05:23:55 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH 5/6] arm64: dts: apq8096-db820c: Add HDMI display support
Date: Tue, 29 Jan 2019 13:23:34 +0000
Message-Id: <20190129132335.30695-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
References: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_052357_899481_D9F16263 
X-CRM114-Status: GOOD (  11.03  )
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
