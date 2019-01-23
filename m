Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E37C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3272B21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DjnIASqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3272B21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xDO9b8EhxLztZdk9oQ13LG5VYRvnyk54P3iFrvFWlDw=; b=DjnIASqYV67fiz
	stflLXYnht+g8MgpEc4R3O3KK8oxCZ8OIuPdbedjmmvciilVUVF8sKkjAfF2CKz/0FXGb3+aLLLOA
	dxBmLIQSgXhu8Dbd5yCO2KFVRSnsyNrXNV99rwXTyXzIQeYbUwJWzGIVSsFETDRBm6X66tfBZE3Po
	ZgT2mHbKyJytSNLjk5nOpYvngQaN9IG/DvByMa4mel4rxibErekb+jxdk34jiK1XT3aFqM/NZ8dOn
	xSY/tXlTFy2RK8F6RmE5RzzLgut80u50XnwiSU9FsIjUpiRX1xXduoD9sqxUz80ycxi0VqayWeERZ
	BYEhFsgRW4FOl7ONu1GA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm7hE-0008DM-4s; Wed, 23 Jan 2019 01:51:16 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm7hA-0008CS-5K
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 01:51:14 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 71B579018AEC3AB4B036;
 Wed, 23 Jan 2019 09:50:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 09:50:46 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Tai Nguyen <ttnguyen@apm.com>
Subject: [PATCH -next] perf: xgene: Remove set but not used variable 'config'
Date: Wed, 23 Jan 2019 01:56:31 +0000
Message-ID: <1548208591-46158-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_175112_371690_B4CAA0F5 
X-CRM114-Status: UNSURE (   7.53  )
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
Cc: kernel-janitors@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/perf/xgene_pmu.c: In function 'xgene_perf_stop':
drivers/perf/xgene_pmu.c:1055:6: warning:
 variable 'config' set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/perf/xgene_pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index d4ec048..27574e8 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1052,7 +1052,6 @@ static void xgene_perf_start(struct perf_event *event, int flags)
 static void xgene_perf_stop(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hw = &event->hw;
-	u64 config;
 
 	if (hw->state & PERF_HES_UPTODATE)
 		return;
@@ -1064,7 +1063,6 @@ static void xgene_perf_stop(struct perf_event *event, int flags)
 	if (hw->state & PERF_HES_UPTODATE)
 		return;
 
-	config = hw->config;
 	xgene_perf_read(event);
 	hw->state |= PERF_HES_UPTODATE;
 }




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
