Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A570FC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:18:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D17A21902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UhqQ/aNb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xekeLArv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D17A21902
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qrZeYKkhXLX10guwDQmfbBszEEOEBXOvLeu1APip4Ow=; b=UhqQ/aNbULuy3O
	ygfMsPZGpuMjQ1cNQo1p0Txg0KO/JRxfdqvX2uDR46Oezodqx9mUlrhSUuGyrrbZVXzwdEDN09rwv
	Bi4vMxAlBA7G0fjgCZ1ul7/JFZQ4/VvyMGv2Ewr8GuwATX9pYMVMSupM644tIiOD0wz0qaliS8PtZ
	Gkvd5D5iXMkL1OCfJ+xkCVHaYJSypmhB2W/07J8S9naMKB9YCK26soOwdK1DEHQ7vtziJAnTf8Xe+
	Iz7v7KLXKtCNR1nYSzoQtliXRt+QiGYipdFZ9Xt486SxeZoyh3qErJAEhEsZkJjxpbmVtqcTYJqxV
	0RT6wemFc6uk+OLY95gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhh6-0008WN-Nh; Thu, 07 Feb 2019 11:18:12 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhgc-00087C-T1
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:17:48 +0000
Received: by mail-wr1-x443.google.com with SMTP id r2so11047437wrv.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 03:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LbpoBRsypdTGREkLevfYOmN/+f576KJEExTxTQozG1I=;
 b=xekeLArv2SqmtefnkYskRI5SOxiZlgYE/u+IpxrKpPoL9f4dMAk+VWS9YMso+XSKso
 RtzyKMM9rVn9ZnzMy7bBBDx7zPGDa3lVhbbddrjV5QgRscd3qxa0HO5ar6PFMsgOvBH7
 Fp3FyHFPlNBqHO6NqpFw85H/QIXQBE2q1gg/rpq32Pr7YyPFSi5i+cXclkMBSdaSPu+N
 WDCOrIEuvVP60iD2Fzqxx04lYuwvFCAIFdV0Iq7+Mo4LIbbWT02GTpVoLBhfPuWgQrrH
 rSwP/BIsTPKM32+B9mvzgOgDGho6IUV6MvlJlcnnRTsaiS2oRxh2VYlm9/Wr5tKfvDU2
 A0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LbpoBRsypdTGREkLevfYOmN/+f576KJEExTxTQozG1I=;
 b=svdIKRO6c6mred2boT9fp+semm/6WShFAWJ577ryi7e0tgLdOcDdk3fzPcAZrRpts6
 txOnIIfa98u73J1ReHMBdvHypbUkR9QIqrCWp8kvAFCF3JG4NprTRZkJPJrp2PJVF+IP
 O0le+xStEk4p/taQEmGAAJr0dW4CsiNsyUvKypS/WZT2hk4/n/G5XeNbJjJowFnoZFjS
 V5oFm30WIdXhA3f0BHTzNBudBQu4dPvZViPidx8iiQQm/8xH/Yur6fIuxXxs5Sw8LZ1z
 dLk5PsqQQh7cCoAhlWby4LDT6ZIMHr+Y2p4KYT0Iw89w7aXBHktfTFIIuoeJatb4uiXc
 Goyg==
X-Gm-Message-State: AHQUAuYeadiu2s+2kn9nu1eiwNnOOUu4x2+YMNGmPJrRdJbXJRgdkhQb
 K0SP1kNuqHZhq50Ft+ou9SIFaA==
X-Google-Smtp-Source: AHgI3Ibyx9sci/B29k7DCAhPNZF6PlgRln+oZkpPg2znflAAlKybEU+QoLbKXKr0XAj6mQA6iRhgJw==
X-Received: by 2002:adf:9123:: with SMTP id j32mr12508598wrj.122.1549538261159; 
 Thu, 07 Feb 2019 03:17:41 -0800 (PST)
Received: from localhost.localdomain (42.red-95-121-90.dynamicip.rima-tde.net.
 [95.121.90.42])
 by smtp.gmail.com with ESMTPSA id a62sm24490224wmf.47.2019.02.07.03.17.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 07 Feb 2019 03:17:40 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh@kernel.org, bjorn.andersson@linaro.org
Subject: [PATCH v4 1/4] dt-bindings: phy: remove qcom-dwc3-usb-phy
Date: Thu,  7 Feb 2019 12:17:31 +0100
Message-Id: <20190207111734.24171-2-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_031743_379842_29CB6D61 
X-CRM114-Status: GOOD (  12.69  )
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

This binding is not used by any driver.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../bindings/phy/qcom-dwc3-usb-phy.txt        | 37 -------------------
 1 file changed, 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt b/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
deleted file mode 100644
index a1697c27aecd..000000000000
--- a/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Qualcomm DWC3 HS AND SS PHY CONTROLLER
---------------------------------------
-
-DWC3 PHY nodes are defined to describe on-chip Synopsis Physical layer
-controllers.  Each DWC3 PHY controller should have its own node.
-
-Required properties:
-- compatible: should contain one of the following:
-	- "qcom,dwc3-hs-usb-phy" for High Speed Synopsis PHY controller
-	- "qcom,dwc3-ss-usb-phy" for Super Speed Synopsis PHY controller
-- reg: offset and length of the DWC3 PHY controller register set
-- #phy-cells: must be zero
-- clocks: a list of phandles and clock-specifier pairs, one for each entry in
-  clock-names.
-- clock-names: Should contain "ref" for the PHY reference clock
-
-Optional clocks:
-  "xo"		External reference clock
-
-Example:
-		phy@100f8800 {
-			compatible = "qcom,dwc3-hs-usb-phy";
-			reg = <0x100f8800 0x30>;
-			clocks = <&gcc USB30_0_UTMI_CLK>;
-			clock-names = "ref";
-			#phy-cells = <0>;
-
-		};
-
-		phy@100f8830 {
-			compatible = "qcom,dwc3-ss-usb-phy";
-			reg = <0x100f8830 0x30>;
-			clocks = <&gcc USB30_0_MASTER_CLK>;
-			clock-names = "ref";
-			#phy-cells = <0>;
-
-		};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
