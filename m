Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3D2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:22:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2ED2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rMUnCdam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2ED2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JQk7fWIrRWh6TA4juLI3NzHfEPYx/CJr1aCeCsU6/es=; b=rMUnCdam5VM9sJ
	U6cuapQtLCKbHp1WJa9T5CoNXzg7QLxY7QkmGo0lLz5fsYo0LjKWGr665HnzD8JJu0ETDNVY9t2EW
	EZOWiPun+6yxPcDoXrSDRTKZZZ2Ja1sz6i0gX5XQENGgFOGjvhz+VEnBD8XwcUs1lOIzJK2YQe58q
	XpoEL4fQpwAj2AGo+EIlA62fRpwGiCyd6q1ESHoI+KKNqpw9RFsNo34xB5j+HzI7czCeTu1Wd/E2P
	xFg+UkwCwB3JJMt1Gi0bhT2TUBv6uiYRyrA0d1iCDL+n6eSsR6flcGtjsJsObLFL7GrSw6+5c0tvY
	+k7UIBovokKP6Hi5rZIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfIs3-0004Zq-SY; Fri, 04 Jan 2019 06:22:15 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfIs0-0004Z3-LF
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 06:22:14 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 78026E015EA9D;
 Fri,  4 Jan 2019 14:22:00 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Fri, 4 Jan 2019 14:21:55 +0800
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
To: <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] drivers/perf: hisi: Fixup one DDRC PMU register offset
Date: Fri, 4 Jan 2019 14:21:34 +0800
Message-ID: <1546582894-41617-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_222212_861365_E6F74248 
X-CRM114-Status: GOOD (  10.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, John Garry <john.garry@huawei.com>,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
 Shaokun Zhang <zhangshaokun@hisilicon.com>, huangweijian4@hisilicon.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For DDRC PMU, each PMU counter is fixed-purpose. There is a mismatch
between perf list and driver definition on rw_chg event.
# perf list | grep chg
  hisi_sccl1_ddrc0/rnk_chg/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/rw_chg/                           [Kernel PMU event]
But the register offset of rw_chg event is not defined in the driver,
meanwhile bnk_chg register offset is mis-defined, let's fixup it.

Fixes: 904dcf03f086 ("perf: hisi: Add support for HiSilicon SoC DDRC PMU driver")
Cc: stable@vger.kernel.org 
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reported-by: Weijian Huang <huangweijian4@hisilicon.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 1b10ea05a914..69372e2bc93c 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -30,8 +30,8 @@
 #define DDRC_FLUX_RCMD          0x38c
 #define DDRC_PRE_CMD            0x3c0
 #define DDRC_ACT_CMD            0x3c4
-#define DDRC_BNK_CHG            0x3c8
 #define DDRC_RNK_CHG            0x3cc
+#define DDRC_RW_CHG             0x3d0
 #define DDRC_EVENT_CTRL         0x6C0
 #define DDRC_INT_MASK		0x6c8
 #define DDRC_INT_STATUS		0x6cc
@@ -51,7 +51,7 @@
 
 static const u32 ddrc_reg_off[] = {
 	DDRC_FLUX_WR, DDRC_FLUX_RD, DDRC_FLUX_WCMD, DDRC_FLUX_RCMD,
-	DDRC_PRE_CMD, DDRC_ACT_CMD, DDRC_BNK_CHG, DDRC_RNK_CHG
+	DDRC_PRE_CMD, DDRC_ACT_CMD, DDRC_RNK_CHG, DDRC_RW_CHG
 };
 
 /*
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
