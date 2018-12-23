Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28131C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:06:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98F9217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TPWvB502"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98F9217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yLWj2muR61IbM+Nw+OpA41HYIrFdUkx0NTdSaK+5WCc=; b=TPWvB502suQnzr
	mwHwOlMDEbWGX0chHOQx9EUCIZ5OC9DviyKnzWXpIJjEL1vemeuxYnay78GS6/W/IIxAQsSv/GWTh
	GmaS1CEzTWqw0tCsESgyw/pFYlTh6vDuDNApAd3KWpVOt/nJ6hMJFpfCBZKpR2m4kAVbiWVixcW63
	1396kqUckGj8zjwWaquNkFDd5z9zEk0xTjnpr5Y1NRp3QW/SEs2qNidp0Ygd64MefxEkiF26Jjl2C
	+As2n8kyQIZ0Z91lBF8P2kO8wbBHQPzwNpESmpGEoRMlYxoqlvd7k2tLOWq+Q+V8fhrLgfilxIBu/
	lWKyx6GRYSGe5vGzesgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbBtL-0001U2-TR; Sun, 23 Dec 2018 22:06:35 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbBtF-0001RY-Pf
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 22:06:32 +0000
X-IronPort-AV: E=Sophos;i="5.56,389,1539640800"; d="scan'208";a="290014683"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2018 23:06:08 +0100
Date: Sun, 23 Dec 2018 23:06:07 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Tom Psyborg <pozega.tomislav@gmail.com>
Subject: Re: [PATCH 00/20] drop useless LIST_HEAD
In-Reply-To: <CAKR_QVJefW1vxYb7-qiU8=0YdbFghYo15SK2eGjOC-dntRfyYA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812232304130.2940@hadrien>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAKR_QVJefW1vxYb7-qiU8=0YdbFghYo15SK2eGjOC-dntRfyYA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_140630_137653_82C0CDB8 
X-CRM114-Status: GOOD (  10.59  )
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
 linux-xfs@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
 linux-btrfs@vger.kernel.org, dmaengine@vger.kernel.org,
 xen-devel@lists.xenproject.org, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On Sun, 23 Dec 2018, Tom Psyborg wrote:

> Why do you CC this to so many lists?

Because the different files are in different subsystems.  The cover letter
goes to a list for each file, or to a person if there is no list.  The
patches go to the people and lists associated with the affected files.

julia

>
> On 23/12/2018, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> > Drop LIST_HEAD where the variable it declares is never used.
> >
> > ---
> >
> >  drivers/dma/at_hdmac.c                                |    5 -----
> >  drivers/dma/dw/core.c                                 |    1 -
> >  drivers/dma/pl330.c                                   |    1 -
> >  drivers/dma/sa11x0-dma.c                              |    2 --
> >  drivers/dma/st_fdma.c                                 |    3 ---
> >  drivers/infiniband/ulp/ipoib/ipoib_ib.c               |    1 -
> >  drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    5 -----
> >  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c       |    3 ---
> >  drivers/net/ethernet/mellanox/mlxsw/spectrum.c        |    1 -
> >  drivers/net/wireless/st/cw1200/queue.c                |    1 -
> >  drivers/scsi/lpfc/lpfc_nvme.c                         |    2 --
> >  drivers/scsi/lpfc/lpfc_scsi.c                         |    2 --
> >  drivers/scsi/lpfc/lpfc_sli.c                          |    1 -
> >  drivers/scsi/qla2xxx/qla_init.c                       |    1 -
> >  drivers/xen/xenbus/xenbus_dev_frontend.c              |    2 --
> >  fs/btrfs/relocation.c                                 |    1 -
> >  fs/nfs/nfs4client.c                                   |    1 -
> >  fs/nfsd/nfs4layouts.c                                 |    1 -
> >  fs/xfs/xfs_buf.c                                      |    1 -
> >  fs/xfs/xfs_fsops.c                                    |    1 -
> >  20 files changed, 36 deletions(-)
> >
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
