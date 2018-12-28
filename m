Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAF2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:39:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0A9208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="haaAXlOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0A9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=k+4TIRb2xc98TvD+fQdEimZmTAYJDcGsLuNaFcWycQ0=; b=haaAXlOsAjtFYV
	zmuQ22QaJAZzW/lZgT7E5BtJrCDmja0brBHLP1OYVoG3wXQQgmhnGsxOOW5FQVdo9Gv67yVkfghi7
	vqAYRkK5Zh4/AdUoTqZtwA10/RoyriPpy00efyvbF4DWWLyul/lplc1NBP+KX2QBCdbrbd6lz/bPT
	CZT4eTbDkgw5J4STyKRYgx1u0wkpy6HLm5jtToV1SJDjmBknTvbGcDgLC+aKVsR7Cxsc+D47XtZzU
	/pCDOFHV98maFmcG8JhrAmMPVaiLxTJFIUrh4MVLDUzPKMFHhb2F/kOcRwUlI97Q6xuGDA+BAPcCJ
	5ZOkk/o/9JNxuxmFDt2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gclnT-0003tu-Qf; Fri, 28 Dec 2018 06:39:03 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gclnP-0003rx-Rb
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 06:39:01 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B7D91D5F454AC;
 Fri, 28 Dec 2018 14:38:46 +0800 (CST)
Received: from SIA1000080854.huawei.com (10.180.101.187) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Fri, 28 Dec 2018 14:38:40 +0800
From: h00249924 <hutenghui@huawei.com>
To: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] k3dma: Upgrade k3dma drever to support hisi_asp_dma
 hardware
Date: Fri, 28 Dec 2018 14:36:21 +0800
Message-ID: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.180.101.187]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_223900_060014_4F5C6E19 
X-CRM114-Status: GOOD (  11.18  )
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
Cc: Youlin Wang <wwx575822@notesmail.huawei.com>, hanxiaolong3@hisilicon.com,
 suzhuangluan@hisilicon.com, hantanglei@huawei.com, kongfei@hisilicon.com,
 ninggaoyu@hisilicon.com, Vinod Koul <vkoul@kernel.org>,
 liyuequan@hisilicon.com, Dan Williams <dan.j.williams@intel.com>,
 huangli295@hisilicon.com, wangyoulin1@hisilicon.com, cash.qianli@hisilicon.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

There is an new "hisi-pcm-asp-dma-1.0" device added in
"arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
So we have to add a matching id in the driver file:
"{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", }"

And also hisi-pcm-asp dma device needs no setting to the clock.
So we skip this by "if" sentence on id string matching:
"if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0)"

After above this driver will support both k3 and hisi_asp dma hardware.

Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/k3dma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index fdec2b6..10eecc2 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -792,6 +792,7 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
 
 static const struct of_device_id k3_pdma_dt_ids[] = {
 	{ .compatible = "hisilicon,k3-dma-1.0", },
+	{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
@@ -835,10 +836,12 @@ static int k3_dma_probe(struct platform_device *op)
 				"dma-requests", &d->dma_requests);
 	}
 
-	d->clk = devm_clk_get(&op->dev, NULL);
-	if (IS_ERR(d->clk)) {
-		dev_err(&op->dev, "no dma clk\n");
-		return PTR_ERR(d->clk);
+	if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0) {
+		d->clk = devm_clk_get(&op->dev, NULL);
+		if (IS_ERR(d->clk)) {
+			dev_err(&op->dev, "no dma clk\n");
+			return PTR_ERR(d->clk);
+		}
 	}
 
 	irq = platform_get_irq(op, 0);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
