Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BE2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:43:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CC020659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RCv77GiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CC020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D/anJ3zjuhxumIzdL/pud3mCmJQn/lrCtkML8OR6s80=; b=RCv77GiWr40dyX
	xlvhGDOuuidJlJlV1B2gP7/T8PKo0y1hfRCRgjpNXAWXAvyWNxmYoDxkS+1KZPeu8MF2zLLCSAH4H
	Y8kfdu6Y4x0fHAmHVwX5CoatvTPkMnWmCd4DUWbq1/cNBtwy2Udr0cie6kO8lJ0NdV0FoErmko9o/
	GtbL3Fh9Z6Bup0UpHoqNJfcJpKJ68y365SpnwgvG7sgPjGRq4/GJkR4Eg4IgIFNitG3hIbbVtQzMV
	mKX5GHFjL7UkKRMS2DZuO03S1BG5vtu+j0IryuvtfiwKcC0y//4/Uc/1Gfg9D0Z3ajg34VR0H6xRf
	ZrcG4AP/hKObz+4BM2eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjpH-0001d6-UY; Mon, 03 Dec 2018 08:43:35 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjn6-0007J6-Vb; Mon, 03 Dec 2018 08:41:49 +0000
X-UUID: da55362b01fa484f8601ad5104561662-20181203
X-UUID: da55362b01fa484f8601ad5104561662-20181203
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1700383168; Mon, 03 Dec 2018 16:40:53 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 3 Dec 2018 16:40:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 16:40:51 +0800
Message-ID: <1543826451.23023.35.camel@mhfsdcap03>
Subject: Re: [PATCH v3 13/15] memory: mtk-smi: Get rid of need_larbid
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Mon, 3 Dec 2018 16:40:51 +0800
In-Reply-To: <21767ceb-1db5-045f-06ac-29c57f1a74a5@gmail.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
 <1542422142-30688-14-git-send-email-yong.wu@mediatek.com>
 <21767ceb-1db5-045f-06ac-29c57f1a74a5@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_004121_998689_BB910B06 
X-CRM114-Status: GOOD (  15.12  )
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
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 arnd@arndb.de, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 yingjoe.chen@mediatek.com, YT.shen@mediatek.com,
 Arvind Yadav <arvind.yadav.cs@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2018-12-03 at 00:04 +0100, Matthias Brugger wrote:
> 
> On 17/11/2018 03:35, Yong Wu wrote:
> > The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> > It's no need to parse it again in SMI driver. Only clean some codes.
> > This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> > and mt8183.
> 
> I'm trying to understand why we need the mediatek,larb-id at all. From what I
> understand as long as the mediatek larbs described in the iommu are ordered
> (larb0, larb1, larb2, etc) we actually get the same value as defined by
> mediatek,larb-id. At least this holds for all present implementations.
> 
> On the other hand I don't see where the mtk_iommu_v1 driver actually parses the
> larb-id, can you please help to understand:
> 
> 1) why we need the larb-id at all

Actually only mt2712 which have 2 M4U HW need "mediatek,larb-id".

This is larbs in the m4u0/1 dtsi node of mt2712:
m4u0 { mediatek,larbs = <&larb0 &larb1 &larb2 &larb3 &larb6>;}
m4u1 { mediatek,larbs = <&larb4 &larb5 &larb7>;}

the id don't increase one by one, M4U have to get the larbid with the
help of "mediatek,larb-id".

(The m4u/smi dtsi patch of mt2712 will be send with some other modules,
maybe in this week.)


> 2) how this will work if we do not parse the larb-id for v1 iommu at all

As you said above and I also have wrote that the larbid "must sort
according to the local arbiter index" in the "mediatek,larbs"
description of dt-binding. All the M4U except mt2712 could ignore
"mediatek,larb-id". the v1 iommu also should be ok.

I'm not sure whether we should change [1], if only reserving mt2712
there, we also should change the dtsi file of mt2701 and mt7623.or keep
it as is.

[1]
https://elixir.bootlin.com/linux/v4.20-rc1/source/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt#L20

> 
> Thanks a lot,
> Matthias
> 
> > 

[snip]



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
