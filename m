Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD8AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:09:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AF8206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rSoVKBQn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6lTl0j/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AF8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KDW2bBiKkP+aDz0xJveIwhhSN4+dMWbV0DwLRrRLKMk=; b=rSoVKBQnSfcoMj3gAXq0l6oDRj
	rri3aMzX39AhtZe1EF6cwFQoDCtO0FquGJ2CLV7QiMoWaubCnqPkbxVAPtgpsYIQxhqYPDyDG1STI
	+HVL3nioadoheTVHdPJHlXgqo+eUxBClb/IYqdL7HRet0TNZK7ZdF5tUc/RnkOcJpiEIUpBP89pUc
	U0dSjGhSdNebfTNAivzkWW1luLtDMKG02bPZsJNIPdjTo3bXYb5oMhut366IKAF721GQwfvsu5tvq
	442dqebPW3E6CKQFStLo3qe6kzd7LzeenXN6OcOu/FyIhG90UBQcTBFCshXTV+XyKM8otk3Q+mZkw
	JMleVp+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghVOn-0001wb-Nh; Thu, 10 Jan 2019 08:09:09 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghVOP-0001XD-Jp
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 08:08:48 +0000
Received: by mail-pl1-x642.google.com with SMTP id b5so4861890plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 00:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=s471nejhsjTfcdDaXDgAGqn3s53gJX07/ZFUZW5j13g=;
 b=E6lTl0j/ez81RlorO/ahP9ZD+M0S2i1xKYNwIHIfWR5+KOhxpZCS/oiuVpu3PpYFZD
 3gWzMTdcemwBNXEt6m3/CTog8fi8bPfJUexd8tpng/ezzuDmsd+xi9JV0kdQoL4u9G07
 vWTZX1ITsMLKj/kYSssG05CaR5xiG/pyrXwC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=s471nejhsjTfcdDaXDgAGqn3s53gJX07/ZFUZW5j13g=;
 b=LqsPB25v5Jk9DFwFK7Jwf0bWryPKABpQfkzTeTA2GZGqRfjt8Lk7IAl6OsW+lAzn71
 iaAfRwgOczhE2fA3Wsq6SXQhoxtnu3OSeVbZ7QtQs8BzSVd4Geg8perIU8pWeoxhTQdd
 tFKL3noW17PjJdhL92d2y9aHZ5gndKRezsliUX5vyFAVlDNEdbXazA5yGGD0Qonql2sk
 W+Pd3EhnfjhBILMCvVJ+upUj6Sa6ooE6o/9DxciVnntYx9+Rp8wNz7U4Gvg7OHZFiJum
 qRKYsYQYJV2DuuBQWORk2oW9OfgRgISO4YdVGmpRNtkIZS3VL1Rx5V2SpcJvMb5cf6G4
 0obA==
X-Gm-Message-State: AJcUukfpz6SVhEYmS5ZXKXa+NVlLWQsCFOFKii+K0OMpI47+DtIbmMUZ
 zseIXOT626Yay4l9p33DuVoV
X-Google-Smtp-Source: ALg8bN6tb2tVSzhlp99qSCj2VD8vXapiODKSWACxvsWYxU6McbqpOqoMvnU3s5KddyTYuofLPaFhig==
X-Received: by 2002:a17:902:9691:: with SMTP id
 n17mr9629649plp.9.1547107724619; 
 Thu, 10 Jan 2019 00:08:44 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:89d:654d:749c:afde:a8a6:224d])
 by smtp.gmail.com with ESMTPSA id w23sm27401007pgc.72.2019.01.10.00.08.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 00:08:44 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: fsl: Add devicetree binding for Oxalis
Date: Thu, 10 Jan 2019 13:38:20 +0530
Message-Id: <20190110080821.30280-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
References: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_000846_064079_D8BDE4B0 
X-CRM114-Status: UNSURE (   9.74  )
X-CRM114-Notice: Please train this message.
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

Add devicetree binding for Oxalis SoM board from EBS-SYSTART GmbH.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 7fbc42484001..b3bc70665a47 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -172,6 +172,10 @@ LS1012A ARMv8 based QDS Board
 Required root node properties:
     - compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
 
+LS1012A ARMv8 based Oxalis Board
+Required root node properties:
+    - compatible = "ebs-systart,oxalis", "fsl,ls1012a";
+
 LS1043A SoC
 Required root node properties:
     - compatible = "fsl,ls1043a";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
