Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C31CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:41:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8A2206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IC/RZhbe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mscUU3ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8A2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hS938JsgAvQB3Ub2lOFujUgGLcf6RkwCmz8ZVQqG6Gg=; b=IC/RZhbeuRBrlo
	N8tiaN+rf0BIOIN6yZcAZkUA3KuHby8uDjOb09b7g0unwc0PR7alKAxymdWsjUzoHUQ5t01oj02O4
	JroQIOEwLPKAeUFuam+aMIzuBZW7MOqLKw0rFyLGRnCKZKT5Tmy2d7yLTSa2aDnRUqKY0oUNHiwAa
	Kuew/Ur8v5wVn07s5KF4ZXVJLh4nQOCFaUjRISrpPDz7tOwQn5Tktr3IK1IYOf+wuxuVYEuH4jG7e
	GhKu28Mdhe93VSY2Jdn2cZ/J51euspBHbJvML94+VGHx8/2OjXiW147HyyOCc7JQEb0/e9Zyk/uyH
	AFuPMQGZorWO23TropuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnt2-0005Z8-FO; Tue, 08 Jan 2019 09:41:28 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUR-00070o-EQ
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:16:14 +0000
Received: by mail-ed1-x543.google.com with SMTP id b14so3461250edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=syCNYOhWI2Fa3CkPeYThsu7drj9CGAM/9EZeMe/84fg=;
 b=mscUU3ZWKPFNJHUEfNCsIH9Q6oMXrfnX4GjoBcDTTRTCfpTqqskB8ocUk3JJS6f7nH
 F1QPu6fR0Qc/E10AyfaUCOcJ9Jn3owXgOnusdSM3Wa953EWG+ixmUezdY1iXoo3X/SAM
 Y+tqYuuJrzNetOMRfLn62Ki31x5ODVN8O+Tassm3sW7pgpIBNeMPIRgJr7s2e6UkIGCz
 05PF/B9vBpQp++4E3934cLafg0iezy9iHXPYypudW6fD29Et8K6rxh18Ni12NwuXSOfU
 shPXkmpCuR1BbJCz+O4a6UyJ8su0KQPQ2ye74GXElSqM92Aifsb53Ao4lkBtES/sQZ0c
 uOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=syCNYOhWI2Fa3CkPeYThsu7drj9CGAM/9EZeMe/84fg=;
 b=Q5e+v6s1W+2VxzkpCYUksJZjvPObxGN2o9tmq6pjoCAqQ8KBtdr5Ew/uLiljCaB/7G
 G7azzldefHisSJ4KwcQYLDy2auYGFRDwnpP9N641gHWDCmq7GVictsFjwF8ocfJpsUbY
 JzvBBNbI3GOt+V2sXTfjrCbrp1PT6/TCVSepwbZrnRU9bTz2L5uFTC1k1gAKy/FKHW7I
 DEAznTjYwcbqoppc8f9j+i3uUzpR0WoJMwhdj2T69qR6/3qScBCcJvCrZXfwDmQoNoiT
 b2F/Q/yUePqsKT53rYsAKoQ8uX7Q4+Fv7WJ3H3zF/WW8lIAXKC1/ZgqyEqsWK2/+cE02
 LVBQ==
X-Gm-Message-State: AJcUukdj5J7RHt72I3koi/FkOytaiJPGqJV+FbNAvKnMC6Kamq+QDgOL
 O94M7Bb9CsF02lH8G6XxGoV7Cg==
X-Google-Smtp-Source: ALg8bN4dDw5IvyscDJ7IN+fJkMMKyW2fwpGh6nsmSR42EOQznEqT9Y6G2fSaVLrGxUkS9e2x57NcyA==
X-Received: by 2002:a17:906:5202:: with SMTP id
 g2-v6mr1163630ejm.139.1546938962046; 
 Tue, 08 Jan 2019 01:16:02 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.16.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:16:01 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 10/12] ARM: davinci: mityomapl138: use nvmem notifiers
Date: Tue,  8 Jan 2019 10:15:37 +0100
Message-Id: <20190108091539.16674-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011604_483279_9E23E24C 
X-CRM114-Status: GOOD (  15.14  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Stop using the at24_platform_data setup callback in favor of nvmem
notifiers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 3286dc2457a5..ac1a1699d185 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -15,6 +15,8 @@
 #include <linux/console.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
+#include <linux/notifier.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
@@ -117,10 +119,15 @@ static void mityomapl138_cpufreq_init(const char *partnum)
 static void mityomapl138_cpufreq_init(const char *partnum) { }
 #endif
 
-static void read_factory_config(struct nvmem_device *nvmem, void *context)
+static int read_factory_config(struct notifier_block *nb,
+			       unsigned long event, void *data)
 {
 	int ret;
 	const char *partnum = NULL;
+	struct nvmem_device *nvmem = data;
+
+	if (strcmp(nvmem_dev_name(nvmem), "1-00500") != 0)
+		return NOTIFY_DONE;
 
 	if (!IS_BUILTIN(CONFIG_NVMEM)) {
 		pr_warn("Factory Config not available without CONFIG_NVMEM\n");
@@ -152,8 +159,14 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 bad_config:
 	/* default maximum speed is valid for all platforms */
 	mityomapl138_cpufreq_init(partnum);
+
+	return NOTIFY_STOP;
 }
 
+static struct notifier_block mityomapl138_nvmem_notifier = {
+	.notifier_call = read_factory_config,
+};
+
 /*
  * We don't define a cell for factory config as it will be accessed from the
  * board file using the nvmem notifier chain.
@@ -183,8 +196,6 @@ static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
 	.flags		= AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
-	.setup		= read_factory_config,
-	.context	= NULL,
 };
 
 static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
@@ -561,6 +572,7 @@ static void __init mityomapl138_init(void)
 
 	davinci_serial_init(da8xx_serial_device);
 
+	nvmem_register_notifier(&mityomapl138_nvmem_notifier);
 	nvmem_add_cell_table(&mityomapl138_nvmem_cell_table);
 	nvmem_add_cell_lookups(&mityomapl138_nvmem_cell_lookup, 1);
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
