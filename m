Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47927C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:23:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F239320855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rmMw1ri4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvEItE1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F239320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AFAED4m2+EV38xrlaC+NIuOs2LllNs6A/AQmTkrBoGQ=; b=rmMw1ri4dwFtnef6katG8T4M85
	gZtHvBRKfugr7RfqbHuEaWozR5bebJ5xlrUp5CElsybE88Xa3DFHpy1Fwsxm55bJPf1eQZy2bJDMl
	f3grDQi9WQZOC7zIWOBSyHO1p7m4Rm9LgVe59AaWhM19/N/fvmcEdncSqsNHB3Dy9tpclGBAFMrq1
	YmlHHxqb/39s+lnmKwWAXnb0z+KLpNRlnQL7dRHUSlyWlbL4EmPX9Z8rlEMVjq9o5HpSF0nm0HySP
	UwQhuIT5zW8TmpLp2g4ngVPo904bwh7Pow0jh8KSJCUG5dhPfSuN72BuvP52ByKZCHnpNdkuQkFFo
	1MG9OTTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glnam-00020E-7d; Tue, 22 Jan 2019 04:23:16 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glnZs-0001Hp-R5
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 04:22:30 +0000
Received: by mail-pf1-x444.google.com with SMTP id g62so11092036pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 20:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=z8BYTp8mhM/pilsodAKivXfXoRjeqU3Tj9aOBeEVYqE=;
 b=DvEItE1NiPV7p/vSyCBMjpexW+q0uRczQQLq0s75ULzh413ZovsWdPBMAsEhPzK9SK
 4WuWYl5H83Ou4mDtYAQK4aE4M67LfklMKcMu1BP+JhwfggJ55vcvnYEDX1ypP1Qe+7BD
 o/dbTwt5pNEvlgjDc421pBNC8VaixHFlIRqOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=z8BYTp8mhM/pilsodAKivXfXoRjeqU3Tj9aOBeEVYqE=;
 b=BA0zwsi5D8T+0EOAk6ThY+MqggQ0S0vzM6K4BusV81UisPI5l3+HZb087Rzdv3OdgY
 hXLzhQ8CujfIMJvHYNDSRCIkZ5pZElD5gntUuR6MTKmAlKadf2+VVVH5Ol5NHekl2VWm
 YSLkMaNOMGjBTkTtvIJ0vT9slKNdDLsZaQzW455wOy1feQZ8qB+xrmQR+MzV6e8VBg+/
 oMBBFUKmHFQvbR8JMJS4FrK4xi7MQKSISP7j8E5gu7QqspUTrnslslutgjlhy+Q2OAun
 LG8fs+6vcn5/835CZtdWqHdL83ZRoMeuHeHdFTdtGqocbP2oHMu9PL7XSK9kQUwQIrIt
 /umg==
X-Gm-Message-State: AJcUukdkycmPURG8NC1X90HgA2cbg5AyR0He7NcfT7l8hhMeFGF2lcqq
 BgQU48bnvcdht/nm+MpZGlED
X-Google-Smtp-Source: ALg8bN5aVRMENZwWODam+9GBXodJhtO1QXkbGFKxoyR3b+ubqSaDT2avkxozUJ575izNZjKdx67xKQ==
X-Received: by 2002:a62:da5a:: with SMTP id w26mr32240493pfl.106.1548130940258; 
 Mon, 21 Jan 2019 20:22:20 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
 by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.22.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 20:22:19 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH v3 4/5] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Date: Tue, 22 Jan 2019 09:51:46 +0530
Message-Id: <20190122042147.5424-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_202221_251930_02F46DF5 
X-CRM114-Status: GOOD (  10.73  )
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

Add devicetree binding for LS1012A SoC based Oxalis board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 20fb61006f2b..6f85965e9fb4 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -176,6 +176,7 @@ properties:
       - description: LS1012A based Boards
         items:
           - enum:
+              - ebs-systart,oxalis
               - fsl,ls1012a-rdb
               - fsl,ls1012a-frdm
               - fsl,ls1012a-qds
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
