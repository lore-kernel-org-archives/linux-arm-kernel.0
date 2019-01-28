Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A958C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:50:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB162087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uo9COPN8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOzFILp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB162087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=k5tK0CrSw4ML27MtoKkzOiGP2yreP5v5+tVSdatgkEM=; b=uo9COPN8VmH53R
	rh4xL22r4s6ncCQtTdKhKeP5Y2XRX1yIciJeoNr98SIYjc4bZo1e4Mi6gdgrXGnsK3sR6Eikg8fVW
	rhcysnC0ut+QYFd4P8hFz8ZQhwaay3mvxL3/EFST04tkVhC67eCkHTVfCxsvf2ie+Gsm9zdq/LXk8
	rQmZSeCmYbkgZy8zDChYQbx79l8AtuULiynIjYXT6fjquzil9XLPjuiguf0E3bnSSmXnTVBhNSyTu
	M72n5YtxmgOF6xT9XX4Y8lELx0UwPrX9MSDk7vduV4xAUOH8lEKrfwidxj118TuJmPN5+dXb58JXl
	ZbxR+w+LpOpMnhuzXlag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go7Id-0006Dv-6N; Mon, 28 Jan 2019 13:50:07 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go7IW-0005oR-Ux
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 13:50:02 +0000
Received: by mail-lf1-x143.google.com with SMTP id p6so11927776lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 05:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AiZvB0E5Pl9On7hsxkTERflPl7J4LOC/VIOv/AccAOU=;
 b=GOzFILp/TcukYNWnxug3YtbVbMeoHEA4o94AGiIp8xZDxjWa46bsJAc6QQZRRm6SdN
 NL5Z7APBIaLOTNqsyMHM9Zgh8uEmbpvZ+PdsAVCxorZe02cPx2YVjRG/WMsYuF8s7idV
 385mHQiFILLq2Hil6lUCtBAch8aIIxXJMznrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AiZvB0E5Pl9On7hsxkTERflPl7J4LOC/VIOv/AccAOU=;
 b=heQanrK6xECaX0tCYaUhytB1fGEUHCBbdh4szYhKHIh4tDFi+ftt3/OF8lUC/RBRZN
 Q4nqq+FvRTyRPmlJtci5uYH6FAL5Rodl/Yf6kLY9V+XgNQpfN4Z6sY3JYm5CB9S44piT
 mxnUsUAifAlNiwPHHGXjfCoDOIFVP5rJn6lRbdFB84lJDf9idmwhMSKOK6u2D3kIgUkt
 lX5O5QYnlmOgNNLH1HT7ToubPFoOYkPLpDQABf1S3ekJc4czhMwtvnG77+AKwGASComI
 acbc1sJGKefOM2aYxJtHmY3VxvM4od0gX6HMKL0n2A063T847ZSC1cHvlNnzKVTUGZlc
 SQzA==
X-Gm-Message-State: AJcUukcr5HG/tuDfvVz4Ye2Xf5WTMcDh0NJZkTvR/WeMwszDzaXpygEh
 bEyGH13j4FBjbSgRQb9amGH6Xw==
X-Google-Smtp-Source: ALg8bN58YKRAWL5Mr8WmnsKPqGDHrcxa2SBEiQauVaGMHP0SOiGKVNuwmoJnhsLzGY3m4XHhe745wg==
X-Received: by 2002:a19:8096:: with SMTP id b144mr16116460lfd.8.1548683396777; 
 Mon, 28 Jan 2019 05:49:56 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id q8-v6sm2961499lji.69.2019.01.28.05.49.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 05:49:55 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: arm@kernel.org
Subject: [PATCH v2] ARM: defconfig: axm55xx: Drop PL11x graphics driver
Date: Mon, 28 Jan 2019 14:49:53 +0100
Message-Id: <20190128134953.14726-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_055000_997541_FABAFA17 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, linux-arm-kernel@lists.infradead.org,
 John Logan <john.logan@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The defconfig for the AXM55xx includes the ARM CLCD
(PL11x) PrimeCell framebuffer driver, but the device tree
for this platform does not include this hardware, nor do I
find it likely that this chip has graphics.

Drop these config items.

Cc: John Logan <john.logan@intel.com>
Cc: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Collected Krzysztof's ACK.

ARM SoC folks: please apply this directly for defconfigs
for v5.1.
---
 arch/arm/configs/axm55xx_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index 8e17e7ed1f02..53864316bee1 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -155,10 +155,6 @@ CONFIG_PMBUS=y
 CONFIG_SENSORS_LTC2978=y
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_HID_A4TECH=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
