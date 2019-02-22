Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58D5C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:06:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96B22070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uU7+Phoy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G05694d0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96B22070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fH3INno3k6B3tblL10RvAtWiSZWsf6eLy+MSd4MG6SE=; b=uU7+PhoyrBne+a
	RPjgAQkio4J5wQdUiVYDKxMfe4wHOwRuv89w8y76iEd9wUQ4LMD8GvG7hWdhbjF9nSjmgiuu8pwvL
	GO1JEwLKeh524v+teBjctw/9TcGQt1aQ+BOeO09ni8hEQnfJUrz21MOE9fPabvT0s+yFDZ7vrzkRx
	uCHtCVloTSZT4t8nNECbLJB/x22LPZ8PjDAud6UQtEVmh+GjoiC8YwqoSzGBLYJPhBL77tD2tVOBq
	qw/7idiRBMOu9VROfVBLVziG8Kxk3FzBN6JDt//EyuORXJ8ZdAzCGtwPtQ4H2ngrFOyM55EOGYFlf
	kaqouvv8zsxyGnrjh3UA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFD2-00015L-U2; Fri, 22 Feb 2019 18:06:04 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFBd-0006l9-Lu
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:04:40 +0000
Received: by mail-lf1-x143.google.com with SMTP id g12so2357298lfb.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QnRZ3rfzwRbPDDTdc6HzTkn6HQQ4M3T5bbjKD11buGw=;
 b=G05694d0OTJpUsO3QC7S/LYh8TaqBs+SeafD31Jy46AXpJYIScpUzo/4Pmpo7ZTda0
 1GcfZn0Rllt4rax+n63QkZ8u/zjwu49nFqqA7se4+xJIOT3790J1Dxj0KQaEO28OdOwr
 UnMLWe1b/DjJiUwGYXbw5MfghxTzJY0Vsf1exA6hz4Z+/2LPW3k15pZSc6w3KM4TNF9e
 wBAhCjSYPNSwE31e8qMeHHYcCDXawSoHkQzrQk/26kjl9QJTq6hKw7RLBxuBdFmsadgo
 tw4vb1phHUHvhY0P4tADJ08EIiggu5ri1Gbl2ZI/hxVWSOSR3R7zBiw8ixO2NGSfiOyc
 KOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QnRZ3rfzwRbPDDTdc6HzTkn6HQQ4M3T5bbjKD11buGw=;
 b=DKlnnWF6w81B6I+J/EB3va1/b8K7cldN72EhkKbnZiBCrIJxDBGywgJVbvv02EubvP
 PtxZekSeTZ8QT8v9GJzFzibYdjZxnpGwjw+/Z1NghuBr8DZKGPeFq+cac1L830OaGvKJ
 caG2T2qGMPe7HTA/hODA4EKvqSHPTXxuli/ZYzoeqLJxwW50Ohnrxlzms5R77RjuxKp9
 b3dzpqRPV814zJdTxPW++cN5SV/xeIdgNwPpPX+LHJEU59kcVo8gPBDUJAQbYE+DA0vG
 i+o1FQtdxU5NpPCEfd+bAAL1nhWv+Prs2cDVSzeG+twUFbDdfXqbG5ej/DTky5tiODBa
 VkWg==
X-Gm-Message-State: AHQUAubzSYkAYmuCAHIDJVjwIK2rwjWmVSs6VJZwU9jj0hFoKjAzqrBj
 3Ucz99dhYkEFpYX9PL3T0Sw=
X-Google-Smtp-Source: AHgI3IasBZa3PuWN1j2x0kUD2ry51mdaHvWnal+iuky2BlV15/ajKA4yAaSOhdkehshKTBaq8BB+0g==
X-Received: by 2002:a19:cf4f:: with SMTP id f76mr3181684lfg.125.1550858676122; 
 Fri, 22 Feb 2019 10:04:36 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 10:04:35 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v5 6/8] ARM: tegra: Always boot CPU in ARM-mode
Date: Fri, 22 Feb 2019 20:59:24 +0300
Message-Id: <20190222175926.23366-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100437_908559_02A61FF8 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CPU always jumps into reset handler in ARM-mode from the Trusted
Foundations firmware, hence let's make CPU to always jump into kernel
in ARM-mode regardless of the firmware presence. This is required to
make Thumb-2 kernel working with the Trusted Foundations firmware on
Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 6bea95d165fa..3bf202819534 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -113,6 +113,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *       must be position-independent.
  */
 
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
