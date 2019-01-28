Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB4C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABFA2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UcrEhXkM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFVq7lgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABFA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8sN/DEQtHQi798cr8xS7NDE2kPFZ6WFAymetgistbrI=; b=UcrEhXkMw/Gwve9UW0dj/oDGM5
	3Wuk1omeWIU3cXg2YPB6UyPhqeXh486Fk1BDxFhQAAalS88YF+VTtHPhDP8nCogAi/utQ4SKDj1uo
	bttumC1tkq+wRYAqiQiksUmGNK/NudfSMEg/wbdgvhUCUywYAFPDTMZugKK0jAYRYToNV7pjAhynX
	dwh+bAQA7RQDrJ3EA6MP15MnMenIm6XXdlLnEriSGNfu3iUjPDWi93DfIcJZhzNPHWV6HcSiUTMd0
	63C4D0enFVpdeAMJ4hLjUGXSJDRnaM9uyiTPez7A8Fdx4mYGpSRBAO9j7X1QCCm++0jkyWCU/7xdg
	iYdOy/Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5M6-0004O4-Ta; Mon, 28 Jan 2019 11:45:34 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5Lo-00047j-Aq
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 11:45:17 +0000
Received: by mail-wr1-x443.google.com with SMTP id s12so17667525wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 03:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OjZqKa0JsCFXQBMWFlziSlyjddwilKU0eYG9FICLYwE=;
 b=YFVq7lgrxQxLmfi0tFZf4vrtQu0raMENfQHUf6OEDCObXMd0SuBHmmmzrgArPBA4PW
 7rEmobnXsKn1wXlQxz+YoopbgkpQ9cZOUbTKUbXIoY2tNLUUQ/1Ef/tHQBLQP52Y50RQ
 +xTkCvBIUMW7fE1Lfs76af7Iy3Hkm+bsPe6vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OjZqKa0JsCFXQBMWFlziSlyjddwilKU0eYG9FICLYwE=;
 b=eWe3kE5sOGKU04Wtzebtgz0s7XF4gZEmbEBtT5lWxwck4N7z14VpvGTKy6NgqnE7Xd
 ODWRPd7jESG7t3QjmoHujcg1ixYnEIf0GmZnprkaMtEZ76gpTYL/hq9AyWpg1L9r79sB
 PCp8ai6U9XSpIVFU7DHAqRxYvjPLKxk/m/r0o8ZqNtNYTF7DqA62r0kVIWnutktK6TxK
 cLdoPG1jmTXmobLs3pqm8Avio22jd1ltM5bC6YqkVUq4dnDjj97ZKD/3pBpmrRiwNW8R
 l7EMH9ytP7XT2S0xXt/Sm+aGwZs9JQgr1sq8yWzPANZ+IF9xBNpOEvK5SHr4tQ9OLmaQ
 KEWw==
X-Gm-Message-State: AJcUukfeiLY+yQiZxkE5G1VcWHHNIrVw0t8er9smhtOHq36YG43ljh10
 WXdyhxFiWsnhzjMb4vQPJQdgWA==
X-Google-Smtp-Source: ALg8bN7xFthXe1kgQ/y/bEMicB/fxWPJWQm8Vb750rYFL0VZ2qCIbSZ4KPcPnP8YDkd7DWGv2nnh3Q==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr21057133wrr.201.1548675914895; 
 Mon, 28 Jan 2019 03:45:14 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id z9sm122968775wrs.63.2019.01.28.03.45.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 03:45:14 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH 1/3] dt-bindings: qcom_spmi: Document pms405 support
Date: Mon, 28 Jan 2019 12:45:02 +0100
Message-Id: <1548675904-18324-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_034516_376673_2CA496DD 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: devicetree@vger.kernel.org, vinod.koul@linaro.org,
 linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 niklas.cassel@linaro.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The PMS405 supports 5 SMPS and 13 LDO regulators.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../bindings/regulator/qcom,spmi-regulator.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
index 406f2e5..8ee7aac 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
@@ -9,6 +9,7 @@ Qualcomm SPMI Regulators
 			"qcom,pm8941-regulators"
 			"qcom,pm8994-regulators"
 			"qcom,pmi8994-regulators"
+			"qcom,pms405-regulators"
 
 - interrupts:
 	Usage: optional
@@ -110,6 +111,29 @@ Qualcomm SPMI Regulators
 	Definition: Reference to regulator supplying the input pin, as
 		    described in the data sheet.
 
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
+- vdd_s4-supply:
+- vdd_s5-supply:
+- vdd_l1-supply:
+- vdd_l2-supply:
+- vdd_l3-supply:
+- vdd_l4-supply:
+- vdd_l5-supply:
+- vdd_l6-supply:
+- vdd_l7-supply:
+- vdd_l8-supply:
+- vdd_l9-supply:
+- vdd_l10-supply:
+- vdd_l11-supply:
+- vdd_l12-supply:
+- vdd_l13-supply:
+	Usage: optional (pms405 only)
+	Value type: <phandle>
+	Definition: Reference to regulator supplying the input pin, as
+		    described in the data sheet.
+
 - qcom,saw-reg:
 	Usage: optional
 	Value type: <phandle>
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
