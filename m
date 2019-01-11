Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:25:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825D52063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z20UgqNk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SMQWWReP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825D52063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RNT/Umjfo7l30YUEtRfR+PfkXKTXze50r1WuOvaD00w=; b=Z20UgqNkpn0H+v
	TxEO2ByRpNYjIXSOaezM+46PxDS8n3q+qKZ10/WnHJv9vZ1Lzf/621IzwLTfH7YKNCk8chkuA0rDI
	oXs412h6WNwI/HUirXEMThFGt8TyRRD2w59EzDXGLWCmPU87ZKT9cVnm04v+87nbytkUJt6HVcpyy
	vVVWk54DZn9wzJYKjwCD79dC9rhrUo3h/xfRgJn0aJ+0vlepABaka5l83AxsW+NmkUqDX2+RN31Ne
	0kuI1a8TmUZR0rMgsthtIw1IHn1ksTq+o5rLbluii04CzxB+jUhl8OJO/cdgs4RyV+y8Kga9qAn6M
	TkbHsNiMcvJKiXe+jZ8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghu01-00079v-2Q; Fri, 11 Jan 2019 10:25:13 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtzx-0006lo-DG
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:25:11 +0000
Received: by mail-ed1-x544.google.com with SMTP id p6so12727419eds.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 02:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:mail-followup-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=UznZJ4nq2scyICjLjA+3i2m90tln4XAhhH78Sp44HWM=;
 b=SMQWWReP1XL5PbZ4HE0hPS//H2+j7MPOz9xlFcWKUgsDUxU3tfbdslRjySA/u4HNED
 6p0/4XVD7JleBlt0REl9eW4/fauZXslahrcQ21tEf0Wm7LT/GcPCVJdZWdSC+AgKY+Nx
 lb1WSS84X22cvnOtTXdu3mWrAolZYbRulIw8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=UznZJ4nq2scyICjLjA+3i2m90tln4XAhhH78Sp44HWM=;
 b=s35y8XuDm71whXP7j49PYU9GcFHKfXVoUDp4qxBOGEPPmcP3dInxSJrifIVUt9rz8s
 5ZGQq4m/TWHcogLeXJF5F1jDl35kos12JHSp8dmgv/IzLqgBObJNsVnacZcqZTU/cdwy
 qPTwgA4xC/3a4/4NNibxQ84BFJC00djXWf8IEWdFnAGFCI9t3eMhhixWABdo/odBUQDO
 ssQH+otX3g3EZakeUp6ekKXMOCLNDfJ/1lOJsH6B80w2tx0Elzwzp+wD/0nc3Jit2JAz
 CH+QaiNNuOeGUAo+HzXaE6iPsM9PKHfNVM/X3/2VV125HR8EF6M3cpVMxmxis5Ua0pjz
 PO7A==
X-Gm-Message-State: AJcUukdW1MyQm7SC7793Zutl2PsbD2khygJmVJLWel7vRIlflJUO35/P
 NB97t7eNk9mhwYA4OKCywWTa8w==
X-Google-Smtp-Source: ALg8bN7sFzq/ghTGglKLlsQmNHbWG+TXIph3SJHjp3nvSkX4BFe37kteXXsDEd4APUHP+w7DIvYXRQ==
X-Received: by 2002:a50:9315:: with SMTP id m21mr12456159eda.58.1547202306456; 
 Fri, 11 Jan 2019 02:25:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id q10-v6sm1826885eju.47.2019.01.11.02.25.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 02:25:05 -0800 (PST)
Date: Fri, 11 Jan 2019 11:25:03 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: CK Hu <ck.hu@mediatek.com>
Subject: Re: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
Message-ID: <20190111102503.GU21184@phenom.ffwll.local>
Mail-Followup-To: CK Hu <ck.hu@mediatek.com>,
 Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Airlie <airlied@linux.ie>,
 Alexander Ryabchenko <d3adme4t@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
 <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
 <20190110200225.GN21184@phenom.ffwll.local>
 <1547176809.12054.11.camel@mtksdaap41>
 <20190111092042.GP21184@phenom.ffwll.local>
 <1547200155.4209.4.camel@mtksdaap41>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547200155.4209.4.camel@mtksdaap41>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_022509_486144_DF28B4A2 
X-CRM114-Status: GOOD (  32.82  )
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Frank Wunderlich <frank-w@public-files.de>, David Airlie <airlied@linux.ie>,
 Alexander Ryabchenko <d3adme4t@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 05:49:15PM +0800, CK Hu wrote:
