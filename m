Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4813C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F25720659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i+GfSOxH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxwfJl/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F25720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/g5SX2DaFrFr5IBKBnH52ThdWkMc+5ein4b8Uf8f8z4=; b=i+GfSOxHrvq5Yjtmb5EOD/m548
	uqXUWVn36AhjM+B7AHkRKUP0VCR99imDo2/80H4g9JhbqNwviU2DTfcV/k1O8Zoh/twPspJh7zTfB
	f0UR4/cAU4IYwmyXlm9e6keWR4z9QZ+bAT/ccWaZ3drZIP+k71vJm0BvbypWgvz5TESRhI+2CMb4w
	qvqoCypbQNh31JID9T2jnkx3gIGwJuUyb1iHZrURhgu7NZ4TTksWjUB+ziourHtaTYJJ979N2Bgoh
	mzkHk+TXsX2n9JXUNK03mJaS/V/K8gfAjbKfUNd3J28DM0XsY3oE5bgkXpcLS3I6tg1VsRenaCbhC
	+L1LKn4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gizMw-00085f-FL; Mon, 14 Jan 2019 10:21:22 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gizMm-0007uz-Ac
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:21:15 +0000
Received: by mail-pl1-x642.google.com with SMTP id b5so9960185plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 02:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4FzCXv3Bf1FI6YrFoBC3pkmqHbI7ffk1SWvM3999Qt4=;
 b=WxwfJl/uccOQmw76DfU1u+w2PDCfxpV7DsL30KnhWR1NMPLXpt951gb8Pm1e96KbaQ
 mI7004CkZIR1B56RoOG16HE5y4R5SbuDN+maYVwyQYKcIlhexp76Wd30ac0kCR/SWHF4
 DpzExwCz2qQCkLIZRV3rwIkWr9Lfe/nJlgSXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4FzCXv3Bf1FI6YrFoBC3pkmqHbI7ffk1SWvM3999Qt4=;
 b=Qy+2xDpIFFZWJgGEDnC5xlo6eltbt8curJ00XfLSk4I3KkTypOV7TZvkeZOTcpXxxh
 xOOqPc4hntvvcfsCCwxMbPlZ/pK00cXlgCIavIJqtvHSazQiJ+uod5WomR9+TL9cLrAm
 sI/C/KGHknQxjJCn33fpT7yzT3qGr4OyNWVezswIM6CtqROXBkWMvunh7U907QzX+jEF
 JaUc+SX5XB4cwo00a3GmDn0bB7HAc0XpUDrd3F9LcE8JUuOEMuiQtIbPHLVlV9Z5lai6
 f5qm6AiIUCMfvtM9Aq+wY2ZSgYpM2vXkZPwXHrnZMqejTdY5wuiRwrM3Dk2VFA6AXQW7
 LYDA==
X-Gm-Message-State: AJcUukcVRcuRMYerCmmF/AwmAbIUKE2s/21HuhSFFT0y6/unUbNAohTe
 qMywnCp9WtLCgR6AVP6BbEqb
X-Google-Smtp-Source: ALg8bN5QsLN2ROqBaEhHGmTeaV77+ILHwBvaBhpA5EYic0Ywo1PaKzZ/HT6LqjzKyhhXKtm2xr0EJw==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr24475661plc.62.1547461271533; 
 Mon, 14 Jan 2019 02:21:11 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
 by smtp.gmail.com with ESMTPSA id 15sm36429pfr.55.2019.01.14.02.21.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 02:21:10 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH
 Vendor Prefix
Date: Mon, 14 Jan 2019 15:50:51 +0530
Message-Id: <20190114102053.16013-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_022112_608265_BF652534 
X-CRM114-Status: GOOD (  10.79  )
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

Add vendor prefix for EBS-SYSTART GmbH.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..38693105b5c6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -108,6 +108,7 @@ dongwoon	Dongwoon Anatech
 dptechnics	DPTechnics
 dragino	Dragino Technology Co., Limited
 ea	Embedded Artists AB
+ebs-systart EBS-SYSTART GmbH
 ebv	EBV Elektronik
 eckelmann	Eckelmann AG
 edt	Emerging Display Technologies
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
