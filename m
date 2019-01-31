Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D40C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:53:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C65120881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n1LW3OsA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7oVvdeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C65120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lp1EUIcsfHeMG7gmvyqPJB1Y0ZwlREQCVSe2BG72La4=; b=n1LW3OsAcNiGPg
	rhH+EUxKwx93C3iIui1vbXsONNSg83MR1GesZOR1p1jZhmzhb5zMcN178h/zv/nTNOYoR5sBJR7L+
	1O7+Z3m/LlO+4VHubH0axc6Fc5d9fxeX0KQlFJvYV8BBosGFYRvZf/iZzopNG5vFfDGUYUf3NNIV/
	evzzafJ5q74bPKDgJGhRS24WjQfBYNdMPuUwSyj7aQ566daSA6zORmAn/fYLFA4fN10arim0Bnpwi
	mdPTysk9Uikp4hSNMbl8z8hapQFBS3vL5T21562i0adPGsL8sPQ8m6VGSfc2zYX+tYyGZNY24tLs+
	SLi6zKNx0ZmR9UEZFGJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpGWm-0004qb-Ui; Thu, 31 Jan 2019 17:53:28 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpGWj-0004qC-Qv
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 17:53:27 +0000
Received: by mail-lf1-x141.google.com with SMTP id i26so3042238lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 09:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0XNEU5MGizPm3b2AbjTBvU02y37bzN/zv/cszap9R4E=;
 b=O7oVvdegYX6NSnBJqxcLGjNHcYkjNkxImCUkgdTT0n/7AfZQjdh+1uTzs8agVympNA
 hNKN+jQxLaRPNDsUntqfFIG5P7F6uhN1MirK/7Nybe/WApF9jifYXMIIdbBo1I42Ds6D
 /k7wzk/xpyGsFsfmAI/xci8Ee59QREc5KYVps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0XNEU5MGizPm3b2AbjTBvU02y37bzN/zv/cszap9R4E=;
 b=VWGLL3vc07Epmq3m6/5Ru2tthdVO1sYRarSBdKRumu44gdQifszhhpNuF8gahICCtV
 e0t2dOw1gvsqOSUM+Wt/lsb81hp1VTehQTwCmWBKDs1TWvlW2HTP3U0LBvEGY2uUCxDC
 6C6J1QDQ7qYBpF9iP/BgPVVclWm++QeRD7+0Awk5ZrjA97SUrevRuIouHaAKeq6LFO+E
 xhhYiYVTAxSFs3Tq2X9iwMbiw0WD3dKVwn1T1LRf1AIT6xcxzZwnqWgOnfeQtlxdnAQc
 RLCFFNkt0JCXmTt/6UnQp9N0O5B8cwwkUzp+XitX5EZ5sjWwiMvzDCzbRcAWcVMKK4jN
 5alg==
X-Gm-Message-State: AHQUAuYN6xKcYab7KJYgp03/q2sFiv2eKLDnCJezhFfVIIyAFP2hOmvQ
 sSNtU9vGUwu535Y3hfIVPBf61EkLEbs=
X-Google-Smtp-Source: AHgI3IYZbG55OK4Dq6dBFupSQPsKUX7IL+fmxOe8D5JlAdIK50hdueq0TzyOGLyFMn38ke7QRP1tbw==
X-Received: by 2002:ac2:52aa:: with SMTP id r10mr1756233lfm.56.1548957203700; 
 Thu, 31 Jan 2019 09:53:23 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50])
 by smtp.gmail.com with ESMTPSA id h12-v6sm869673ljb.80.2019.01.31.09.53.23
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 09:53:23 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id l10so2983908lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 09:53:23 -0800 (PST)
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr27062208lfd.90.1548956785044; 
 Thu, 31 Jan 2019 09:46:25 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-18-git-send-email-yong.wu@mediatek.com>
 <CAE=gft4vOxt7G0CqZxvNUxCmuGq_L4wc2Wv6LF4Y62BoJQEUXw@mail.gmail.com>
 <1548904937.19710.39.camel@mhfsdcap03>
In-Reply-To: <1548904937.19710.39.camel@mhfsdcap03>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 31 Jan 2019 09:45:48 -0800
X-Gmail-Original-Message-ID: <CAE=gft6do4Ku7ErqxY2tbPwqDN_3w6i_ygxvyUSyXLYzxvNwTg@mail.gmail.com>
Message-ID: <CAE=gft6do4Ku7ErqxY2tbPwqDN_3w6i_ygxvyUSyXLYzxvNwTg@mail.gmail.com>
Subject: Re: [PATCH v5 17/20] memory: mtk-smi: Get rid of need_larbid
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_095325_891202_F6F44743 
X-CRM114-Status: GOOD (  28.34  )
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

On Wed, Jan 30, 2019 at 7:22 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2019-01-30 at 11:11 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> > > It's no need to parse it again in SMI driver. Only clean some codes.
> > > This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> > > and mt8183.
> > >
> > > After this patch, the "mediatek,larb-id" only be needed for mt2712
> > > which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> > > in which the larbs in the "mediatek,larbs" always are ordered.
> > >
> > > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/memory/mtk-smi.c | 26 ++------------------------
> > >  1 file changed, 2 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > index 08cf40d..10e6493 100644
> > > --- a/drivers/memory/mtk-smi.c
> > > +++ b/drivers/memory/mtk-smi.c
> > > @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
> > >  };
> > >
> > >  struct mtk_smi_larb_gen {
> > > -       bool need_larbid;
> > >         int port_in_larb[MTK_LARB_NR_MAX + 1];
> > >         void (*config_port)(struct device *);
> > >         unsigned int larb_direct_to_common_mask;
> > > @@ -153,18 +152,9 @@ void mtk_smi_larb_put(struct device *larbdev)
> > >         struct mtk_smi_iommu *smi_iommu = data;
> > >         unsigned int         i;
> > >
> > > -       if (larb->larb_gen->need_larbid) {
> > > -               larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> > > -               return 0;
> > > -       }
> > > -
> > > -       /*
> > > -        * If there is no larbid property, Loop to find the corresponding
> > > -        * iommu information.
> > > -        */
> > > -       for (i = 0; i < smi_iommu->larb_nr; i++) {
> > > +       for (i = 0; i < MTK_LARB_NR_MAX; i++) {
> >
> > Looks like this was the only use of mtk_smi_iommu.larb_nr. Should we
> > remove that now?
>
> This is necessary since the mt2712 which has two M4U HW.
>
> From its dtsi[1], take iommu1 as a example, its larb_nr only is 3, but
> we need scan all the larb.
>
> [1]
> http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016119.html

I'm not sure I follow. My point was that this structure member is only
ever set but never read:
$ git grep '[.>]larb_nr'
drivers/iommu/mtk_iommu.c:      data->smi_imu.larb_nr = larb_nr;
drivers/iommu/mtk_iommu_v1.c:   data->smi_imu.larb_nr = larb_nr;

Maybe I've applied the patches to the wrong tree, and there is a use
of this member I'm not seeing?
-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
