Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6721FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:25:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3398C20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Df6mISCz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ltbdWbyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3398C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3XtVgDEptuOZWzBZw+LrKoxEyZZlzxhIoEkhZwIS7Cg=; b=Df6mISCz5StA1Y
	EOGZSlmlsPWVa8IPpqTY1rkeupgf8oMvqRKM7u1uKOtWqgfKLGxWhVh/9akscR4+9KbNuxtUhAuM0
	19CiGebw+MpJ3k2RoDc+MbKCI2Tp+05ZJlDxCNtWU7HRf9roanP7eKMDq/canQmsqOMn2robn/qIe
	tTgljyQgvga/wDHkYaMbvhRox++/yUvKj6mZ0kNOexMQaChZExY/t3UYhsFKfk/DZbjVPmv7Korig
	tdA5WTAiqXSWhQVZyCKHrB/wu95jnd1A+myXxWMro+o8xoMWqDJw/lYGXcW8aCBGbnDKdV8S/MK5h
	JuBNUEirdLFpb+bar9gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0Yg-0004xC-I0; Fri, 11 Jan 2019 17:25:26 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VN-0000Pp-En
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:05 +0000
Received: by mail-wr1-x441.google.com with SMTP id j2so16082689wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZCWTPLj1wbSsS1IA9/4GHyR1fEd02J/mQnVEGIGX0jg=;
 b=ltbdWbyDi0jBWv2fbbnv1XubGMt4cHhglnamBW9t0GJo1n1uv6QcU3yKXXjRILz478
 xndStFoLPYdJWGYWDzDnw33Ro+p/6OErGCtePhwLvb4PkESMpluH2f5Whrg/I/X/Q28L
 5a8d2/UjTc7qe3ec/kPkwnBWHklnZgKLm7nNCT16ZkXZEdOsSrIrhXHzdcZV9PHFeSms
 gB8bKxPJkRldTxu6LKo0rnDH7RZFrEF8kEKQm1n62ggdjeDMizcMVYNb+D5jTw6OLREi
 LwMe4sqEqQ/ylf36pIosNZP5A+rFBq6gkPimybEzRnArKVwQSRFBX03mgCkpimb0Moin
 yWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZCWTPLj1wbSsS1IA9/4GHyR1fEd02J/mQnVEGIGX0jg=;
 b=PMASFadRJafGhgNI372ETokYwj0qktlj6b0fpPEhghmw8iDoM5CNHOXRLRAGVhhZFe
 +e+FAW5SGw+MooD6ghI6l4HIX8GYrKYeNTdTpdpAyvfdQkQPGel9WqJr8JzbIR5Uli1M
 vm1rY2K3g2FO0rXcCskUeNng2mnsM+xLnYdvD0yCGGiEBxsQapEOhmpRGDQyIT1sfEhC
 JUugBydk1X/OxDG52JbBlTMncVJgRi6v8qARWls11neI/4qo4Lp74k0tlePOL8zzB9xv
 Mzko86BAGXcsyLSBCPeCEDdXGKvLQxwktDHJqlh1It72seMCZ+8ljfU8ke7yMzj8e/0b
 Ok6A==
X-Gm-Message-State: AJcUukeYeZ0L4MHPQLil/CT7omkH5OgChl8gk6bOZq+kybuGvu5TwhuZ
 exNLGa7cjhqCtKJhzViFGNmtug==
X-Google-Smtp-Source: ALg8bN4CbRi2RRXk862TNhcRJmqfRrGD5w/qHOZK8fNsp+aOcWTFAbyHJd6NmsUQGtkQLZJqaZv/8g==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr14965839wra.81.1547227320100; 
 Fri, 11 Jan 2019 09:22:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:21:59 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/17] ARM: davinci: dm644x: WARN() if clk_get() fails
Date: Fri, 11 Jan 2019 18:21:25 +0100
Message-Id: <20190111172134.30147-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092202_155332_024DB0DF 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm644x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 38f92b7d413e..85d69ac1bd70 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -681,6 +681,7 @@ void __init dm644x_init_time(void)
 	dm644x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
