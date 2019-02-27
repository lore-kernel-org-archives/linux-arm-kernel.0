Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD10C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:26:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA9A218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GtlJedrA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="lUqUQLBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA9A218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=b+bXlUf55IH7uefW0/cknSo8dklc+YW2YH/p5Gy8+DE=; b=Gtl
	JedrAsd8apeByl9ACi6AAPtScY8F7yVbHQrTdRvM4OJ14F3TYmn5DuBDYwXRuI5bgk0nEzAvwvY+A
	yR4R/UuVjn0/HNBl6DLmu2xU9q1EWrNbJklegDYPVTUdhyxPVgrimOaAo7UnYp8yNGlgiUE3+dPnr
	LJ9BlRkaXIwpas6FYgL/QUP+OReRCaMU2BoIUDfWBmrmg3danE62BGjAt6ZLjeeQdMaOy52P0w2ZT
	sfA96jIFn7fZDprj5jkLZU28ZUzEx3P7QQnuapG0rTwwAsEfLTT9iycwtcX1qJh9b7bz5+EWZUzcZ
	gCpwf3P1l+Ltfe1TRhzEh6rXhD9CBHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyovk-0003P5-RP; Wed, 27 Feb 2019 02:26:44 +0000
Received: from m12-17.163.com ([220.181.12.17])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyovg-0003Oi-3l
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 02:26:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=btUcs3+/xyWYxVRVE5
 2HFznfCYpsm3BUMuXFtIGU9Qw=; b=lUqUQLBZznXZsTROYcOsm7SzLMS5p4lN5V
 cfJ9eb8QboGKMdsqnwSbvCDPLsOvILKr8mx1+faC5IUkKYQ+dNN4d3MYROGqk+yX
 2qDsztZxbMwRxogVlSAcQlJHFq8VGyxip2RoGH/kD0Aqo91IKVSwvZYLjZRnA3/h
 b3Jw9GhXg=
Received: from localhost.localdomain (unknown [182.151.187.141])
 by smtp13 (Coremail) with SMTP id EcCowABnNtdJ9XVcr0WqHg--.29349S2;
 Wed, 27 Feb 2019 10:26:18 +0800 (CST)
From: WangBo <wdjjwb@163.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dmabounce: NULL check before some freeing functions is 
Date: Wed, 27 Feb 2019 10:26:15 +0800
Message-Id: <1551234375-6223-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowABnNtdJ9XVcr0WqHg--.29349S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur15GF1fCryUCr1rCw4DJwb_yoWfAFg_Ar
 yxt3ykur95ZF4kWF4ayr1rur1fA3yrXFWFvF18Jrs7GanYqr9xArnrZ3yfK3W2gayjvr9x
 XrWUZryjyr12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnjsjUUUUUU==
X-Originating-IP: [182.151.187.141]
X-CM-SenderInfo: xzgmy4re6rljoofrz/xtbBEApoGVUMK+Nl1wAAsI
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_182640_690919_6244B6FF 
X-CRM114-Status: UNSURE (   8.82  )
X-CRM114-Notice: Please train this message.
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
Cc: rmk+kernel@armlinux.org.uk, wang.bo116@zte.com.cn,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The function dma_pool_destroy(NULL) is safe, so removes NULL check before 
freeing the mem. This patch also fix the ifnullfree.cocci warnings.

Signed-off-by: WangBo <wang.bo116@zte.com.cn>
---
 arch/arm/common/dmabounce.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 5ba4622..dd520a3 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -563,10 +563,8 @@ void dmabounce_unregister_dev(struct device *dev)
 		BUG();
 	}
 
-	if (device_info->small.pool)
-		dma_pool_destroy(device_info->small.pool);
-	if (device_info->large.pool)
-		dma_pool_destroy(device_info->large.pool);
+	dma_pool_destroy(device_info->small.pool);
+	dma_pool_destroy(device_info->large.pool);
 
 #ifdef STATS
 	if (device_info->attr_res == 0)
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
