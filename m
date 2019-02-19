Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C67C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:39:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366642147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T3RIKhzd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHIkL2Fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366642147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OrsD/+1XomGtraw2/4gH9R+xoRYqIN468WkMxUWRCSQ=; b=T3RIKhzdCZJBYW
	yL2Iu4LQb9HEWgEO59glJJ/kl87oisk7Y+D97veddiPLINtjK5vFLZDcGbAdeL+R3st+kCsbLxo6A
	Kuxz4GRreMyDdmfG/L+nalyOLlLop4g4j/J6ajh500Cprzcssvnt2fbq6aztt2TheEc4P+8KadQKY
	kaJHeNSK6qfszpDy3NTI+r97nVHVZG9ykKD6l+8eN8lP9JQVOicGpygqbFthCDqJ1PVBb18pD+hNH
	BfAU9mU+JoIy/oyPlgo9iv06WMrcF1cfLQbPGgnj4hkQiLR9Ihh86pej0jBYNRZCmKQNQbupEOE3+
	aE9/Eb3vAtAdZs6Cv7aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwEyy-0007ei-9Y; Tue, 19 Feb 2019 23:39:24 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwEyu-0007dt-Va
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:39:22 +0000
Received: by mail-lf1-x142.google.com with SMTP id q11so16138321lfd.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5hFiQkH7MQb4ozKg9YqmIfOGeIDqr9uI8jWHvthlU/Y=;
 b=mHIkL2Fl+PCYoE9pu/GNaMDbvrszSlgA63D2KX8jJ5CdwdADGYB8Fa6IPa7LVoeACm
 RT4Hgkltbv2dAxzfWCk8Zq1vzjMDjYbXyLjMjLM3zG2HsVfEVrg37RfjaBOr/uQB9jgz
 LvD9vVvlNE9VqRX5VpeEMczMCtledhJCn9bnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5hFiQkH7MQb4ozKg9YqmIfOGeIDqr9uI8jWHvthlU/Y=;
 b=Z2n4YNczPl93yqDAiLSFZmLFe8av53lmPwDyaPgEWn4eJgq6av2NlCMKGp/i3NKlXp
 sghKdzNYFAJjnlGDOqpEAt84cS5jNQVT7K2VlPUraX2gFSZxYTClw4nTDq3wCuSZyvnW
 jyl0DUcJPOgMGCSvHXWxjicAcbaAB3a2a5JYyTn+qTaRgGB7UIu9Rbi6EOjVKYNNw1AQ
 BBLaC20KwZ/3n3jW+cnfoAanTiiP1auV/LHskHISmzIpPQtr30kfOM4/U8yJhzHN2chf
 uD27I7IudXXkALrL5WV4E6tMaVaVATAybZ+W0K9hUMVArc4HCPsZK1+kXhZ7S0NRyTKM
 YDQw==
X-Gm-Message-State: AHQUAuZPX7Sty+wB6zbpWWIc9DbbxxaeIonUaiFhOMz6i9rqjpVMoJ+p
 aYfAVxLAjk/QiTAzlj/jWzUFk1DNiD4=
X-Google-Smtp-Source: AHgI3IbOWiAHk9aZMwH8WAyjs5qhxDzx3FFnSlqpK6lhlDGOIQskKJyT0urmrwtqhlP2sYVnds3FBQ==
X-Received: by 2002:ac2:4433:: with SMTP id w19mr18207564lfl.67.1550619559213; 
 Tue, 19 Feb 2019 15:39:19 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com.
 [209.85.167.41])
 by smtp.gmail.com with ESMTPSA id y22sm2192013lfj.31.2019.02.19.15.39.18
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:39:18 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id g12so6544359lfb.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:39:18 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr18126203lfh.117.1550619229104; 
 Tue, 19 Feb 2019 15:33:49 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-22-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-22-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 19 Feb 2019 15:33:12 -0800
X-Gmail-Original-Message-ID: <CAE=gft783rOUubODiFHxa9NKeUJxGk4FCeguDsyoqrUxsGDEsQ@mail.gmail.com>
Message-ID: <CAE=gft783rOUubODiFHxa9NKeUJxGk4FCeguDsyoqrUxsGDEsQ@mail.gmail.com>
Subject: Re: [PATCH v6 21/22] iommu/mediatek: Fix iova_to_phys PA start for
 4GB mode
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_153921_017078_40B46AD7 
X-CRM114-Status: GOOD (  22.20  )
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
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In the 4GB mode, the physical address is remapped,
>
> Here is the detailed remap relationship.
> CPU PA         ->    HW PA
> 0x4000_0000          0x1_4000_0000 (Add bit32)
> 0x8000_0000          0x1_8000_0000 ...
> 0xc000_0000          0x1_c000_0000 ...
> 0x1_0000_0000        0x1_0000_0000 (No change)
>
> Thus, we always add bit32 for PA when entering mtk_iommu_map.
> But in the iova_to_phys, the CPU don't need this bit32 if the
> PA is from 0x1_4000_0000 to 0x1_ffff_ffff.
> This patch discards the bit32 in this iova_to_phys in the 4GB mode.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0277396..076d333 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -119,6 +119,19 @@ struct mtk_iommu_domain {
>
>  static const struct iommu_ops mtk_iommu_ops;
>
> +/*
> + * In M4U 4GB mode, the physical address is remapped as below:
> + *  CPU PA         ->   M4U HW PA
> + *  0x4000_0000         0x1_4000_0000 (Add bit32)
> + *  0x8000_0000         0x1_8000_0000 ...
> + *  0xc000_0000         0x1_c000_0000 ...
> + *  0x1_0000_0000       0x1_0000_0000 (No change)
> + *
> + * Thus, We always add BIT32 in the iommu_map and disable BIT32 if PA is >=
> + * 0x1_4000_0000 in the iova_to_phys.
> + */
> +#define MTK_IOMMU_4GB_MODE_PA_140000000     0x140000000UL
> +
>  static LIST_HEAD(m4ulist);     /* List all the M4U HWs */
>
>  #define for_each_m4u(data)     list_for_each_entry(data, &m4ulist, list)
> @@ -415,6 +428,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>                                           dma_addr_t iova)
>  {
>         struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +       struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
>         unsigned long flags;
>         phys_addr_t pa;
>
> @@ -422,6 +436,10 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>         pa = dom->iop->iova_to_phys(dom->iop, iova);
>         spin_unlock_irqrestore(&dom->pgtlock, flags);
>
> +       if (data->plat_data->has_4gb_mode && data->dram_is_4gb &&
> +           pa >= MTK_IOMMU_4GB_MODE_PA_140000000)
> +               pa &= ~BIT_ULL(32);
> +

The define doesn't really make it much better, but I guess it doesn't
make it worse either. As I was reviewing this I was thinking that this
should be rolled into patch 6 "iommu/io-pgtable-arm-v7s: Extend
MediaTek 4GB Mode". But I guess this was returning bad PAs since
before this series, right? So does this need a Fixes tag?
-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
