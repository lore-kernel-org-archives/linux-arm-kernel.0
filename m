Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D05C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:56:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB2F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZFYd0iDL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UKdQOyNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB2F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RUU9L6BApg3KKzuy5ToKbi4N/ATgIwTsvsY0VFOVAfg=; b=ZFYd0iDLn+BHaw
	eqfqkmM6nuHc1srXto6eiwZ0EUOPP6h/xyZiRvBt5w4Vf/TpIkxZP8YmY/nzMTSwkF048zvCqDb5O
	HRGevCIL6eLlF/1enqIeeH1Ay4cNpfCTdIraYVqaccD9ZnODBQVXpPH4ZcAbFU7L0n4GGxOjVkg3N
	ngz/p+dmylIWcGA74SvGzkMu5sFM5STEzZlZV2NYr71Wo/htqc/ydfb2pwgIv2xSH1uFw/wpoZRgN
	CiZSjgr6FMk/Z30GNk6whIyoKYbDOwFTUMr9y4C8XtOePbQdG5zbe55swTMQRWewtyvwGatwgIw6M
	vJwX3VzDYUFiklgXFXGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gov2A-00024G-D8; Wed, 30 Jan 2019 18:56:26 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gov1u-00020o-1q
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:56:15 +0000
Received: by mail-lj1-x242.google.com with SMTP id t9-v6so513007ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RDw5sWCs3kR4DAIs/UO/8X+8choKwOZ5wTyIJOu2aRs=;
 b=UKdQOyNvx/BWDWSTNPC6tCnq5oeqeUJiU+8c1WMG5VPWiNVOZC3xob/9/lTjsb931f
 +ByBZtzXD6pRNIJ/Q8XS90VMonipSiLwqgvq1+UJ3AeHowdf/7G0U+7uZZut/QLelldH
 nn2AIwgWxdIPm1lA1Uj/aMmybZkOLbE2hYYIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RDw5sWCs3kR4DAIs/UO/8X+8choKwOZ5wTyIJOu2aRs=;
 b=pI3h4I8rN690BUlbrgcM3Gn6k5uny3LpWwrEcdzvZSKrxXCYDkYCUAiTs9nE56tXmu
 dQd4ZQDWeEJGisemVHzsUhBnJX1qqu6sWDexHAPHFg7PpuP/eB5XOC/g8++KxoH9OeS6
 Jpc5E58pVxGg8n7E9vTqIIHqKn2uGrE8SatUQEl9+8wAWuwgZf3pJp1Wu5jUg0DpOy9p
 lrraP60GCyBOQcPnYaCcNqCm1BlhRqPYz7jVCCCQ1GRaa/OupWfY5dHzaO4TMei0G9XY
 Q9y4bczEgNbNtLcfWT7EtxZTjQHEZ+/cqGOhI9xvBb3K8TcAMkoXqJnLZ94d/X2M1CZT
 cCwg==
X-Gm-Message-State: AJcUukdt8HkQkYWv629/XzibSV3yA0cbhBHuuKQ2+b9RNoiL6Ln9kFrX
 iWkiaEdEthtJ6o5q/ZRFadhkYcWlRZc=
X-Google-Smtp-Source: ALg8bN4EP3zjtBBlFhunqI/4g267/drVXfyzq+4MHaLGZ395LcPpXfAAM4kmJqN/IONWPbxUB5T7Nw==
X-Received: by 2002:a2e:5854:: with SMTP id
 x20-v6mr25272097ljd.31.1548874567980; 
 Wed, 30 Jan 2019 10:56:07 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com.
 [209.85.208.179])
 by smtp.gmail.com with ESMTPSA id c20sm412923lfj.67.2019.01.30.10.56.07
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:56:07 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id s5-v6so457170ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:56:07 -0800 (PST)
X-Received: by 2002:a2e:7011:: with SMTP id
 l17-v6mr24947251ljc.147.1548873036569; 
 Wed, 30 Jan 2019 10:30:36 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:30:00 -0800
X-Gmail-Original-Message-ID: <CAE=gft7TnvSDskOmeXp4Z-D45uwOfwyiJo0CYY=Q93NR0PvRnA@mail.gmail.com>
Message-ID: <CAE=gft7TnvSDskOmeXp4Z-D45uwOfwyiJo0CYY=Q93NR0PvRnA@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] iommu/mediatek: Refine protect memory definition
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_105610_356983_F2701237 
X-CRM114-Status: GOOD (  22.42  )
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
> The protect memory setting is a little different in the different SoCs.
> In the register REG_MMU_CTRL_REG(0x110), the TF_PROT(translation fault
> protect) shift bit is normally 4 while it shift 5 bits only in the
> mt8173. This patch delete the complex MACRO and use a common if-else
> instead.
>
> Also, use "F_MMU_TF_PROT_TO_PROGRAM_ADDR" instead of the hard code(2)
> which means the M4U will output the dirty data to the programmed
> address that we allocated dynamically when translation fault occurs.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> @Nicalos, I don't put it in the plat_data since only the previous mt8173
> shift 5. As I know, the latest SoC always use the new setting like mt2712
> and mt8183. Thus, I think it is unnecessary to put it in plat_data and
> let all the latest SoC set it. Hence, I still keep "== mt8173" for this
> like the reg REG_MMU_CTRL_REG.
> ---
>  drivers/iommu/mtk_iommu.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index eca1536..35a1263 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -53,11 +53,7 @@
>
>  #define REG_MMU_CTRL_REG                       0x110
>  #define F_MMU_PREFETCH_RT_REPLACE_MOD          BIT(4)
> -#define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
> -       ((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
> -/* It's named by F_MMU_TF_PROT_SEL in mt2712. */
> -#define F_MMU_TF_PROTECT_SEL(prot, data) \
> -       (((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
> +#define F_MMU_TF_PROT_TO_PROGRAM_ADDR          2
>
>  #define REG_MMU_IVRP_PADDR                     0x114
>
> @@ -521,9 +517,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>                 return ret;
>         }
>
> -       regval = F_MMU_TF_PROTECT_SEL(2, data);
>         if (data->plat_data->m4u_plat == M4U_MT8173)
> -               regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
> +               regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> +                         (F_MMU_TF_PROT_TO_PROGRAM_ADDR << 5);
> +       else
> +               regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR << 4;

I agree with Nicolas with regard to not having the random 4 and 5
sprinkled in the function.
-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
