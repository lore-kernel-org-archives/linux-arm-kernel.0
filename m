Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93742C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:02:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676EA20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iq7F/Dat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676EA20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:Date:Subject:To:
	From:Message-ID:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ageE8zRMyaYoSjSNc+6CXIK9hH+4YMtCJQhICRUsTBw=; b=Iq7F/DatY+JyXb
	D6JHq6L1DNwdGv3CQEZUcElyyIvPuY/GORolDBgSWwIh8H5AAMirVgdv1ASEaKcPug8Fz+9DYNbel
	OzltrrjHX27uQz4yJPWDcTvUi77+qq1qUew87dsBV0t0W7Wf3AmsUKjB4djzUkql2M/HmIHxY4rmt
	A1GJZCtO7kzGLUft6qdxdaIfX+EOfkmKMTJ4T8d8buIFJUb6iEPibQwSOaDsD57n8riEok6mgBhCj
	LZFj+mt5qf9hELBAdET7l/s0X1kUriNWoCvSDHRKhhtrlQA4TKHvUCYB6MJl8k8Cp+EkgM3342Pr/
	W8YJJGpYIEXXbSxMJzaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghfaY-0002Dw-Ap; Thu, 10 Jan 2019 19:01:58 +0000
Received: from mout.gmx.net ([212.227.17.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghfaT-0002D4-GS; Thu, 10 Jan 2019 19:01:55 +0000
Received: from [91.14.65.202] ([91.14.65.202]) by web-mail.gmx.net
 (3c-app-gmx-bs35.server.lan [172.19.170.87]) (via HTTP); Thu, 10 Jan 2019
 20:01:37 +0100
MIME-Version: 1.0
Message-ID: <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
From: "Frank Wunderlich" <frank-w@public-files.de>
To: "Daniel Vetter" <daniel@ffwll.ch>
Subject: Aw: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
Date: Thu, 10 Jan 2019 20:01:37 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:xedABUXpNk/nNIw+pzn6H/6zhL8w0LyGmHIfFGWyhpMYu2A/+dCAzn6j9eXepGOFzS24L
 JV/TUt0pKZMfDb4/x9wsMXXNjJkKGUfZD9MFnaOjF1qyz1G+7LpRFjAn5xFwKhK8f2Ti1/1iuRhL
 OTYVw0t/pIHNXEu41Ax/n9IMA8SzqjPJXCYlw+Cr3IuGvFdilFbfsRU5DcCcGgDGbtJkAA1PjAg9
 sYfnCpRG6Rhy5W8P2LvX8vVGKVuKvq2fl7tux3uHtHmp8SUDa50zNti33p1QaVSgpqrz0LKyuvPi
 a4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:lqvXuVTiSD8=:DRKehKc2DdRFIpMmuNF02M
 XCSxz5gW/zZ9h9D6KeaZjQ4tQJj039IaoTzsJRSKjLMLoSQxbxPlsf9s8vfBnyHBlHOjTaLKl
 cOmB6ACA2677K6JZ92GDCmikdyWPwvk+Rvj194TN5qTOB70CgPNDCIwPd2q5xKOV7B19keZdQ
 qdqTLLse+BpP+tCKrF2VS+faT/0qh4XN9+tSMKZRF7+DnyF7Wme4PAVcgvIXjpL4ytQ73gvNj
 J6ig/WRoBa7BDXRT0Gi7PAcJbOaZ+o1kq+XmW5a4OFOT3nyc1Xz80f6qKBQRx9cCElKMvSUsW
 LgWOxysay4FT81G3xOy+fdiQiY3Gbl3e4RBS1HTM12pLGLto+F+RAPpSbkyofe/XYKTSjtORq
 02ASACd0WCObgtmB3T7zKHeOEX/fMcpMcsfTCUkVIcgdwoVYnYk+qXZv+RkxTJHWkn1Ku9NdW
 K3mZDcstElJKjXLY9DymO4LBBrYA0Sw2G3olDCZXCywkLXIpX/Vc8+v9J65XmbMIOUpVPS3iI
 0VSdc+nvZhYcweDQYEWev3xmQbwfwzd4WhKU/OVOiyLDAADJdIhc+AmME8Wyt+iGGX1cbLQpR
 XiFv2PdCN/O0A=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_110153_849424_19E84AA5 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: David Airlie <airlied@linux.ie>, Alexander Ryabchenko <d3adme4t@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, CK Hu <ck.hu@mediatek.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel,

> > Would be good to use the new generic fbdev emulation code here, for even
> > less code. Or at least know why this isn't possible to use for mtk (and
> > maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> > needed anymore.
> 
> Back on the mailing list, no private replies please:

i don't wanted to spam all people with dumb questions ;)

> For examples please grep for drm_fbdev_generic_setup(). There's also a
> still in-flight series from Gerd Hoffmann to convert over bochs. That,
> plus all the kerneldoc linked from there should get you started.
> -Daniel

this is one of google best founds if i search for drm_fbdev_generic_setup:

https://lkml.org/lkml/2018/12/19/305

not very helpful...

so i tried kernel-doc

https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup

which is nice function-reference but i've found no generic workflow

as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?

i personally make my first steps as spare-time kernel-developer :)

regards Frank

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
