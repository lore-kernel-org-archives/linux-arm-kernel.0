Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E03C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:38:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A026420869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gyUcbRhw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G96T8zeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A026420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mc5T6OXtc7+zpCSAno4SCwhLfWgI74k+Es4uHrdE04E=; b=gyUcbRhw5tCv+a
	VV0XqUU5055GvEWaWdmvzEgGUTzD5/fijRRrx8LYNkGQ682p+PWk48ebTneHNd6SCt/8Ke1/zVddN
	kwsqWlSGhY0fdW6OgvxmVfdCpqDH8MO5GOXppET77UF5E/1x1Pp8uoUe0R/YonV/UxkGMtcIxnre3
	GL2m6ZBecc0I2/XzQFXGDSx3WzUlVvtFiUiiyNoCSFCsrSpWHTFoa14Cf05UgWnBTq3tuUGXLDR8Q
	Mww889Hh8bSodsJ8IZX4dgvcHA4ZIeM9VDQDu2KCV+sx3k98TlFy/PyTzUib6eyYNp3v1TNOD/Me4
	i3A1wRFiyXfvCo6yIUPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goukG-0001RV-27; Wed, 30 Jan 2019 18:37:56 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goujM-0000eb-Gm
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:37:03 +0000
Received: by mail-lj1-x241.google.com with SMTP id v1-v6so504017ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XP/+aa8KV0RdJRkGEOst+CVjF7HcELVsTDtdEZCiVOc=;
 b=G96T8zeUlc0YSCk1AnGOW1QWPsVOFvsMVR8DsvaQszkVPfil3yhlUcF7LDxTwyZw79
 PCjfW+yNkQQ4UBO4Vop5J9s//EJb2NpJttjnjtPdxiFGtGozEQbBW+Rg5Z6/ULy4vgQu
 AL6R56JRJciJPk0iv1WCbwR8wIHWhSguE67MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XP/+aa8KV0RdJRkGEOst+CVjF7HcELVsTDtdEZCiVOc=;
 b=RAovcxinUldrO9EfebMixD1aTZsLSDx5l05p7N29VvwX9x+Cv6xeKdkBWkTj7w62sb
 0wT5NwrWQI1C38zTatB6cbptSCZH86cKZqDORG9p1tMfe55lx6oAZy7dbXTIhf1SxzNt
 Tf/oEgnBfK/l4j0MRNIGTGpmaZAzChzuVX2CMQvtHsXlvRngklX1ffF/BcLV9MraUZXA
 FygMAQb6oiEfovCRSnMxoPbfrwsXbx8AqtZKEcu4z6WyvoKSV9dXC7Ldu9NUEHVG9VvA
 e6sYEXo9KlFHC0h7gOq5nOBqRX8XvD2HkM8MpV2w2wOjUAts4TgmvXBLA/rZ+NLVQA6N
 GPDg==
X-Gm-Message-State: AJcUukcF/VRjthdxCk7vIEhxHo/8TrARhgo9Cf0HowZ6/2MNWxfO4Vb9
 b4G3wnrvJL1xvuyeR6/kSZKpGgrZl9c=
X-Google-Smtp-Source: ALg8bN5S3+It0g4AWz6z1WKYnMZ+YZmlklvmMGJ/HG8hGuyspc4xrSHhwNiuVFo2kiJfIPtO72TSKA==
X-Received: by 2002:a2e:9f56:: with SMTP id
 v22-v6mr26730742ljk.114.1548873418719; 
 Wed, 30 Jan 2019 10:36:58 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com.
 [209.85.167.51])
 by smtp.gmail.com with ESMTPSA id 4-v6sm385000ljw.84.2019.01.30.10.36.58
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:36:58 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id a8so405775lfk.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:36:58 -0800 (PST)
X-Received: by 2002:a19:d381:: with SMTP id
 k123mr24311307lfg.101.1548873105432; 
 Wed, 30 Jan 2019 10:31:45 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-14-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-14-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:31:09 -0800
X-Gmail-Original-Message-ID: <CAE=gft6nQ4uv5kqYO876sQaKo71F0RkMj4d-dKDvxi8pEy-WgQ@mail.gmail.com>
Message-ID: <CAE=gft6nQ4uv5kqYO876sQaKo71F0RkMj4d-dKDvxi8pEy-WgQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/20] iommu/mediatek: Add mt8183 IOMMU support
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_103700_797991_FEA5D296 
X-CRM114-Status: GOOD (  20.94  )
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

On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> the ARM Short-descriptor like mt8173, and most of the HW registers
> are the same.
>
> Here list main differences between mt8183 and mt8173/mt2712:
> 1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
> 2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
> 3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
> mode".
> 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> the bit[33:32] in the physical address of the pgtable base, But the
> standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> we add a mask.
> 5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
> 6) mt8183 need reset_axi like mt8173.
> 7) the larb-id in smi-common is remapped. M4U should add its larbid_remap.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 15 ++++++++++++---
>  drivers/iommu/mtk_iommu.h |  1 +
>  drivers/memory/mtk-smi.c  | 20 ++++++++++++++++++++
>  3 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 2913ddb..66e3615 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -36,6 +36,7 @@
>  #include "mtk_iommu.h"
>
>  #define REG_MMU_PT_BASE_ADDR                   0x000
> +#define MMU_PT_ADDR_MASK                       GENMASK(31, 7)
>
>  #define REG_MMU_INVALIDATE                     0x020
>  #define F_ALL_INVLD                            0x2
> @@ -342,7 +343,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>         /* Update the pgtable base address register of the M4U HW */
>         if (!data->m4u_dom) {
>                 data->m4u_dom = dom;
> -               writel(dom->cfg.arm_v7s_cfg.ttbr[0],
> +               writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,

So there aren't any other bits down below 7 that you need, like the
shareable bits?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
