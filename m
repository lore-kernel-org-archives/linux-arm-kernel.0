Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5C9C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB066218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PZ8rv6uN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB066218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2u6k0bWJtX9xLPK6ucTolorqinUVNKAiTkPjzihPJpo=; b=PZ8rv6uNpIj5EjJ0f/Sl56vN9L
	5/K7pSYgISq7HC4TsS7K4Epn4NHdmZBMwDY8nnEEjHUmyaIOjnaqitfyQ3nvlgud6JMkJmCyjWtpa
	hTrw+teMV3drSP5yqx6H0gdBDbj3REGIFAdiRY4crMZ2URKtDlmZerUBl54AMUUoXCfYwz/h6da41
	vQS55vKdQFgmp+UHSMOH+xiq2LH3X4jHMC9/myHtC/A4eyHYOMd07gQkdYZrV+rgxMYmM3VDAQP5U
	eM/sp1DTNUzmzFL29Zv8W7aeSLc0e3Rz8G6YjGFit+YX3UQB+2Mxm4zFCaulqR6he0wRhWCErUEzn
	4yG9v84Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb09q-0004K0-0a; Sun, 23 Dec 2018 09:34:50 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb09H-0003FE-EL
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 09:34:17 +0000
X-IronPort-AV: E=Sophos;i="5.56,386,1539640800"; d="scan'208";a="289991779"
Received: from palace.lip6.fr ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 23 Dec 2018 10:33:54 +0100
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH 14/20] dmaengine: st_fdma: drop useless LIST_HEAD
Date: Sun, 23 Dec 2018 09:57:09 +0100
Message-Id: <1545555435-24576-15-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_013415_775090_1893AA95 
X-CRM114-Status: UNSURE (   9.11  )
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

The declarations were introduced with the file, but the declared
variables were not used.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
@@
- LIST_HEAD(x);
  ... when != x
// </smpl>

Fixes: 6b4cd727eaf1 ("dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Successfully 0-day tested on 151 configurations.

 drivers/dma/st_fdma.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 07c20aa2e955..954f7cf62bb1 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -294,8 +294,6 @@ static void st_fdma_free_chan_res(struct dma_chan *chan)
 	struct rproc *rproc = fchan->fdev->slim_rproc->rproc;
 	unsigned long flags;
 
-	LIST_HEAD(head);
-
 	dev_dbg(fchan->fdev->dev, "%s: freeing chan:%d\n",
 		__func__, fchan->vchan.chan.chan_id);
 
@@ -626,7 +624,6 @@ static void st_fdma_issue_pending(struct dma_chan *chan)
 static int st_fdma_pause(struct dma_chan *chan)
 {
 	unsigned long flags;
-	LIST_HEAD(head);
 	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
 	int ch_id = fchan->vchan.chan.chan_id;
 	unsigned long cmd = FDMA_CMD_PAUSE(ch_id);


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
