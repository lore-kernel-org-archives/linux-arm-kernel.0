Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD70C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:58:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB32218E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nWEqX5UV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB32218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nm+i/gwDCNmolXQh3zrf8fb6OzbmNQd7zlysXkhbzTs=; b=nWEqX5UVVkpNiX
	EB2kES20Kfi2A4dfdGNiripJILO8Nu0BmszYzdwJyyQyeZL8UnZ+kwQHcmDzUqXxsqhUqGY10LK0Y
	9Q0PPoJZ9c2nGpj+6KTgikVk7d5OISnA/4JQgHgh+64VMx01YThgzRwIsjle8KOHIn/6xULRUKUWT
	NKsl6gX0GYJIzb9QAVDA7A+0QP/h+KWNiyz6eJ0qbg9o3VozKmbap3ImoY/KEE58iaTANrfB08Vw/
	YuskBwI597UwPdCnjPUHvzswqndUz54DhPhmPGS5cpt5AyNnX8kRB3runNb3na/vTGRMpVqy144sO
	Wyw7PlbNb5z+E6bEvsDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaYQj-0007wy-Gq; Sat, 22 Dec 2018 03:58:25 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaYQe-0007pT-P7; Sat, 22 Dec 2018 03:58:23 +0000
X-UUID: 759698c5dc7e4985bab8cdde5e727758-20181222
X-UUID: 759698c5dc7e4985bab8cdde5e727758-20181222
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 784888556; Sat, 22 Dec 2018 11:58:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Sat, 22 Dec 2018 11:58:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 22 Dec 2018 11:58:03 +0800
Message-ID: <1545451083.29587.91.camel@mhfsdcap03>
Subject: Re: [PATCH v4 10/18] iommu/mediatek: Add mt8183 IOMMU support
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Sat, 22 Dec 2018 11:58:03 +0800
In-Reply-To: <07f6276d-e7b5-ef82-9c38-1fa0af0cd9f3@gmail.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
 <1544258371-4600-11-git-send-email-yong.wu@mediatek.com>
 <07f6276d-e7b5-ef82-9c38-1fa0af0cd9f3@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_195821_062576_987B4B4C 
X-CRM114-Status: GOOD (  19.61  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Arvind Yadav <arvind.yadav.cs@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2018-12-21 at 19:31 +0100, Matthias Brugger wrote:
> 
> On 08/12/2018 09:39, Yong Wu wrote:
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
> > 6) the larb-id in smi-common is remapped. M4U should enable
> > larbid_remapped support.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
[...]
> > +static const struct mtk_iommu_plat_data mt8183_data = {
> > +	.m4u_plat            = M4U_MT8183,
> > +	.larbid_remap_enable = true,
> > +	.larbid_remapped     = {0, 4, 5, 6, 7, 2, 3, 1},
> 
> Aren't we reinventing the wheel here?
> Why can't we use larb-id to get the correct id insteaf of providing another data
> structure for the remapping?

Sorry, The remapping id is arbitrary, there is no rule to get it from
the larb-id.

From Nicolas's comment, I plan to delete "larbid_remap_enable" and only
use "larbid_remap". The other SoCs use the linear mapping here.

In addition, I have to apologize that here will may be improved for
mt2712. There are 2 smi-common(smi-common0 and smi-common1) in mt2712,
actually the remapping relationship for smi-common1 is also different.
If it is really needed, I plan to change it from "larbid_remap" to
"larbid_remap[2]" which 0 is for smi-common0 and 1 is for smi-common1.
Of course, it doesn't affect the iommu functions and only prints the
error log when IOMMU translation fault.

> 
> Regards,
> Matthias

[...]



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
