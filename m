Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68059C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:12:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AEA2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gbf8EQC0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="L+sKfSVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AEA2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S/3wnXTbpdQVh/R+W9L3FaZ9TgwoMt2fQ5o2tYBElKs=; b=gbf8EQC0LE1zCk
	R72kuQLWTooivm1FJYuUgdsoF4794WJ2bIJ/lfiWlCJkiIuQhviAB8OGPL/hAT6GWrDY0dztCME8q
	/ojVMrHVdCovSzjc6kH/yfE4xaMOX2I8Nq+nTh72utpEGwVRfnxzBbFdJzjSvKEArjyyX020U3lD2
	47vnaxf6OXG9XwqJUKQZeS2fM0Se8iOcRYvXfqazBF+1buzBS2QMaj92nXuKN6fAvwgLcG7BsZ4k7
	ggkYuj/txnmrBupJhGLcrRH0wbgRm+zptiDl90SPn3AfhqGp3a5awkMD/LdvGN3/EdxZ13/b8RyPv
	CSMdU+b7swfLQNUb5BeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf4f5-0004nb-Q0; Thu, 03 Jan 2019 15:11:55 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf4eX-0004BH-Np
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:11:24 +0000
Received: by mail-wm1-x341.google.com with SMTP id r24so35006312wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 07:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UWJWZZulgERjeASm5OPhNm8DDTWU4vIOyd+OG5AXAec=;
 b=L+sKfSVoSFpnR2cCgGPWnhqAIvti6WS54mBOHrTm6N22eM/XWKvnmszR28T5tMhgmD
 i/BzdyANsf8hldO3/FlO9l/ItkyMXOFsYTldmeordPlCMlexNlZKOP9gaGW4nnYH7jGP
 z7b1Sp26yhjG+C1DG2NxGsGlO6ajXuewy8EfYVi2V2u0CVXupESTQMCclFAqxWyL9B1m
 Hf3pyqSuf/zDW6cMZgiJtAJ/Ynj9Ixe7jRCxIzTK0tPKRzDD5HQJ98h3CKKZwHKwlnaJ
 bV7ULddFW1aWAdT5zZveRIG/4qHPJNeXtp90+3cEELToejm0vZ5UoqU2pCaZro92i9eM
 AWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UWJWZZulgERjeASm5OPhNm8DDTWU4vIOyd+OG5AXAec=;
 b=gGv8BQ0QOo2dqQ6q6tm738++5SscZQI0AkcMSFjMQCqEUVUBpya5Mpj1V1h8s2VfNI
 UUVJ0klmDFEzNh4c+lh1UwsQsF1nWzsN0DZ9DGHuxgpzMwtk3Uysd0sX4+IfKx/LxxPA
 ezzBxzUGhni3gj+yjxR4pVb+NbHKBZzdRxTZZ6NYTffmbMcYqHFxDqIZnkM0Mj9NYXkG
 HiniWpVcswSF53upedKOdqAIPP57jzi/TSBjPhED8WSEelgPp4Ahe2sLF1in0glLc1Nt
 j2BIHnQ3gmdZndossYzIdVB4aq8JrtOi8PXumylRzTzhaqllqpnFgVHa1vC5c1hyclS6
 4b5Q==
X-Gm-Message-State: AA+aEWYEMog5vgjDAuLCZN1Gfdb+CbyDC/sEJ8AX7zc2Z0q4MGTslytz
 ODyJIOOkZvDSyulGTIa6qFwiGQ==
X-Google-Smtp-Source: ALg8bN6PCUvz/cxT6+XRAoazQ4VYiP/T5jYo4SZ3HPxrIpV5+BxkbEed1Vjf1Xd0mzn52R8Lovx2wg==
X-Received: by 2002:a1c:a895:: with SMTP id r143mr36694420wme.95.1546528278238; 
 Thu, 03 Jan 2019 07:11:18 -0800 (PST)
Received: from debian-brgl.baylibre.local
 (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
 by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 07:11:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: [PATCH 2/5] ARM: davinci: da850-evm: fix label names in GPIO lookup
 entries
Date: Thu,  3 Jan 2019 16:11:01 +0100
Message-Id: <20190103151104.11839-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103151104.11839-1-brgl@bgdev.pl>
References: <20190103151104.11839-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_071122_042068_1CE62FC8 
X-CRM114-Status: GOOD (  12.05  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") the gpiochip label no longer has an ID
suffix. Update the GPIO lookup entries.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 6a29baf0a289..44bca048dfd0 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -805,9 +805,9 @@ static struct gpiod_lookup_table mmc_gpios_table = {
 	.dev_id = "da830-mmc.0",
 	.table = {
 		/* gpio chip 2 contains gpio range 64-95 */
-		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_CD_PIN, "cd",
+		GPIO_LOOKUP("davinci_gpio", DA850_MMCSD_CD_PIN, "cd",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_WP_PIN, "wp",
+		GPIO_LOOKUP("davinci_gpio", DA850_MMCSD_WP_PIN, "wp",
 			    GPIO_ACTIVE_HIGH),
 	},
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
