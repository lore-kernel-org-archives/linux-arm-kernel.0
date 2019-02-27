Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C492BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B33213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kICW3Phn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B33213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LtsrdwvbkKYaW5IjND4L0on0RaFOGZvBQoIuQQfdC68=; b=kICW3PhnfCl2lc
	UhAhXlPjykHYYnY4CMnHDeRviSjzo8mklym4t7Eqea6ukQHSvh2tfYTzC1WvVtt0SFpkySpc6D4Je
	WRbwbYxq+XQr9CsVGAeMwJP8UGC8lOmX+Z9vGU3QfJc/jKc70n0oA+Od6DZBWN1kvqzfR27Uj0nMu
	zzaRSGYiAOCyFFqAyJHOhY0k6ueX5dVXRwCWc0obNU6jZdL/sjmEs5xcs+LZc5NTVdfFj4Os343i0
	wgw+in0cmTUgT1ECX2P18HOD91um4HdjgS9N6wnG/xDgIojoVJRB9+gU2V7rBoTpgBrBnigGJ7qlV
	6sxwdyJXBDqepUhG9k2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0Hp-0008Ez-82; Wed, 27 Feb 2019 14:34:17 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0Hh-00086a-6K; Wed, 27 Feb 2019 14:34:11 +0000
X-UUID: 855a46618f984e6dabc8a00fb40cf0bb-20190227
X-UUID: 855a46618f984e6dabc8a00fb40cf0bb-20190227
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1399887059; Wed, 27 Feb 2019 06:33:59 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 06:33:57 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 27 Feb 2019 22:33:55 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 22:33:54 +0800
Message-ID: <1551278034.17917.52.camel@mhfsdcap03>
Subject: Re: [PATCH 03/13] iommu/mediatek: Add probe_defer for smi-larb
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Wed, 27 Feb 2019 22:33:54 +0800
In-Reply-To: <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-4-git-send-email-yong.wu@mediatek.com>
 <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_063409_434447_2056AD9F 
X-CRM114-Status: GOOD (  18.83  )
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
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, 2019-02-25 at 15:54 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > The iommu consumer should use device_link to connect with the
> > smi-larb(supplier). then the smi-larb should run before the iommu
> > consumer. Here we delay the iommu driver until the smi driver is
> > ready, then all the iommu consumer always is after the smi driver.
> >
> > When there is no this patch, if some consumer drivers run before
> > smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> > device_link_add, then device_links_driver_bound will use WARN_ON
> > to complain that the link_status of supplier is not right.
> >
> 
> I don't quite have enough knowledge of device links to figure out if
> this is a) the right fix, b) a deficiency in the device_links code, or
> c) neither.

I can not say more about the device link, But from the MTK iommu point
of view, it looks a right fix. As the comment above, we should make sure
the probe sequence, SMI-larb should be before MTK IOMMU which need be
before iommu-consumer. this patch help SMI-larb always is before
MTK_IOMMU.

Then if there is no this patchset, what the MTK_IOMMU will happen?.

The MTK_IOMMU is subsys_initcall, all the consume only need after the
MTK_IOMMU and don't need wait for SMI-larb driver. If some consume run
before SMI-larb driver, It also is OK while it don't call
mtk_smi_larb_get in this probe.(Of course it will abort if it call this
while smi-driver don't probe at that time). the consumer and smi-larb
normally are module_init, we can not guarantee the the sequence. it is a
potential issue.

Some consume know it should wait for SMI-larb like [1], but It don't
work.

[1]
https://elixir.bootlin.com/linux/v5.0-rc1/source/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c#L145

> 
> Perhaps someone else could chime in on this one.
> -Evan
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
