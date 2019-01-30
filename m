Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B68CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:38:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AC32083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aQC6uYzF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oTw/lUF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AC32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LjA2X1e4AaFelVy8sxQ+c8cnaVSPXVBXrm0C8/K0Wk0=; b=aQC6uYzFtTGNcf
	erTrDy6aP6OavHjoIxuIRtF2XJxowVHo7qsKg2JDdcNXZokJJ2+UUjQ0jo5qB7txfoo155Hq4IFOj
	J9MC3uDldDsLRN0PlF80CgLjK8+3CRgOJftjZ/I+Nj4c9kokQX+bOQwokwKXHI37O7drflBO05Tah
	OsrPK+lfXS7MhFTf7umWzQOaPZOboo1DlKiHqCRwb7fZI3II6PRcYddaewwWyswp1DjapuiwRbjKI
	bq5TL7V3BqQJwvcjlxEMwCS14y9cUoFb9nQgeFcOH1ZS3DbeTC91QS6wzzI2iRj7Ms12LE+V1L/Ck
	QNBkJaDendM6suqqdFFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goul7-00023a-8i; Wed, 30 Jan 2019 18:38:49 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goujq-00012l-7g
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:37:47 +0000
Received: by mail-lj1-x241.google.com with SMTP id k15-v6so448505ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MFK9fDVCrEcW9cs9+Bfj5Lsq8+kacWpOw55FKDAtOqA=;
 b=oTw/lUF+PWcmdEgfJkpPInfa7/Ud8w+AfErgLPp4kH5d8qa3YNJlp0M15NucGPRgie
 GTw35zC/YffKZksIyOKzBUG6tvPXikLfco6y5vLiYNg3d3lJf3MPp7iehgsnNVpj/U5K
 BCiBSfatvjS8fIY6WXlgcozotQw0fUOQFzmaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MFK9fDVCrEcW9cs9+Bfj5Lsq8+kacWpOw55FKDAtOqA=;
 b=jtLRn1MWXrFlR6zqBc3kYeVUQzw6gsoO+HZXVW4uqATgaTku0Uo7Sb1QomB1dZM5ju
 qiQ4ODB8vugCaRmEj6xHjZYYSiHkxfvS2Z87kqtopM5VuUOv+u2gZr+f3uqAI82b9EEa
 4v+p4OmISHA3nvoEH4DofC2INdFpj7RuxpL5C6zQLuSTkH362Bs32CPe5xr0rHxbjEPL
 nal0rLdl2Z5tWuHK119VwLKHsXvsza6x0lGCpD28Z9Y5ekjTk9Cqb8/DMzJiFxfkqVMz
 ZU9NTz5JmCkB7DTmgjJCiFBmYeAODAfKOtwPtf3+ti/Ej0Vc1xo5UDfOtrclmLwBibTh
 VNXw==
X-Gm-Message-State: AJcUukdY9ZY4UwgQW3rdnN5UqdSqWxxu8IYyYuPnsWlG+Ev4R+SG1aw2
 HETofBi5RZ/pZ2B53JU/U41+FnND34s=
X-Google-Smtp-Source: ALg8bN5/pXtqB8R8p/zAM9Rth7cZZj+U8OFcI9xffMgpxv/UZSpOl2tsB4uETrzRiIc0m/muG5NZhw==
X-Received: by 2002:a2e:91d1:: with SMTP id
 u17-v6mr25682379ljg.160.1548873448491; 
 Wed, 30 Jan 2019 10:37:28 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180])
 by smtp.gmail.com with ESMTPSA id u24sm411196lfi.24.2019.01.30.10.37.28
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:37:28 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id n18-v6so456470lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:37:28 -0800 (PST)
X-Received: by 2002:a2e:9715:: with SMTP id
 r21-v6mr25990512lji.30.1548873076878; 
 Wed, 30 Jan 2019 10:31:16 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:30:39 -0800
X-Gmail-Original-Message-ID: <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
Message-ID: <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
Subject: Re: [PATCH v5 11/20] iommu/mediatek: Move vld_pa_rng into plat_data
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_103731_136977_84198122 
X-CRM114-Status: GOOD (  20.22  )
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
> Both mt8173 and mt8183 don't have this vld_pa_rng(valid physical address
> range) register while mt2712 have. Move it into the plat_data.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 3 ++-
>  drivers/iommu/mtk_iommu.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 8d8ab21..2913ddb 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -548,7 +548,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>                          upper_32_bits(data->protect_base);
>         writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
>
> -       if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> +       if (data->enable_4GB && data->plat_data->vld_pa_rng) {
>                 /*
>                  * If 4GB mode is enabled, the validate PA range is from
>                  * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> @@ -741,6 +741,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>         .m4u_plat     = M4U_MT2712,
>         .has_4gb_mode = true,
>         .has_bclk     = true,
> +       .vld_pa_rng   = true,
>         .larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
>  };
>
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index b46aeaa..a8c5d1e 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -48,6 +48,7 @@ struct mtk_iommu_plat_data {
>         /* HW will use the EMI clock if there isn't the "bclk". */
>         bool                has_bclk;
>         bool                reset_axi;
> +       bool                vld_pa_rng;

I agree with Nicolas that valid_pa_range would be much clearer...
although, even now that I know what it's supposed to mean, I don't get
what it represents. What is this saying?

-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
