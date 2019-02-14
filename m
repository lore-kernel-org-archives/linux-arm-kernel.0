Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A16C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:58:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BB0222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BfVawZNu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SY/FJts2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BB0222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tVM8WQbKu5IB42G5Wxyxu9/oJcs0+2zgaB5/f18hju8=; b=BfVawZNuUyYzxm
	OQ05KFRsaLEhu2/7uXjsv4ff0mjTFTXZvJSd1zzXx0Z89AsqM51IypTULeg/jQ26RN3RVsLuXguS0
	1ZEEZfj/DCuVWV62hjQv3x8vWXQQfiFBlPQx4a1RXji7i9h6igrzM9IjY06BFiDAUbJwe/i8IOwa+
	tBOC6rory/IG6zwJarJz6wHnYsv27rR75WW59X9cVd5mcZDcDRToEBj1y9oX0Rbo9zo/e6asYQMya
	j6gNKHZHQzXvRODld2NsQ+AIDScq5+z32VgrKXeo2I5xaAKOUH/SPqPDa9JmMlEq2AsLA9JBvtThq
	YPX7THI5NRSxRv3XuaZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guISb-0003nw-Ah; Thu, 14 Feb 2019 14:57:57 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIOA-0005Zo-81
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:45 +0000
Received: by mail-wr1-x443.google.com with SMTP id x10so6771137wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B4SJAgxGTa64FJdlSVfppZLdm94nwsUmmnlWWj2uXAQ=;
 b=SY/FJts2nGo8N9rDrnd0CygEqjRdybYQygidnGL/IYHQtPPXRYGBsv5Fe4ze5JyTmX
 LzPmTBuSk7eilzhaXEJ7ZO/+xeEricwQEblfaWYF8J32tAPyCEZIcpX+aTMCjDm8/3v/
 75cGmvxSWQFfP34bohqvdP56DoiHHRl1ya6G/XbSRVdwhFijoQ7evoaVatBv1yKSUuaY
 FZqlREPOmJkS7XA8OQB/Aq3vEkaRbILzp/sMZZ5Mkn5s44XJEueVVFm3HNqcdjnu8A6p
 5Pa4YVxeGRpOxcX3/6O4S8d1l0Rvb2eb8wNhon4dNjwoOMA55TykqDLdsG192ubGTT0R
 N5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B4SJAgxGTa64FJdlSVfppZLdm94nwsUmmnlWWj2uXAQ=;
 b=Wu73F6rfV5qYiiX4DCkzwn7DIksIfDSQeXpEwCjn7889L7MnrUW90DyOZpyhh3okzy
 GgS44JFAw+aBjp/qKtN3/QRSp9PFsW8AQ46dTQK583bKBx+v7/HKvKOM6190eGXh8NKG
 6H2yu2g0Tg+BOmvcpfYqHOZP8ciFrFV+79EKU9RPZyE7F6KGR2EuHa6r6FKfMSYnUnsw
 Bb8MBQryx3cI35gLqs64lKLf/BHug4deqbUvQHf7VVE3Kn0tSC3GnP7rgRBPa7sfeWcM
 8+2tiu5slHnjppaYoO9JjMHT2mYT2yEa3/ka2kCptECzZGMFaNt0Ush3Lp2gJNbueStD
 dS8A==
X-Gm-Message-State: AHQUAua7XyVDisfYmiXd0jGkGhORO5/tWhA17LDAzeGAm1HzI4qhCmRJ
 lPh3aUtVyhyCSXeWQjSTAkaAxA==
X-Google-Smtp-Source: AHgI3IaPujT99IIEBVSVoccjAhOWaMFuOqy3d9MQS4qedmwtMkYGinhq/Z41+E2A556hkYLlO/lWpA==
X-Received: by 2002:a05:6000:1287:: with SMTP id
 f7mr3298876wrx.203.1550156000905; 
 Thu, 14 Feb 2019 06:53:20 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:20 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 32/37] ARM: davinci: cp-intc: unify error handling
Date: Thu, 14 Feb 2019 15:52:26 +0100
Message-Id: <20190214145231.8750-33-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065323_055898_8B6B5282 
X-CRM114-Status: GOOD (  13.98  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Instead of dumping stack traces, just print a specific error message
in aintc driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 25221dfe8a20..1bf11fa8be76 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -177,8 +177,10 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 
 	davinci_cp_intc_base = ioremap(config->reg.start,
 				       resource_size(&config->reg));
-	if (WARN_ON(!davinci_cp_intc_base))
+	if (!davinci_cp_intc_base) {
+		pr_err("%s: unable to ioremap register range\n", __func__);
 		return -EINVAL;
+	}
 
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_GLOBAL_ENABLE);
 
@@ -210,8 +212,9 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 
 	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
 	if (irq_base < 0) {
-		pr_warn("Couldn't allocate IRQ numbers\n");
-		irq_base = 0;
+		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
+		       __func__, irq_base);
+		return irq_base;
 	}
 
 	/* create a legacy host */
@@ -220,7 +223,7 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 					&davinci_cp_intc_irq_domain_ops, NULL);
 
 	if (!davinci_cp_intc_irq_domain) {
-		pr_err("cp_intc: failed to allocate irq host!\n");
+		pr_err("%s: unable to create an interrupt domain\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
