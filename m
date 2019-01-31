Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E22C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:43:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26722084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mhYY//i4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dKWvkS0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26722084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wVu++rIb8sFhudZv47nCjOTReGL6ZJrPVy2BVvlKCKw=; b=mhYY//i4U4d3v5
	GzK7/jhfuxVY4RapKQSm/XlqVeR3NuQ3/Ub9EUxw02k3YaxI4QmbN/c9XGXw/R2aQ+YoitACaL67/
	feAQFTqnhkbiPHMz6kAQgPcceHOTflcMMWcpbrstI1SeFII9hcwVtSRE+VZ8IeFij7z/p4U4Gfnac
	13jZaID/bX6+rzie6NiFvEIFHnVfunK4koZG1zRSOccn0q3jXNm/8pDBBvroGTPmcVHB4lpo4lNHi
	T3RiunmTurx1nuIhxu5eHn3W7yEFGGgh7WBG3EtFlTr1uUAVSov6d98zue6MQ8HAal38bi6SC59LY
	nbKTNMPva22RbWrAf9/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFQi-0003mc-8A; Thu, 31 Jan 2019 16:43:08 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpFQd-0003mA-51
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:43:04 +0000
Received: by mail-lf1-x143.google.com with SMTP id c16so2813143lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lW5D3gcqaZFTIynuG5+XGzwm6TlVkJOR5eGnIKEV1dk=;
 b=dKWvkS0ESAm34gQePnmEYissq/yFcRDG/SLR0NEjoyNvgQxBUQ2EK/+nHACP304kBF
 EafDswZfZmUePOCrZNGOB1ij5vteqjOZ5eFubRGIPohNx01vSRsJO3zlvtf9ST0hz3sg
 3AmNgpe6KQYAuXnKzd5/onMzKrQbS9wE4jxPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lW5D3gcqaZFTIynuG5+XGzwm6TlVkJOR5eGnIKEV1dk=;
 b=N1/CQ3bnNusFAQXBbmQk14IjSdmAleoLdMuYltrilRmDsbyOIys1Eh5DAhGrxwOeYc
 vRv14ZC8Y5KpbEyg2McjsszTcorYBplGahs8qdZHKpJyLfcWWkr6G3vxpBCtWIqsxrMO
 KJa2OrwkM8E0xG6krmjgCVDjy51QSTWiQ8RxdiKCUYVL7Kx9NICoWph2VNJEFyWnB4H4
 A7xEG8UL393aM3NNQQyXWE82anouRXX+XcIMjC8l6F1sxHhK1bgp5Wt3HQ1zdkSm+eCr
 Gh9Y5P25VGTS2XAhwwtERMYh+3MkPOgTk9Huhbgbi4X60H5Lu6K3Rfytb3x9go9N8oaG
 +hcQ==
X-Gm-Message-State: AJcUuke2uhEyUSOiFa2ltyDqyolsFxsLTVQlYzHdtiAOf4dVjM+eJXMr
 LuD5m5v4UaZG7TIpLuuL9u7BDibXsr4=
X-Google-Smtp-Source: ALg8bN6JOaF0LdKRT7t6C4YEGmEARyhykpIJoUUROYZQklfV5zxp2One17tdZZVl0/Q1TFYlzf832A==
X-Received: by 2002:a19:1a14:: with SMTP id a20mr27242954lfa.1.1548952980498; 
 Thu, 31 Jan 2019 08:43:00 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172])
 by smtp.gmail.com with ESMTPSA id z17sm339106lfh.9.2019.01.31.08.43.00
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 08:43:00 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id v1-v6so3295295ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 08:43:00 -0800 (PST)
X-Received: by 2002:a2e:9181:: with SMTP id
 f1-v6mr21562086ljg.64.1548952609813; 
 Thu, 31 Jan 2019 08:36:49 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
 <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
 <1548904841.19710.36.camel@mhfsdcap03>
In-Reply-To: <1548904841.19710.36.camel@mhfsdcap03>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 31 Jan 2019 08:36:12 -0800
X-Gmail-Original-Message-ID: <CAE=gft7DNKu93c8e47nrC7Q7h4VL3vGwkj8ycQM8yVdCdjb+hw@mail.gmail.com>
Message-ID: <CAE=gft7DNKu93c8e47nrC7Q7h4VL3vGwkj8ycQM8yVdCdjb+hw@mail.gmail.com>
Subject: Re: [PATCH v5 11/20] iommu/mediatek: Move vld_pa_rng into plat_data
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_084303_277275_754A7BB8 
X-CRM114-Status: GOOD (  25.35  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
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

On Wed, Jan 30, 2019 at 7:20 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2019-01-30 at 10:30 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > Both mt8173 and mt8183 don't have this vld_pa_rng(valid physical address
> > > range) register while mt2712 have. Move it into the plat_data.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/iommu/mtk_iommu.c | 3 ++-
> > >  drivers/iommu/mtk_iommu.h | 1 +
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 8d8ab21..2913ddb 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -548,7 +548,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> > >                          upper_32_bits(data->protect_base);
> > >         writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
> > >
> > > -       if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> > > +       if (data->enable_4GB && data->plat_data->vld_pa_rng) {
> > >                 /*
> > >                  * If 4GB mode is enabled, the validate PA range is from
> > >                  * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> > > @@ -741,6 +741,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> > >         .m4u_plat     = M4U_MT2712,
> > >         .has_4gb_mode = true,
> > >         .has_bclk     = true,
> > > +       .vld_pa_rng   = true,
> > >         .larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
> > >  };
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > > index b46aeaa..a8c5d1e 100644
> > > --- a/drivers/iommu/mtk_iommu.h
> > > +++ b/drivers/iommu/mtk_iommu.h
> > > @@ -48,6 +48,7 @@ struct mtk_iommu_plat_data {
> > >         /* HW will use the EMI clock if there isn't the "bclk". */
> > >         bool                has_bclk;
> > >         bool                reset_axi;
> > > +       bool                vld_pa_rng;
> >
> > I agree with Nicolas that valid_pa_range would be much clearer...
> > although, even now that I know what it's supposed to mean, I don't get
> > what it represents. What is this saying?
>
> This register in the coda is called "vld_pa_rng".
>
> How about I change it to "has_vld_pa_rng"?. In the comment above, I have
> explained the meaning(valid physical address range).
>

Ok, that sounds fine.
-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
