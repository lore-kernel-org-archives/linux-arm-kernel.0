Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26206C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:33:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0E62133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KT/4o/yV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0E62133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+g7gDtjsIaDOJ0H1+UfjicF+/Wd8Za0JAqHpkguMquU=; b=KT/4o/yVPjcJhF
	GZNBEsBot3qwGtGu3YhSVKXbQUMgEsnCNkJlq0+1P+Jr5Y+1Bw8JENOm9JCJxYPa1loz1j9u7Zzt7
	h634t+z/LcxMjOEIrga/PZD5FcPcmSkljUpgVUd/+HjYwVkEB3lRui70GT2Uweek9+Ic9/Xc16Fyd
	YvsnmBWROLJrNvhoxwlfqfds571oTMtkDutIipgaXTed0hDJ2aiFZ/MAze4P99tMzAVmMXGVlY+hs
	7qfc2g6S+0wbzmshJ6EnsWkqTAwuR7XfJXekTRW58ey6J4ArHl0LXVLK3/gNyamk5uD4p8g/AqTge
	X5vUphBxjKHL517GLxGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0Gx-0007dQ-B0; Wed, 27 Feb 2019 14:33:23 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0Gt-0007bx-9f; Wed, 27 Feb 2019 14:33:20 +0000
X-UUID: 2165785e0db44b97bfb74f7742769427-20190227
X-UUID: 2165785e0db44b97bfb74f7742769427-20190227
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2047001203; Wed, 27 Feb 2019 06:33:09 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 06:33:07 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 27 Feb 2019 22:33:05 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 22:33:05 +0800
Message-ID: <1551277985.17917.48.camel@mhfsdcap03>
Subject: Re: [PATCH 05/13] memory: mtk-smi: Add device-link between smi-larb
 and smi-common
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Wed, 27 Feb 2019 22:33:05 +0800
In-Reply-To: <CAE=gft71J+5ui_FFm4D+62uSy6KHYzT7wru_NNdPsvrCDV3ekw@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-6-git-send-email-yong.wu@mediatek.com>
 <CAE=gft71J+5ui_FFm4D+62uSy6KHYzT7wru_NNdPsvrCDV3ekw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_063319_342407_FE95C03A 
X-CRM114-Status: GOOD (  23.35  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz
 Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-02-25 at 15:54 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > Normally, If the smi-larb HW need work, we should enable the smi-common
> > HW power and clock firstly.
> > This patch adds device-link between the smi-larb dev and the smi-common
> > dev. then If pm_runtime_get_sync(smi-larb-dev), the pm_runtime_get_sync
> > (smi-common-dev) will be called automatically.
> >
> > Since smi is built-in driver like IOMMU and never unbound,
> > DL_FLAG_AUTOREMOVE_* is not needed.
> >
> > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 9688341..30930e4 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -271,6 +271,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct device_node *smi_node;
> >         struct platform_device *smi_pdev;
> > +       struct device_link *link;
> >
> >         larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
> >         if (!larb)
> > @@ -310,6 +311,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> >                 if (!platform_get_drvdata(smi_pdev))
> >                         return -EPROBE_DEFER;
> >                 larb->smi_common_dev = &smi_pdev->dev;
> > +               link = device_link_add(dev, larb->smi_common_dev,
> > +                                      DL_FLAG_PM_RUNTIME);
> 
> Doesn't this need to be torn down in remove()? You mention that it's
> built-in and never removed, but it does seem to have a remove()

The MTK IOMMU driver need depend on this SMI driver. the IOMMU is a
builtin driver, thus the SMI also should be a builtin driver.

Technically, If the driver is builtin, then the "remove" function can be
removed? If yes, I could use a new patch do it.

It looks the MACRO(builtin_platform_driver) only support one driver, but
we have two driver(smi-common and smi-larb) here.

> function that tears down everything else, so it seemed a shame to
> start leaking now. Maybe the AUTOREMOVE flag would do it.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
