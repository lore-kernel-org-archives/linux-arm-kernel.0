Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A849FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3D7218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rdKGri84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3D7218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MWP6B3/Q40tq3L4m57sRIM+nZxx0tz2l9RQcZHBVwDs=; b=rdKGri84w48s0m99Q2iDOdG3r0
	S0FCBhM/yePuG4Oo0BiKCBI8tUgh2EYCkDXi6Bnrr6OjD/qAiSxNnPKAJ0BMNT4Kog8V72ldJ83dA
	dRKkgBGsqamtc+OCbAC6/RQq0H/M8J09gzGMyE1pkPem7ymbhEdPukztpuU9oB2HCKXYCzz9OAgzs
	n72M+OvBZKjx32K8gowRkJR7oKE4+eqURRMMHoPvZpBiDWK+KWFyRifwIQasz1sgxU0lGRokBSDbG
	s4GPIL/iImiLlQ01K6Tr8F/i6yOvDYZe6/Cgz5e/a9ePs4vaWitMo2FpjD5LRHZ0kE4SJK4t8FUUr
	civ0O4AA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb09S-0003xa-P4; Sun, 23 Dec 2018 09:34:26 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb09E-0003FG-UB
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 09:34:15 +0000
X-IronPort-AV: E=Sophos;i="5.56,386,1539640800"; d="scan'208";a="289991771"
Received: from palace.lip6.fr ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 23 Dec 2018 10:33:53 +0100
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 07/20] dmaengine: at_hdmac: drop useless LIST_HEAD
Date: Sun, 23 Dec 2018 09:57:02 +0100
Message-Id: <1545555435-24576-8-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_013413_278816_793793EE 
X-CRM114-Status: UNSURE (   9.69  )
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Drop LIST_HEAD where the variable it declares is never used.

tmp_list has been declared since the introduction of the driver
and has never been used.  The two declarations of list were
introduced with the containing functions but were also not used.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
@@
- LIST_HEAD(x);
  ... when != x
// </smpl>

Fixes: dc78baa2b90b ("dmaengine: at_hdmac: new driver for the Atmel AHB DMA Controller")
Fixes: 4facfe7f09f2b ("dmaengine: hdmac: Split device_control")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Successfully 0-day tested on 151 configurations.

 drivers/dma/at_hdmac.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 01d936c9fe89..a0a9cd76c1d4 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -134,7 +134,6 @@ static struct at_desc *atc_desc_get(struct at_dma_chan *atchan)
 	struct at_desc *ret = NULL;
 	unsigned long flags;
 	unsigned int i = 0;
-	LIST_HEAD(tmp_list);
 
 	spin_lock_irqsave(&atchan->lock, flags);
 	list_for_each_entry_safe(desc, _desc, &atchan->free_list, desc_node) {
@@ -1387,8 +1386,6 @@ static int atc_pause(struct dma_chan *chan)
 	int			chan_id = atchan->chan_common.chan_id;
 	unsigned long		flags;
 
-	LIST_HEAD(list);
-
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
 
 	spin_lock_irqsave(&atchan->lock, flags);
@@ -1408,8 +1405,6 @@ static int atc_resume(struct dma_chan *chan)
 	int			chan_id = atchan->chan_common.chan_id;
 	unsigned long		flags;
 
-	LIST_HEAD(list);
-
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
 
 	if (!atc_chan_is_paused(atchan))


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
