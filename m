Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C881C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:20:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFD220839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qXl1dneJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQvTQBJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFD220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=DCl53drh2X08W71u8RN9OobyeIbSpkXROlXcWa+tGlY=; b=qXl
	1dneJTz6Ygc4QihqKYAMJxJqa+NZFTfQrQUKOHO8llt03Usu5HO3y8HtqNzaZmQu9gRmuOCFQ939r
	c8NZ2toWY7yz/B7+OIy/zANh8/m2CI3AXMS8YTKoyGoxcng35s3xW1mCRw6Ga5mAQ/sa8t7t27n/9
	1qVh+GN+aYBpO1uai00OpugrFLiB2SlPqiqqEGat0HI9XHyaiyfHPIpXYSx9f+K60gFW56Wo3HiTd
	3aUb6Oqv9+EKcVqSlClQGBQ/x1KVGMV42vRX7fwxVynjGFEPTkEtrINbF8JlLxle2QdruLBb/SZUZ
	v5YRdY1H9rPHk9lRtycwKAELAP/UynA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX7FP-0000EM-7J; Wed, 12 Dec 2018 16:20:31 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX7FL-0000Cm-VB
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 16:20:29 +0000
Received: by mail-pf1-x443.google.com with SMTP id b85so9108360pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=6Q/+2+qK3okIZ1zaF6zOX7bxQDy3cH8F5XXDZkvzn0I=;
 b=pQvTQBJazVT5wuzAdIN01sbXVVwLqsdG3UjOUbZYtXgt9O1Q0M9LHr+wJvK7MOjxd5
 1OPzYRQOVG7r5Ta+8W9hEnZXPDOzW3QZDVTmpeaEdQSCxxkKziNJ0WKzyeiQiujI4E/j
 rGmybZZwMMsHUlq88CJiCB0Oa+vCNxDn4YsUijWHaWkhRZJWGFvuqRdybhCDEaTnCn3q
 Kz9yd2alymKBrJNRF19vRpd+vVpe+emBuCYsHP01xHY+9YWrKMUzb4KI47UOLZf/+MLh
 yCmJNeIy+4eL1DU0CMO0oMLddWGGtJXstkxzpXQcZZ9aLJ0T3jrF0c3NTEiB9WvtpXY9
 YLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6Q/+2+qK3okIZ1zaF6zOX7bxQDy3cH8F5XXDZkvzn0I=;
 b=gAPw4JAzUXTB1wkXK8kQpBcwr02wAlJZTcicDuAb0YzDsbHLIKgus1NRIv33BGDFPc
 7eEYwM5VleW78JYTvbJNIuVn/fSloM6Oib/Ydvh6mzV1FU7QCdJ0gkLG8Qeq5M4flPJ+
 nUXqIf3QqykYD7xKD0hh7Y6+t+IkUfimbLKMMiPTE6tRUuI94E+zrkZ8DUEV5Jg6nXJ0
 bHvSb5OmeZO4QzeR5NQUTGrBeXH/Ixm9V53Y8M+/43TTYy6zzzNHFaTh6L0w1IXBdM7A
 NBxTZ20wynQV6Y/Bu94rjPPZK4k+TZrWSILWRRqHn9M8jEGF2ePq5D6dW41i9sQlt6Me
 0B4w==
X-Gm-Message-State: AA+aEWaq+nBTfpppWHpX2BIJUTtGG1/CZdaULwZf6pAC49fuuhFMft2W
 Hz8weA35QElAe2p0a91u8iM=
X-Google-Smtp-Source: AFSGD/WGb+lQDbWNpoQEbGn7/dYu9dzescV2XMisM88YcFvhFjxPijOYP3QbAmqaUvl6tOebdz2krw==
X-Received: by 2002:a62:7086:: with SMTP id l128mr20645206pfc.68.1544631617047; 
 Wed, 12 Dec 2018 08:20:17 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id z62sm27586179pfl.33.2018.12.12.08.20.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 08:20:16 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: kyungmin.park@samsung.com, s.nawrocki@samsung.com, mchehab@kernel.org,
 kgene@kernel.org, krzk@kernel.org
Subject: [PATCH v3] media: exynos4-is: convert to DEFINE_SHOW_ATTRIBUTE
Date: Wed, 12 Dec 2018 11:20:14 -0500
Message-Id: <20181212162014.23409-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_082028_007917_F52EEB57 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/media/platform/exynos4-is/fimc-is.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index f5fc54de19da..02da0b06e56a 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -738,7 +738,7 @@ int fimc_is_hw_initialize(struct fimc_is *is)
 	return 0;
 }
 
-static int fimc_is_log_show(struct seq_file *s, void *data)
+static int fimc_is_show(struct seq_file *s, void *data)
 {
 	struct fimc_is *is = s->private;
 	const u8 *buf = is->memory.vaddr + FIMC_IS_DEBUG_REGION_OFFSET;
@@ -752,17 +752,7 @@ static int fimc_is_log_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int fimc_is_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fimc_is_log_show, inode->i_private);
-}
-
-static const struct file_operations fimc_is_debugfs_fops = {
-	.open		= fimc_is_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fimc_is);
 
 static void fimc_is_debugfs_remove(struct fimc_is *is)
 {
@@ -777,7 +767,7 @@ static int fimc_is_debugfs_create(struct fimc_is *is)
 	is->debugfs_entry = debugfs_create_dir("fimc_is", NULL);
 
 	dentry = debugfs_create_file("fw_log", S_IRUGO, is->debugfs_entry,
-				     is, &fimc_is_debugfs_fops);
+				     is, &fimc_is_fops);
 	if (!dentry)
 		fimc_is_debugfs_remove(is);
 
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
