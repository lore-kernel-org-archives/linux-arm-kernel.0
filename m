Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E5FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:31:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4356120879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m1/h9utf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4356120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VKXmMePc4zHeTO7+SIUoI/LXhmxQNU5mvrYgkZDhSPU=; b=m1/h9utf+9stTA
	muoiWZthSgY+WUf2VSIfoJ/19vIbsGOfqxkGBEO0y3fHYZgwRa+aVTrIQhjvtwEsvPusOl9jycZJ3
	KphcfyKRN107PCsUmhSWGbjLIreO0O0hfzRQ/jlIwcT2fmKrZUAoq0XULRqftXjL+nUoJ5Abn6MU5
	xqjUamRiQ5fGCEdjw+nEMfm7Ib4wi1UrdEkx+ek2zfT5IG6aUyY6Gp9YkkFzN85Y7RoBukPSjziZ0
	6qPiITNFQYhR9VMB7CGliZS2MZfLkzLrJeIBGbm5Q5AVwt1qgJhM9y0TJgII0Fzf7DC13ZA9jAHyx
	09JO9u6DBi436XzQex4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghlfm-0002ED-39; Fri, 11 Jan 2019 01:31:46 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghlfh-0002DC-2n; Fri, 11 Jan 2019 01:31:43 +0000
X-UUID: fa4ebcc489414ff0bd9e8c68925b343b-20190110
X-UUID: fa4ebcc489414ff0bd9e8c68925b343b-20190110
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 357980858; Thu, 10 Jan 2019 17:31:38 -0800
Received: from MTKMBS02N2.mediatek.inc (172.21.101.101) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 17:31:36 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 11 Jan 2019 09:31:28 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 11 Jan 2019 09:31:28 +0800
Message-ID: <1547170288.29836.2.camel@mtksdaap41>
Subject: Re: Aw: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
From: CK Hu <ck.hu@mediatek.com>
To: Frank Wunderlich <frank-w@public-files.de>
Date: Fri, 11 Jan 2019 09:31:28 +0800
In-Reply-To: <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
 <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0A9927583E6C4C5F7B56FD85D3FBAA413171D2A9E01E6C960CD787995FFDBB712000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_173141_128969_BC8E2148 
X-CRM114-Status: GOOD (  15.93  )
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>,
 Alexander Ryabchenko <d3adme4t@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Daniel Vetter <daniel@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Frank:

On Thu, 2019-01-10 at 20:01 +0100, Frank Wunderlich wrote:
> Hi Daniel,
> 
> > > Would be good to use the new generic fbdev emulation code here, for even
> > > less code. Or at least know why this isn't possible to use for mtk (and
> > > maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> > > needed anymore.
> > 
> > Back on the mailing list, no private replies please:
> 
> i don't wanted to spam all people with dumb questions ;)
> 
> > For examples please grep for drm_fbdev_generic_setup(). There's also a
> > still in-flight series from Gerd Hoffmann to convert over bochs. That,
> > plus all the kerneldoc linked from there should get you started.
> > -Daniel
> 
> this is one of google best founds if i search for drm_fbdev_generic_setup:
> 
> https://lkml.org/lkml/2018/12/19/305
> 
> not very helpful...
> 
> so i tried kernel-doc
> 
> https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup
> 
> which is nice function-reference but i've found no generic workflow
> 
> as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
> Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?

I could help on this but I'm a little busy now, so I'm not sure how long
this process takes.

Regards,
CK

> 
> i personally make my first steps as spare-time kernel-developer :)
> 
> regards Frank
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
