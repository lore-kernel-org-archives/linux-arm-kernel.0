Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB95C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:32:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E171B2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K9PAwQHZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfCP86VN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E171B2229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GZfwHqIrp77KGA8qB2AWOTVCb3SK4L2qP5fldFk4R1A=; b=K9PAwQHZDkpj3dVZyNz9+x5i2a
	cL4UT5BXWs+iRfP3FP5c5TJGv7W4Wnyp1BXGANNN99sZ8b2AvYtPRVXKJq4K2QacWM3wQHbpPty5Y
	Yi1ijE7kOrf+GpU3Wr1gYtoo3lUrRgluqG66xUWXaRZCIT8ley78gfjWXBH+DqzmoUvUQm+OhpwLj
	n+hyZpoV7tZ4BPw0IVJ3OKbePMYzh/0KASjQ7Q0jDc8vMcjfml3KUcnf0MvcMdhdFhJ9N4YfCCcBY
	3Yx61IgrW1eo4/Snbea2gJXNuwLMelfHM8ofKnSLEyD5s9LF51Mup9CVwcjzUEA3Q20sjB5P02AQy
	+IqmfwRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCRU-0001vN-7X; Thu, 14 Feb 2019 08:32:24 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCQy-0001SU-Jq
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:31:55 +0000
Received: by mail-wr1-x443.google.com with SMTP id r2so5422650wrv.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 00:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tD91WMqXaqgalqYQc7fEccQT9a1D1s8fFsgbNnR5LZI=;
 b=CfCP86VNJP3saEW8dXsAgGRyMQ77IFzw2YxFhxp6j2BsNIqLwq9QD1MBeT5t+raGYe
 Lei1SuLaf2xEvUhJ+A41lp85+8WixEnaa/pbuU+U+xoZVa+tejh8Yr5CCm+SyJ44XzXX
 aerNrCQdu5wKiL7FSfyUsXDxanH1x1hZMz4Ca9I2fRnB04sLWyj40nVcWTXoDB87+Kgk
 vgG/kr9VVvvCdWHOz10tO5zQBD/ZI8uKdYg60aD+daI5DFcKiruTramEDewzC5S5QbTX
 +ad3pr7CFMfrWbnz6Kqt7XOZN3O6jc0Leb/hjzvCoLuyLq9Nmtzv1gEqVKD+vWdN2kk7
 x75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tD91WMqXaqgalqYQc7fEccQT9a1D1s8fFsgbNnR5LZI=;
 b=gpd9hj70kC+bG5RCS0dGBxBVrC+Cs88pySbNXZNubtNUPUFLy79KVN7y/X1qgpyqQi
 SWAlRplIPGq4A5vG3BqnDf8Q+lSzvb70BvJ2MYUIadh8pBXyHVReKAgrykp1evP79K1D
 ndm40BHeDVViyQka2egVghV5DsnKJuBqPGL0GNDXF8dYV8JNXlnzxeWxC1/52+v0Qxax
 6IGILCjQW099rjaOMrI5sYW6g+BK+vs0VJsq827ywFI95VRrl2F62hynHimsyKppI81b
 fJlZiSXrElG4KBaVgPZTFhoRSRSc6GnKjHuPMeLLR5btuWC2/TRDax5ALjPKC5+UWLOL
 na7A==
X-Gm-Message-State: AHQUAuYKHBouBbxBoNefvsnU+3j0nJ6Lrf4CJI1LXIudHLwfLz3Lysun
 4XIF2c4QxwdXzwFGEmws/MidYg==
X-Google-Smtp-Source: AHgI3IaI9HhYQJmJbOenn3Ox4CqhbhWHyAbXzyLYanlwbz04Bz2Dn0aY4MhXRu2LOGnrXyjzuYQWuA==
X-Received: by 2002:adf:e706:: with SMTP id c6mr1798741wrm.278.1550133110672; 
 Thu, 14 Feb 2019 00:31:50 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:104b:51c7:1dcf:5141:50b9:8a8])
 by smtp.gmail.com with ESMTPSA id q6sm944673wmq.4.2019.02.14.00.31.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 14 Feb 2019 00:31:50 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux@armlinux.org.uk,
	arnd@arndb.de,
	alexandre.torgue@st.com
Subject: [PATCH v2 2/2] ARM: stm32: select ARM errata 814220
Date: Thu, 14 Feb 2019 09:31:45 +0100
Message-Id: <20190214083145.15148-3-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
References: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_003152_650579_96A87613 
X-CRM114-Status: GOOD (  10.72  )
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
Cc: benjamin.gaignard@linaro.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Make sure that ARM errata 814220 is selected by STM32MP157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-stm32/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 713c068b953f..be2403fa3deb 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -46,6 +46,7 @@ if ARCH_MULTI_V7
 
 config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
+	select ARM_ERRATA_814220
 	default y
 
 endif # ARMv7-A
-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
