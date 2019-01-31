Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E08CC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:20:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F208120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S68vzpgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F208120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uK+v72vb6la4T6MaXcLvyDA65MRe4BR8KDtKk/fRPhg=; b=S68vzpgDhLB9td
	xLcxsFR7PJMqQtOh+H9wB4DZ7tfzCYtHS2VTSHIdBKWVF+ITnPnr2+pT/+tH0QCEKjitrXBOZ3kq/
	cQLwC6Z+DUmCqkedgQ/2FV/sRzE7F2s+0CQCCubLucLfJT64h66zrobO7eXT7dgJP0xUnnlaJJoZG
	HYgY+ZWSnrtPCEU1+h2BGRy1oSlxW7rL8m2RCpjQ4wY01+kpLE1VI6eBjQRia0+ZTctdQNdf6NoJs
	xN1uLu6oGSJPUg46zX9sxtcIlf6v1X4LcCxDpjyiTWGp1BWL8bUPkK30885uO6QyRN1VUU8BS7ueq
	Dvzlm34ZJbVdv6AzJcnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2tY-0001PO-4k; Thu, 31 Jan 2019 03:20:04 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2tS-0001O9-Qk; Thu, 31 Jan 2019 03:20:00 +0000
X-UUID: 56b83d677e444b26bec10ed706b94213-20190130
X-UUID: 56b83d677e444b26bec10ed706b94213-20190130
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1633757321; Wed, 30 Jan 2019 19:19:56 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 19:19:54 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 11:19:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:19:51 +0800
Message-ID: <1548904791.19710.34.camel@mhfsdcap03>
Subject: Re: [PATCH v5 13/20] iommu/mediatek: Add mt8183 IOMMU support
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Thu, 31 Jan 2019 11:19:51 +0800
In-Reply-To: <CAE=gft6nQ4uv5kqYO876sQaKo71F0RkMj4d-dKDvxi8pEy-WgQ@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-14-git-send-email-yong.wu@mediatek.com>
 <CAE=gft6nQ4uv5kqYO876sQaKo71F0RkMj4d-dKDvxi8pEy-WgQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_191959_097403_77CBED3F 
X-CRM114-Status: GOOD (  22.56  )
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
Cc: youlin.pei@mediatek.com, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-30 at 10:31 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> > the ARM Short-descriptor like mt8173, and most of the HW registers
> > are the same.
> >
> > Here list main differences between mt8183 and mt8173/mt2712:
> > 1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
> > 2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
> > 3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
> > mode".
> > 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> > the bit[33:32] in the physical address of the pgtable base, But the
> > standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> > we add a mask.
> > 5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
> > 6) mt8183 need reset_axi like mt8173.
> > 7) the larb-id in smi-common is remapped. M4U should add its larbid_remap.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 15 ++++++++++++---
> >  drivers/iommu/mtk_iommu.h |  1 +
> >  drivers/memory/mtk-smi.c  | 20 ++++++++++++++++++++
> >  3 files changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 2913ddb..66e3615 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -36,6 +36,7 @@
> >  #include "mtk_iommu.h"
> >
> >  #define REG_MMU_PT_BASE_ADDR                   0x000
> > +#define MMU_PT_ADDR_MASK                       GENMASK(31, 7)
> >
> >  #define REG_MMU_INVALIDATE                     0x020
> >  #define F_ALL_INVLD                            0x2
> > @@ -342,7 +343,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
> >         /* Update the pgtable base address register of the M4U HW */
> >         if (!data->m4u_dom) {
> >                 data->m4u_dom = dom;
> > -               writel(dom->cfg.arm_v7s_cfg.ttbr[0],
> > +               writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
> 
> So there aren't any other bits down below 7 that you need, like the
> shareable bits?

Yes. We don't need all the bits down below 7. As the comment 4) above,
we mask it just because the S bit.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
