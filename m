Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427D1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:04:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5CF206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RuBZMn2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5CF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=R6UCAP6FqkTMCdgpIFX3BPxCe5b4gIgE1ABRExcZ44o=; b=RuBZMn2y9w8Fpi
	CzAXHXTuCLovEsw2UIGiHUWFsIGW6cE2RBKapP0z+CBxPqIdG23Pm4etiYLcuqWoZeFtV6CrXU9dp
	Xc4luYz1f+qoDfZztYnf7AS8dsDLLz1RHqbZWrf3oroZAuhv8vzpBFn3+sAsoXgJiK0BJldHd8T5A
	FrPjAqeJgTefnwRCNxxiL2Um9/JP6J+U/q+uE59e0ZyQwzL1eyYwjuDthGNtFaenVQ4g7eXtRIUkP
	gOGH8X/y5pWQisqJW6pj+NTs/QUO9suMfBXIWKX57jK8VBB9h/G0wPmEFIYpMlchfShyvB4HDlOuZ
	VYh+KE8aGSr5PW1ck50g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghCb2-0002qq-UW; Wed, 09 Jan 2019 12:04:32 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghCaz-0002qD-EU
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 12:04:31 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B08E61139E9783A5338C;
 Wed,  9 Jan 2019 20:04:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 9 Jan 2019 20:04:09 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Michal Simek <michal.simek@xilinx.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@xilinx.com>, Andrea Merello <andrea.merello@gmail.com>,
 Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
Subject: [PATCH -next] dmaengine: xilinx_dma: remove set but not used variable
 'tail_segment'
Date: Wed, 9 Jan 2019 12:10:37 +0000
Message-ID: <1547035837-87800-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_040429_652746_619F7F22 
X-CRM114-Status: UNSURE (   7.33  )
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
Cc: dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
 YueHaibing <yuehaibing@huawei.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/dma/xilinx/xilinx_dma.c: In function 'xilinx_vdma_start_transfer':
drivers/dma/xilinx/xilinx_dma.c:1104:33: warning:
 variable 'tail_segment' set but not used [-Wunused-but-set-variable]

It not used since commit b8349172b400 ("dmaengine: xilinx_dma: Drop SG support
for VDMA IP")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index d9431af..c8acd34 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1101,7 +1101,6 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	struct xilinx_vdma_config *config = &chan->config;
 	struct xilinx_dma_tx_descriptor *desc, *tail_desc;
 	u32 reg, j;
-	struct xilinx_vdma_tx_segment *tail_segment;
 	struct xilinx_vdma_tx_segment *segment, *last = NULL;
 	int i = 0;
 
@@ -1120,9 +1119,6 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	tail_desc = list_last_entry(&chan->pending_list,
 				    struct xilinx_dma_tx_descriptor, node);
 
-	tail_segment = list_last_entry(&tail_desc->segments,
-				       struct xilinx_vdma_tx_segment, node);
-
 	/* Configure the hardware using info in the config structure */
 	if (chan->has_vflip) {
 		reg = dma_read(chan, XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP);




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
