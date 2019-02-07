Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB9DC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:18:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51DB2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="doymvu1P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxCvqmZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51DB2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bRkWIElOo7tNzhjeQJR6A1Yc6rumYXlYlGWBVQ+O1js=; b=doymvu1PThAWH5
	5puG45hgDpEI0szX1EB72VN5skZfnRSAm3T6Ysk1O8wsOPizH2+tz/MzbQoFUKrAbR+4z3dlXx3S/
	1dnLkfRsFv1VzLxdYnkiQMMQ7uFxvfTf0KenV1Q7uya+22qnEP+1QDJI+D9rab8KIJ+O43cJFgDDc
	1Dhe/1DyVvHyxX8fvZRxdnyySvxKZnQXsOEG4RzIsY7I5iEBfYmwR9/bEXPAhxiiRrCSne5lAZEFU
	DiAiNpUBSasBDy+10lgKLBHgZL8MNrQCwz3pZiO/whUaWiQr/nVmSATQbXMkTfBdSVIcMp/1DyiAc
	kO5usafiNlkF8Lbffahw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhhf-0000gn-0T; Thu, 07 Feb 2019 11:18:47 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhgf-0008AX-OG
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:17:52 +0000
Received: by mail-wr1-x442.google.com with SMTP id a16so11144996wrv.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 03:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QnEuMYZYNfZTiAaCyfHqZT4lfGHr0o+uMykks6XX9xA=;
 b=bxCvqmZYTN7U9/njoi8RrudRZSox1QAoMxC0MiTwAetGy1HxGFuJBjmjPC3xWmR+fc
 9+sHOkP/Bjto6EnjqgE/rHZK3cqT3z10RMM+U/P/xO9F/bIJAHi4QUcQGLtqo2H4TIEe
 h7ar0Rw/K1QRa2FLHih/aMF78EIaOeMqr+6yGbmSg2AjqWGTPUfNH2i7CaLSMz48OvIA
 YHntYDfqNBjUSYxocx6c6rluSxb5jiZGAsU2snxSWiRyu32SV2FBIlf1xK4LcPHWd4gJ
 3rYXc2Cahcz5orrUaQsftIl/2THWOhoIqUujhKkk4hRu2FbGJrozhG66O63AOk6MafrL
 1HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QnEuMYZYNfZTiAaCyfHqZT4lfGHr0o+uMykks6XX9xA=;
 b=OlyF3Du/wt7i6GYK3YKt6ADxe9cBo2DiHTSeADxEe8lObN3RwZo2JRVVeANOBdq907
 5J1TjEOEFe+phjzX7aniMr+XrB4mL/RPFuTcRtndwtv8pRzS75qXUe70Lr6cAH18P9k4
 +l2g7pruHWk+eEKMe2/y9rdH0ymoNsZidxza4vj54y45FAK7jcptQyUQzcSmG4Sep6y7
 KjxQWsKSOSWgjgzPVFlt7htGbHS6tfIpy51lknrc9vNmPMOS+adIQvTxKbEgyQ0oMYko
 L92MR8tAPys78j7skCZykn1w/0PZReaplLodAK0IXsaI60gpGfJggqB1QoI/6PhV3BaF
 /Mgg==
X-Gm-Message-State: AHQUAuYIfItCVxEYkMgzUq4qAPkDlyeU0DQdJjAZbODH0CSe3+I53TmM
 g3kCg5VQxgDTWA+QbHyQWcILJw==
X-Google-Smtp-Source: AHgI3IaWxxcYF6UIB2/LiUF7CxbuUic76NgWtAcyZhILDHylwdcEkWIqvblkWwoFC0HdeoylqGpRog==
X-Received: by 2002:adf:84e4:: with SMTP id 91mr11726200wrg.237.1549538264038; 
 Thu, 07 Feb 2019 03:17:44 -0800 (PST)
Received: from localhost.localdomain (42.red-95-121-90.dynamicip.rima-tde.net.
 [95.121.90.42])
 by smtp.gmail.com with ESMTPSA id a62sm24490224wmf.47.2019.02.07.03.17.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 07 Feb 2019 03:17:43 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh@kernel.org, bjorn.andersson@linaro.org
Subject: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
Date: Thu,  7 Feb 2019 12:17:33 +0100
Message-Id: <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_031746_359762_EBAAA177 
X-CRM114-Status: GOOD (  12.46  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jackp@codeaurora.org,
 gregkh@linuxfoundation.org, swboyd@chromium.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, kishon@ti.com,
 linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, shawn.guo@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Binding description for Qualcomm's Synopsys 1.0.0 SuperSpeed phy
controller embedded in QCS404.

Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
definitions.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../bindings/phy/qcom,snps-usb-ssphy.txt      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
new file mode 100644
index 000000000000..354e6f9cef62
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
@@ -0,0 +1,79 @@
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
+    Definition: Should contain "qcom,snps-usb-ssphy".
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
+Optional properties:
+
+- resets:
+    Value type: <prop-encoded-array>
+    Definition: See reset.txt section "consumers". Specifiers for COM and
+		 PHY resets.
+
+- reset-names:
+    Value type: <string>
+    Definition: Names of the resets in 1-1 correspondence with the "resets"
+		 property. Must contain "com" and "phy" if the property is
+		 specified.
+
+Required child nodes:
+
+- usb connector node as defined in bindings/connector/usb-connector.txt
+  containing the property vbus-supply.
+
+Example:
+
+usb3_phy: usb3-phy@78000 {
+	compatible = "qcom,snps-usb-ssphy";
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
+	usb3_c_connector: usb3-c-connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		type = "micro";
+		vbus-supply = <&usb3_vbus_reg>;
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