> Hi, Daniel:
> 
> On Fri, 2019-01-11 at 10:20 +0100, Daniel Vetter wrote:
> > On Fri, Jan 11, 2019 at 11:20:09AM +0800, CK Hu wrote:
> > > Hi, Daniel:
> > > 
> > > On Thu, 2019-01-10 at 21:02 +0100, Daniel Vetter wrote:
> > > > On Thu, Jan 10, 2019 at 08:01:37PM +0100, Frank Wunderlich wrote:
> > > > > Hi Daniel,
> > > > > 
> > > > > > > Would be good to use the new generic fbdev emulation code here, for even
> > > > > > > less code. Or at least know why this isn't possible to use for mtk (and
> > > > > > > maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> > > > > > > needed anymore.
> > > > > > 
> > > > > > Back on the mailing list, no private replies please:
> > > > > 
> > > > > i don't wanted to spam all people with dumb questions ;)
> > > > 
> > > > There's no dumb questions, only insufficient documentation :-)
> > > > 
> > > > > > For examples please grep for drm_fbdev_generic_setup(). There's also a
> > > > > > still in-flight series from Gerd Hoffmann to convert over bochs. That,
> > > > > > plus all the kerneldoc linked from there should get you started.
> > > > > > -Daniel
> > > > > 
> > > > > this is one of google best founds if i search for drm_fbdev_generic_setup:
> > > > > 
> > > > > https://lkml.org/lkml/2018/12/19/305
> > > > > 
> > > > > not very helpful...
> > > > > 
> > > > > so i tried kernel-doc
> > > > > 
> > > > > https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup
> > > > > 
> > > > > which is nice function-reference but i've found no generic workflow
> > > > > 
> > > > > as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
> > > > > Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?
> > > > > 
> > > > > i personally make my first steps as spare-time kernel-developer :)
> > > > 
> > > > There's a ton of in-kernel users of that function already, I meant you can
> > > > use those to serve as examples ... If those + the kerneldoc aren't
> > > > good enough, then we need to improve them.
> > > > -Daniel
> > > 
> > > I've tried with drm_fbdev_generic_setup() and it works fine with simple
> > > modification. The patch is
> > > 
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > > @@ -16,6 +16,7 @@
> > >  #include <drm/drm_atomic.h>
> > >  #include <drm/drm_atomic_helper.h>
> > >  #include <drm/drm_crtc_helper.h>
> > > +#include <drm/drm_fb_helper.h>
> > >  #include <drm/drm_gem.h>
> > >  #include <drm/drm_gem_cma_helper.h>
> > >  #include <drm/drm_of.h>
> > > @@ -379,6 +380,7 @@ static void mtk_drm_kms_deinit(struct drm_device
> > > *drm)
> > >         .gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
> > >         .gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
> > >         .gem_prime_mmap = mtk_drm_gem_mmap_buf,
> > > +       .gem_prime_vmap = mtk_drm_gem_prime_vmap,
> > >         .ioctls = mtk_ioctls,
> > >         .num_ioctls = ARRAY_SIZE(mtk_ioctls),
> > >         .fops = &mtk_drm_fops,
> > > @@ -416,6 +418,8 @@ static int mtk_drm_bind(struct device *dev)
> > >         if (ret < 0)
> > >                 goto err_deinit;
> > > 
> > > +       drm_fbdev_generic_setup(drm, 32);
> > > +
> > >         return 0;
> > > 
> > > 
> > > But I implement .gem_prime_vmap with a workaround,
> > > 
> > > 
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > > @@ -280,3 +280,8 @@ int mtk_gem_create_ioctl(struct drm_device *dev,
> > > void *data,
> > >         mtk_drm_gem_free_object(&mtk_gem->base);
> > >         return ret;
> > >  }
> > > +
> > > +void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
> > > +{
> > > +       return (void *)1;
> > > +}
> > > 
> > > Current drm_fb_helper depends on drm_client to create fbdev. When
> > > drm_client create drm_client_buffer, it need to vmap to get kernel
> > > vaddr. But I think for fbdev, the vaddr is useless. Do you agree that I
> > > temporarily implement .gem_prime_vmap in such way?
> > 
> > The vmap is used by fbcon, without that fbdev won't really work I think.
> > So I'm rather confused on what you tested ...
> > 
> > Adding Noralf, he's the expert here.
> > -Daniel
> 
> I test with fb_test [1], it is a user space program just open /dev/fb0
> and mmap it to user space. I does not turn on fbcon so everything looks
> well. If support fbcon is essential, I would implement vmap correctly.
> If it's not essential, I think I could return 0 when
> CONFIG_FRAMBUFFER_CONSOLE is defined.

I think fbdev emulation without working fbcon is fairly useless. And it
shouldn't be that much work to make it work, we have quite a few more
helers for gem bo nowadays.
-Daniel

> 
> Regards,
> CK
> 
> [1]
> https://android.googlesource.com/platform/system/extras/+/master/tests/framebuffer/fb_test.c
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
