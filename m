Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C47C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:43:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AE120989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F46u4XVF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gsfsUrM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AE120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=v2JufePRDoZhUFDlZZ7BXzjBV+4xbQCIq4RkBZn9bWg=; b=F46u4XVFtJOw8V
	R6OsAY49uvfRrZ+3JEk3I0LD653/2LaDwGrec2T885MQ51j4UgN3qPQrUZtbSKoR6GoTGwNmXvEDN
	0nO2F5tWtaFOj/Oei5kp2yLkN6k9UkiS9EVe6J0hF20XJqzsDqII3//hRaPgmY87+AQcO80ZJL3At
	qQ0ZDr0TRL67no9L0vrIIPiOPVsoTnkvAbwICMxrzLMlhMyViX3gYNMQi1R0tx0LJ/4EA1Vc3t3C5
	XGOIGtWhetSI72c5T5CWLc7BuY9SNc9sy/jZNGHGjJDEQaEW+aIbSNACpa5XgLnAuxniSQ/iiy8af
	4CuEX2JWEIXM7fWCnX/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3Rk-0003ae-0o; Mon, 28 Jan 2019 09:43:16 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3Rh-0003a0-Aw
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:43:13 +0000
Received: by mail-pf1-x441.google.com with SMTP id y126so7760007pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YM2ZHNQI2khAjcv6Vrmdn4cezBg7JA0PyCO1gIR5Rdg=;
 b=gsfsUrM+Ys1mCAS8vqjbU9AehXt68gUQkd/v3xwBGDuIrTzo+C2bDx20C3AJZLS3jh
 awLrzMvau3Nbl5Enr0SF1+KaWkB4EZVW4FTSXZrewBZOtU4BJ8uxjWXszS39gikVd8AQ
 et0lI1c2QnAjTdm1rSXy6L5e5mAX/i+WDZWm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YM2ZHNQI2khAjcv6Vrmdn4cezBg7JA0PyCO1gIR5Rdg=;
 b=cVjYVBpy6UI/93S04L5OMLLp2Cge8E5Yu+rXnotjsK3Ux+1x9ffgIKrWxUPJVwDzCf
 2l27y1SjeMaZ3aFeZkhNghnNM6UPPAJRRxWpX8BS5/YbGXH6XryczFG1wSYrZEFqAVBE
 HnkiM3mv8nIhGSPenPJWYY4gO2XuEzLhissnezSPtjBph44cDDu+rlB/dRej03c+v69E
 0rw4nVhHBeglCPrLwFPgISbDTsSjH29uAseDl70qHdgnAz1rTQIUzL5TT2M/W6lSjmTE
 YLIqEIzTnlhA1u4Cj1ezNs3w2Ty6zBLMWr6xO5DCqFfJssscukAH/mp3n/fBhArYvK3C
 3Jxw==
X-Gm-Message-State: AJcUukd2rWVHeFuH5f1bGQ3T7VpnIhp0ACIpnxrbVHbh+CKdMZq3j3qr
 6Jm/yhW92Xv3rKhtWBiJPeDuuQ==
X-Google-Smtp-Source: ALg8bN4aTzsOlosWumNEebFd04aodLTvqDjvOLmNR6Bo/r+RA3UdqdxtE+N+7+teRckjTgs+OuamwA==
X-Received: by 2002:a63:4745:: with SMTP id w5mr19611608pgk.377.1548668592103; 
 Mon, 28 Jan 2019 01:43:12 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
 by smtp.gmail.com with ESMTPSA id v72sm56998027pfd.163.2019.01.28.01.43.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 01:43:11 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Will Deacon <will.deacon@arm.com>
Subject: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
Date: Mon, 28 Jan 2019 17:43:01 +0800
Message-Id: <20190128094301.151252-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_014313_398314_75D594F7 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

L1 tables are allocated with __get_dma_pages, and therefore already
ignored by kmemleak.

Without this, the kernel would print this error message on boot,
when the first L1 table is allocated:

[    2.810533] kmemleak: Trying to color unknown object at 0xffffffd652388000 as Black
[    2.818190] CPU: 5 PID: 39 Comm: kworker/5:0 Tainted: G S                4.19.16 #8
[    2.831227] Workqueue: events deferred_probe_work_func
[    2.836353] Call trace:
...
[    2.852532]  paint_ptr+0xa0/0xa8
[    2.855750]  kmemleak_ignore+0x38/0x6c
[    2.859490]  __arm_v7s_alloc_table+0x168/0x1f4
[    2.863922]  arm_v7s_alloc_pgtable+0x114/0x17c
[    2.868354]  alloc_io_pgtable_ops+0x3c/0x78
...

Fixes: e5fc9753b1a8314 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

I only tested this on top of my other series
(https://patchwork.kernel.org/patch/10720495/), but I think the same fix
applies. I'm still a bit confused as to why this only shows up now, as IIUC,
the kmemleak_ignore call was always wrong with L1 tables.

 drivers/iommu/io-pgtable-arm-v7s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index cec29bf45c9bd7..98a4a4a0dfb0c1 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -217,7 +217,8 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 		if (dma != phys)
 			goto out_unmap;
 	}
-	kmemleak_ignore(table);
+	if (lvl == 2)
+		kmemleak_ignore(table);
 	return table;
 
 out_unmap:
-- 
2.20.1.495.gaa96b0ce6b-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
