Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C7EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:02:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94B52184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NLs/WZrx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sg/1LAlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94B52184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qyhn31P3Hr6nyPsdKC0HEBAJ0swwUml1mrcW+Hm3vIA=; b=NLs/WZrxi3tLyO
	1AAUZfxYrtxokFE+fefeJQ2OOFMj2ochM+p5pZ5oWMidBrzlfN/i1el7gY2eoyCKrn4CuTuQ29RVx
	5LCmn9Kwjak+fwH5cOyyPPRTFkwgwNSTF3mVJ/7i0iESCOedRPxbcAnK7JKK8DryXj1hS/YVetSZD
	tjZ+B3Qg1u02W589jqbPtcG8pLQv9lkvls6aiRGdYJQZV/zEweRkpMfHlCjrOyZAD+SeUn4bq4ydl
	mtMyhFY87bY8L+n3RCFUxzYpmfWQvgT8D4/AemFYFP6IfpzJwUiULzQFDzCT4VIRcUopsfhO1xxZ0
	MCDj/+oOMogGFoexuE0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gov7m-0004Ks-HJ; Wed, 30 Jan 2019 19:02:14 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gov7j-0004KY-LI
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:02:13 +0000
Received: by mail-lj1-x242.google.com with SMTP id s5-v6so473108ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xVAhcBnT4pyU9hfS17+pqFPt/MfKXdwkrExkLukGrKw=;
 b=Sg/1LAlpcV3YwX9KeMC1DS+dGRdVswUBWA9ft43mbvFV883HZ0jV2tbBDjIVhr2w6B
 HiL+XjWY/ccQKqZn0qFj4HiYPL3o+xAf9vWTalhnNYLUfhGzHMhcnSAS1C7UJOSNa8zF
 1hLD/3B45QNEHe9LC+Zj6hjcc9J5k5J779xKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xVAhcBnT4pyU9hfS17+pqFPt/MfKXdwkrExkLukGrKw=;
 b=oUHADjZxg6K0Hg5KujtNchj33DJB+vIwW6w8lX2RxTSpOo+59mRslDG+Yu+hAjbcp6
 lvMC4mDS3B6tKkt68iNH2PiPKgUwbzVtM670SzGYmgFVFZGeGOdkXrPFNOnqMIwHHrPS
 CCD7wXbcdEF7fQH3kXKqvWMunA1dhxrTQg9Qn/8/UppiEh6ERuQLxVVd/G2ur6ioBN+U
 8mif5wUmDXYtJnq6W02UKzHWv4Xkbzwt2TSlrtiQikoeulKjfiYI3uNg+amh/zo8aqvK
 BHlHR2gpfOMn3u6oWviuATD7PCDF8yjIZWt74zWOpRzfh285PbzgF+GIeVy/daKAEvgJ
 agvA==
X-Gm-Message-State: AHQUAuZmYRnf7tlBhi+Pn68eclceoZwWs6akfcgJio4zbLcLK50suB81
 xKfL8BaVWdMGnYFcy3tcoNchaWYIqt4=
X-Google-Smtp-Source: AHgI3IbxH9uQjV9HSPYd0oPp6Cqtp32v+WJr/MEON5BERyGDbjmOx72rOGpJWw7YpJqMwM0iUKN4cg==
X-Received: by 2002:a2e:561d:: with SMTP id
 k29-v6mr13851627ljb.91.1548874929445; 
 Wed, 30 Jan 2019 11:02:09 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180])
 by smtp.gmail.com with ESMTPSA id y24sm421335lfj.17.2019.01.30.11.02.09
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 11:02:09 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id k19-v6so486741lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:02:09 -0800 (PST)
X-Received: by 2002:a2e:6109:: with SMTP id
 v9-v6mr24506538ljb.126.1548873054750; 
 Wed, 30 Jan 2019 10:30:54 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-11-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-11-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:30:18 -0800
X-Gmail-Original-Message-ID: <CAE=gft72KfZ9RdDTJeEpQJ7h3_cOXzm1YRQG-U47s64QVOhabA@mail.gmail.com>
Message-ID: <CAE=gft72KfZ9RdDTJeEpQJ7h3_cOXzm1YRQG-U47s64QVOhabA@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] iommu/mediatek: Move reset_axi into plat_data
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_110211_702821_F9C224C0 
X-CRM114-Status: GOOD (  21.02  )
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

On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while
> it is extended to REG_MMU_CTRL which contains _STANDARD_AXI_MODE in
> the other SoCs. I move this property to plat_data since both mt8173
> and mt8183 use this property.
>
> It is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 4 ++--
>  drivers/iommu/mtk_iommu.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 35a1263..8d8ab21 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -558,8 +558,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>         }
>         writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>
> -       /* It's MISC control register whose default value is ok except mt8173.*/
> -       if (data->plat_data->m4u_plat == M4U_MT8173)
> +       if (data->plat_data->reset_axi)
>                 writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);

The commit description makes it sound like the overall format of the
register is the same, but the "other SoCs" have some extra bits they'd
like to leave alone. Would it be easier to do a read-modify-write to
always clear some bits in the register, instead of doing something
based on the SoC? Or do the bits mean completely different things in
the different versions (in which case what you've got makes sense to
me)?
-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
