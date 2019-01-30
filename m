Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C0BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:51:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC0C20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ErZe4ysl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFDxQf+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC0C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F3EC/AvObaiJdO8NNT0khEpHE+Z5V7epZR23zAiVtGw=; b=ErZe4ysl++Cxn3
	e03sI5jZ0/wXt5IK3lH/6bT2XpKHQ5AIDpGMK4/jUKyQIOcWhc8lLO2ltvoc37buZf3+JvcRPO0Wv
	s87/yHR9gq6aw8qvGDtuf3AO8QaTjSj5fS5c29rYxQ5W5Pm2vBeNdF0d/gFHwndtYXGd71wWLb6j9
	wOLDjC6jUdlNOYjYkbkBjBcprqw1MzFfrvzEhmi4L10lb6VM+4r379ihHJjUgISeepHSvZ6OO/w49
	SwXzWAoO5KsW9VdwjVI7vSCEqybUSpMpMHjOHBiilmyuYMq97Jw/PFsLdThyp8IziNwTFNvr+tMPm
	3k1yVr4B9y8jmhJg1C6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouww-0007cd-Ei; Wed, 30 Jan 2019 18:51:02 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouwc-0007KY-Dr
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:50:43 +0000
Received: by mail-wr1-x444.google.com with SMTP id 96so661362wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b8M0eSUZUgsVMGxbQEiMn7Shg3Ln/ABC8nhad3aEAW8=;
 b=dFDxQf+czaJhUfGeIlbm70Wl9zp/5W1fiO5HXUnNF2AMiVHO0EhU23lql7yB/Z0f+I
 SpdhfHqPOpr+RjZMAIKeT7MDhSIO/78jUyICa+tBMVrZRajRAOeXdSMLUtev57k1q+Xl
 MO+RwsBYQoB8DOETq66dEJllaU03UjJfG6gNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b8M0eSUZUgsVMGxbQEiMn7Shg3Ln/ABC8nhad3aEAW8=;
 b=ME0MawCX9AZX94pAyitYr3k7tOpsbFfNQ+DU/m7ZendS0EAoI8dSWnPFleSaD0S4Fv
 c0RSGg+VMkoZhom7DQRlXWSDTSi6MbP3M+tkW5nmigeIUuIkZm2QsDMUYEsHB28S4jcg
 ZIXUknE6cEBG8K2D4oVZPhQsd7hELFq8qF4a6futBQ4vgFEViY68ARkwnxFXMft4azK1
 qAVzjD0zuR16N7Bndw2sIuhEM2J/0+sJt26MeJElP1gQTRm27DEmLyWSMyUOJxaSRCeB
 QOafCJcoRM1FG+LqMzbNcD/9BpLuAzEY8zWD4axm+DTwrI97lvyalgUXAthls94werGI
 rSyQ==
X-Gm-Message-State: AHQUAubBIjS80HS21WDYHBMxMrChtwpt0Y+HmmKpJlAoZe5lHZex6olf
 VmhsBOVR5CP4WPE9+PkHlwg7Jw==
X-Google-Smtp-Source: AHgI3Ia4JDkY7jy1nqI65XPeHAMK3bonriibvkW57xRkiJeNQzfJsiPjMIfqqrcwnLxbVqvNsPFYiA==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr10756623wrp.92.1548874241097; 
 Wed, 30 Jan 2019 10:50:41 -0800 (PST)
Received: from localhost.localdomain (99.red-79-146-83.dynamicip.rima-tde.net.
 [79.146.83.99])
 by smtp.gmail.com with ESMTPSA id a17sm2802575wrs.58.2019.01.30.10.50.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 10:50:40 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
 gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
 jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org
Subject: [PATCH v3 1/2] dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
Date: Wed, 30 Jan 2019 19:50:30 +0100
Message-Id: <20190130185031.24798-2-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130185031.24798-1-jorge.ramirez-ortiz@linaro.org>
References: <20190130185031.24798-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_105042_460118_2BA8378E 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, vkoul@kernel.org,
 shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Binding description for Qualcomm's 1.0.0 SuperSpeed phy controller 
embedded in QCS404.

Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
definitions.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../bindings/usb/qcom,usb-ssphy.txt           | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt

diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
new file mode 100644
index 000000000000..83748a07d665
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
@@ -0,0 +1,74 @@
+Qualcomm Synopsys 1.0.0 SS phy controller
+===========================================
+
+Qualcomm 1.0.0 SS phy controller supports SuperSpeed USB connectivity on
+some Qualcomm platforms.
+
+Required properties:
+
+- compatible:
+    Value type: <string>
+    Definition: Should contain "qcom,usb-ssphy".
+
+- reg:
+    Value type: <prop-encoded-array>
+    Definition: USB PHY base address and length of the register map.
+
+- #phy-cells:
+    Value type: <u32>
+    Definition: Should be 0. See phy/phy-bindings.txt for details.
+
+- clocks:
+    Value type: <prop-encoded-array>
+    Definition: See clock-bindings.txt section "consumers". List of
+		 three clock specifiers for reference, phy core and
+		 pipe clocks.
+
+- clock-names:
+    Value type: <string>
+    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
+		 property. Must contain "ref", "phy" and "pipe".
+
+- vdd-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator VDD supply node.
+
+- vdda1p8-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator 1.8V supply node.
+
+
+Optional child nodes:
+
+- vbus-supply:
+    Value type: <phandle>
+    Definition: phandle to the VBUS supply node.
+
+- resets:
+    Value type: <prop-encoded-array>
+    Definition: See reset.txt section "consumers". PHY reset specifiers
+		 for phy core and COR resets.
+
+- reset-names:
+    Value type: <string>
+    Definition: Names of the resets in 1-1 correspondence with the "resets"
+		 property. Must contain "com" and "phy" if the property is
+		 specified.
+
+Example:
+
+usb3_phy: phy@78000 {
+	compatible = "qcom,usb-ssphy";
+	reg = <0x78000 0x400>;
+	#phy-cells = <0>;
+	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+	clock-names = "ref", "phy", "pipe";
+	resets = <&gcc GCC_USB3_PHY_BCR>,
+		 <&gcc GCC_USB3PHY_PHY_BCR>;
+	reset-names = "com", "phy";
+	vdd-supply = <&vreg_l3_1p05>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vbus-supply = <&usb3_vbus_reg>;
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
