Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C547C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C282070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rSN8rg8D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JTyFMNoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C282070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uPYlUDOPU5NrM76LH2q5IXHf34dKYBFwJRYY8h5hfDg=; b=rSN8rg8Dq3DkeH
	qaHutU4cAVvCJrk3OrlQwhTSrS90w+r1kNcvis1L4VCB0kOq5ggNMsvnqY+6firsLp8VpDWETMOcn
	aJMtqvRDtoSlgk2vU6N4sb4MZdGrHT9onK7g+Us16g+JALGrO5njQghlfWIFHn6ovVyQyvilHZJCR
	0HGAMpMAvmduZLE5CKj5ThXnzYNIEgt2o2+cIycEt2f8LVdDk3bKmAqFGTbTSkWXHuikqB48ivF+x
	LP7d9dk6HmCDdu4xw/r7mt1BV9U4QEXX6fL5/KCBffu0Qe8He2DHaRYnafCB0v5b4/411P/o10n9N
	pCMNq/0kVdD29e/s80aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf4eg-0004LW-EE; Thu, 03 Jan 2019 15:11:30 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf4eU-00049g-Ir
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:11:20 +0000
Received: by mail-wr1-x443.google.com with SMTP id t27so33877051wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aKwFZaBRHlpAL4NyBpL6IVUugaHSo3atuqW4V0FtM2c=;
 b=JTyFMNohkRlhdNgkXpADXeirbaPnQ729Jz0hDZ/7YCNMvsABHAYzTtAd2g5wWkjRqT
 /w9xMWbUpUqm/ANQgvMzDHeMuavasT34FIyT14K9Q1aOF2VjuvnrIVf9CQbuF17hnVog
 bwG3ZdYN82yFoDsDzXASuTkEm9tQrRpnklq9iKQsjjCy8uKqc/piiJ1g6GpN/n95m0EB
 Z8C8fMNWMR1wlaSXo3ipHwdiPlSGxFJiyUO89ODEopAGs0QenoLpnWhgXc+euGYmhMps
 9lgnvFv6J9poBsH1pmUnz3PhkPx3Z0zHYTH/XLbzhLW6TmFh6oZaWIU5O2feNIX1zC2+
 wA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aKwFZaBRHlpAL4NyBpL6IVUugaHSo3atuqW4V0FtM2c=;
 b=HuFuqs/hA+epNhSu62wBHcIxUkqqhoIgSWdkaINm2/BaOi1Y0uGOfNfp/xe6U8Vbz2
 3JjTrcZBOVDWYr3NKmXYUoRznKw1cA+XHjM0M+zJuiERHolphxrM17z266NxlN9XTvXz
 Lz63iManPeB41P1KTtMNhMVm7QfpTaoSQ2St/X+HaNrriY4tRX1Uuqnjy9ZVg3W7V0sM
 AK9SgwP096oQBqqc0w1fAjOGP1tiddC5jADOTNBMsMm9k2Ujfj5cWBkxrWVHC4oUn6lo
 2IlRPv56Bk1hY6fx8DSXxrK+opfNrx63++1ZaQltMnX2SjHndpB+DVfALttZVLkEQm7O
 1Z/g==
X-Gm-Message-State: AJcUukeqz9Q7K5t9Ue9Cd28HZXPEvm7/pVr7Bqfs5HK9QBQ+Ub/GdZzD
 M7cLj1hnKxV/DnfRgh0xESdJVQ==
X-Google-Smtp-Source: ALg8bN4M1S0x3YPo2ENcFhdQ5C7fw+iK8m8C3oprqYtVIG+y4ru2b2rIvveCLlkQRb3Kky0/rx7J0Q==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr43619386wrm.239.1546528276956; 
 Thu, 03 Jan 2019 07:11:16 -0800 (PST)
Received: from debian-brgl.baylibre.local
 (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
 by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 07:11:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: [PATCH 1/5] ARM: davinci: da830-evm: fix label names in GPIO lookup
 entries
Date: Thu,  3 Jan 2019 16:11:00 +0100
Message-Id: <20190103151104.11839-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103151104.11839-1-brgl@bgdev.pl>
References: <20190103151104.11839-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_071118_616554_B4B612BF 
X-CRM114-Status: GOOD (  12.11  )
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
 arch/arm/mach-davinci/board-da830-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index e52ec1619b70..c4da635ee4ce 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -208,9 +208,9 @@ static struct gpiod_lookup_table mmc_gpios_table = {
 	.dev_id = "da830-mmc.0",
 	.table = {
 		/* gpio chip 1 contains gpio range 32-63 */
-		GPIO_LOOKUP("davinci_gpio.0", DA830_MMCSD_CD_PIN, "cd",
+		GPIO_LOOKUP("davinci_gpio", DA830_MMCSD_CD_PIN, "cd",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.0", DA830_MMCSD_WP_PIN, "wp",
+		GPIO_LOOKUP("davinci_gpio", DA830_MMCSD_WP_PIN, "wp",
 			    GPIO_ACTIVE_LOW),
 	},
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
