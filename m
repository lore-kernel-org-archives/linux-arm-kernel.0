Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB11C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59EAE213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B52QhC9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EAE213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kjTTfVUdDd48gT6RHB7JrHvzfiHOuDfNZWjqqxtn16M=; b=B52QhC9K0lpbHg
	J5J/s2TiHVZVOgQYlPJUvQ3ZeVGfB/6RCvxBoyQw54Xh8GpX+nlD5ZdV6GL40I8ZRHo/Afu3pD8nU
	niP4/LloxBOqQ+PLNnKrtOVwz9drn5RrGLQpeu1J58cZuanbqd9UjOkNy3XNR4m0KIskqCDHmfR37
	53PwuFUU3KF3IRjzGJiVNEHcd2L6OdskMgF3aNe9kP46pNA3sZVD0VAjzP+APyf4DIWePgvlrVtgZ
	wjTWw+8weI4Y1DW5goChCQdwbKMMkUGOimByKDk9EnjmvShkEH65MKMm8to9+JTzE61mzgCdiZuYC
	X1fCE3Cc+to1HtPPrA/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0I1-0008Uw-Ti; Wed, 27 Feb 2019 14:34:29 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0Hh-00087y-6D; Wed, 27 Feb 2019 14:34:13 +0000
X-UUID: 1456cfdddb034b519e92eb9dee2f20cb-20190227
X-UUID: 1456cfdddb034b519e92eb9dee2f20cb-20190227
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 466098291; Wed, 27 Feb 2019 06:33:24 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 06:33:22 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 27 Feb 2019 22:33:20 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 22:33:20 +0800
Message-ID: <1551278000.17917.50.camel@mhfsdcap03>
Subject: Re: [PATCH 02/13] driver core: Remove the link if there is no
 driver with AUTO flag
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Wed, 27 Feb 2019 22:33:20 +0800
In-Reply-To: <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-3-git-send-email-yong.wu@mediatek.com>
 <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_063409_551402_89941FC3 
X-CRM114-Status: GOOD (  24.24  )
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

On Mon, 2019-02-25 at 15:53 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > DL_FLAG_AUTOREMOVE_CONSUMER/SUPPLIER means "Remove the link
> > automatically on consumer/supplier driver unbind", that means we should
> > remove whole the device_link when there is no this driver no matter what
> > the ref_count of the link is.
> >
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > The ref_count of our device_link normally is over 1. When the consumer
> > device driver is removed, whole the device_link should be removed.
> > Thus, I add this patch.
> > ---
> 
> I will admit to reading about device links for the first time while
> reviewing this patch, but I don't really get this. Why use a kref at
> all if we're just going to ignore its value? For instance, I see that
> if you call device_link_add() with the same supplier and consumer, it
> uses the kref to return the same link. That machinery is broken with
> your change. Although I don't see any uses of it, you might also
> expect a supplier or consumer could do a kref_get() on the link it got
> back from device_link_add(), and have a reasonable expectation that
> the link wouldn't be freed out from under it. This would also be
> broken.
> 
> Can you explain why your device_links normally have a reference count
> >1, 

I use device link between the smi-larb device and the iommu-consumer
device. Take a example, smi-larb1 have 4 VDEC ports. From 4/13 in this
patchset, we use device_link to link the VDEC device and the smi-larb1
device in the function(mtk_iommu_config). since there are 4 ports, it
will call device_link_add 4 times.

>
> and why those additional references can't be cleaned up in an
> orderly fashion?

If the iommu-consume device(like VDEC above) is removed, It should enter
device_links_driver_cleanup which only ref_put one time. I guess whole
the link should be removed at that time.

> 
> (To be honest, I don't really understand the case for the AUTOREMOVE
> flags at all. Is there some case where the party that set up the link
> can't tear it down? Or is this a way to devm_ify the link, where devm
> itself doesn't work because the links themselves stall out that
> mechanism?)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
