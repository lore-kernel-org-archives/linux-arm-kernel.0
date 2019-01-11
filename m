Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF16C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:20:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31B820685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IzWoIxZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31B820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tm40zYSIihZL+ECLnywZyZqwZlIY5xbWxavGhltSSzE=; b=IzWoIxZUAE38YV
	L+kKavzdHjHS1Gvg/z6xXEIQGDiHosUZrgpZjh6RbfiIcPAY6Z08QQ/UTzhw4MSULW3Y4beiw/CE0
	QMsBOOCoqwsMhNPJYQObZge5KW9/iyLS0l0hNtpXUaWPTfTDgi7kRDkwyxbcBc31GAwz0D95Iv5ff
	JLMJ6UHxyQBeMK2pBDoGaXnFswkf8nr8vn7K+g0Wy3X39MpVEsj51XZAY/T9+cPkPB5stVKNzaYqh
	R1LgfEjGqATb4b55o+Ty+gm4soN29OPMb4wKZNeOWMUcjDzWjSTaQK+VjimRB4hv1HHB9ee8bzDWJ
	qbt9rOWHq7VklLMInuQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghnMv-0006Np-DJ; Fri, 11 Jan 2019 03:20:25 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghnMr-0006Mt-Gr; Fri, 11 Jan 2019 03:20:23 +0000
X-UUID: 0be58f5f0148464eabf96f48f90804b1-20190110
X-UUID: 0be58f5f0148464eabf96f48f90804b1-20190110
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1854446384; Thu, 10 Jan 2019 19:20:12 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 19:20:11 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 11 Jan 2019 11:20:09 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 11 Jan 2019 11:20:09 +0800
Message-ID: <1547176809.12054.11.camel@mtksdaap41>
Subject: Re: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
From: CK Hu <ck.hu@mediatek.com>
To: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 11 Jan 2019 11:20:09 +0800
In-Reply-To: <20190110200225.GN21184@phenom.ffwll.local>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
 <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
 <20190110200225.GN21184@phenom.ffwll.local>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_192021_566484_3A3F9B41 
X-CRM114-Status: GOOD (  22.23  )
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
Cc: Frank Wunderlich <frank-w@public-files.de>, David Airlie <airlied@linux.ie>,
 Alexander Ryabchenko <d3adme4t@gmail.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Daniel:

On Thu, 2019-01-10 at 21:02 +0100, Daniel Vetter wrote:
> On Thu, Jan 10, 2019 at 08:01:37PM +0100, Frank Wunderlich wrote:
> > Hi Daniel,
> > 
> > > > Would be good to use the new generic fbdev emulation code here, for even
> > > > less code. Or at least know why this isn't possible to use for mtk (and
> > > > maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> > > > needed anymore.
> > > 
> > > Back on the mailing list, no private replies please:
> > 
> > i don't wanted to spam all people with dumb questions ;)
> 
> There's no dumb questions, only insufficient documentation :-)
> 
> > > For examples please grep for drm_fbdev_generic_setup(). There's also a
> > > still in-flight series from Gerd Hoffmann to convert over bochs. That,
> > > plus all the kerneldoc linked from there should get you started.
> > > -Daniel
> > 
> > this is one of google best founds if i search for drm_fbdev_generic_setup:
> > 
> > https://lkml.org/lkml/2018/12/19/305
> > 
> > not very helpful...
> > 
> > so i tried kernel-doc
> > 
> > https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup
> > 
> > which is nice function-reference but i've found no generic workflow
> > 
> > as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
> > Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?
> > 
> > i personally make my first steps as spare-time kernel-developer :)
> 
> There's a ton of in-kernel users of that function already, I meant you can
> use those to serve as examples ... If those + the kerneldoc aren't
> good enough, then we need to improve them.
> -Daniel

I've tried with drm_fbdev_generic_setup() and it works fine with simple
modification. The patch is

--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -16,6 +16,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
@@ -379,6 +380,7 @@ static void mtk_drm_kms_deinit(struct drm_device
*drm)
        .gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
        .gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
        .gem_prime_mmap = mtk_drm_gem_mmap_buf,
+       .gem_prime_vmap = mtk_drm_gem_prime_vmap,
        .ioctls = mtk_ioctls,
        .num_ioctls = ARRAY_SIZE(mtk_ioctls),
        .fops = &mtk_drm_fops,
@@ -416,6 +418,8 @@ static int mtk_drm_bind(struct device *dev)
        if (ret < 0)
                goto err_deinit;

+       drm_fbdev_generic_setup(drm, 32);
+
        return 0;


But I implement .gem_prime_vmap with a workaround,


--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -280,3 +280,8 @@ int mtk_gem_create_ioctl(struct drm_device *dev,
void *data,
        mtk_drm_gem_free_object(&mtk_gem->base);
        return ret;
 }
+
+void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
+{
+       return (void *)1;
+}

Current drm_fb_helper depends on drm_client to create fbdev. When
drm_client create drm_client_buffer, it need to vmap to get kernel
vaddr. But I think for fbdev, the vaddr is useless. Do you agree that I
temporarily implement .gem_prime_vmap in such way?

Regards,
CK



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
