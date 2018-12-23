Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231E6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4096218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cGaDL5Bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4096218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=97/nlcEkgAc+29Vl5KRiPn7/QqSwllm9ynFQhfSsI7s=; b=cGa
	DL5BwbOpywevrORh81F/qLlHv3BwXPEZ3/TBAdn1+iTqlW1LWnwvZ3A2e+UIS4ilJIGE/fz+d5Ohf
	8RtnhS1/jDIXk6XWElu81zMl1dDmyr6zJ6HFVbcHVCiRcDsJO8Cg05dAngl1r0L0Ow/ublofEv061
	SV3nLxNJ+lQLCIN2COG5Xf64z+AQ+NPo7VhdYLz0zcS3PPU1DrDADIk6d8sQiEnWCi1LzdRjNbQLS
	u3FZacdOWg8NTE8zawrS6uR9kCgN2yMM/35fB4I8J571BksKbfE18fNQ13dk02R4J340Ka3TShBXA
	9YFexJiz66DJ44QW9SsQAScG9ufOI/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb09I-0003oO-Gl; Sun, 23 Dec 2018 09:34:16 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb09E-0003FE-UA
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 09:34:14 +0000
X-IronPort-AV: E=Sophos;i="5.56,386,1539640800"; d="scan'208";a="289991762"
Received: from palace.lip6.fr ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 23 Dec 2018 10:33:52 +0100
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 00/20] drop useless LIST_HEAD
Date: Sun, 23 Dec 2018 09:56:55 +0100
Message-Id: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_013413_282703_3DA649F0 
X-CRM114-Status: UNSURE (   5.68  )
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
Cc: linux-wireless@vger.kernel.org, linux-nfs@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 dmaengine@vger.kernel.org, xen-devel@lists.xenproject.org,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Drop LIST_HEAD where the variable it declares is never used.

---

 drivers/dma/at_hdmac.c                                |    5 -----
 drivers/dma/dw/core.c                                 |    1 -
 drivers/dma/pl330.c                                   |    1 -
 drivers/dma/sa11x0-dma.c                              |    2 --
 drivers/dma/st_fdma.c                                 |    3 ---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c               |    1 -
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    5 -----
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c       |    3 ---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c        |    1 -
 drivers/net/wireless/st/cw1200/queue.c                |    1 -
 drivers/scsi/lpfc/lpfc_nvme.c                         |    2 --
 drivers/scsi/lpfc/lpfc_scsi.c                         |    2 --
 drivers/scsi/lpfc/lpfc_sli.c                          |    1 -
 drivers/scsi/qla2xxx/qla_init.c                       |    1 -
 drivers/xen/xenbus/xenbus_dev_frontend.c              |    2 --
 fs/btrfs/relocation.c                                 |    1 -
 fs/nfs/nfs4client.c                                   |    1 -
 fs/nfsd/nfs4layouts.c                                 |    1 -
 fs/xfs/xfs_buf.c                                      |    1 -
 fs/xfs/xfs_fsops.c                                    |    1 -
 20 files changed, 36 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
