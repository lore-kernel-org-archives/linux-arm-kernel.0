Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD6CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:47:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D83021903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sSpRPgJl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ai0vh+Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D83021903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uI9tLT2OUsQsHeI+H4+HXj7NwRGoQwx+1hDP3FWrFzk=; b=sSpRPgJlNigA64
	m2C37zKE2SvMJkBjCAiTKX3FjBiRVZ80QHDw2R2rLV+gG1p9XdjyegzU9gRpmL84tkG8t9U56hwbW
	lEmw9xrtZH6B6JodWk9/SwQKMdc6dMh9kPGh8q7NBLSvteaBa0RDqZgHuzHlx0fNhRxNIQswoOWHf
	faF+oZUbax5Nfg+ThxKDZyAaQNgl/Khpl/d43ic9VHq8EMlM/cHMbYIyAX1euYjl1a+5JmqvS8jxM
	Wozl3VYnageaSTryEg0h3iOoTCOqEKCpi4VBEd9mqLMsKuJl3ocRwINMJ0p1vdnMCKa3LdVP4KjIV
	uYhsEP02Vnx9sGJDsClQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaCil-0000cY-KN; Fri, 21 Dec 2018 04:47:35 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaCih-0000aw-S1
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 04:47:33 +0000
Received: by mail-qt1-x842.google.com with SMTP id y20so4374207qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 20:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9H1D9Nqf+4PUZlmYIEOQ3XEEn2RwgBMkN+9rPJV20eA=;
 b=ai0vh+GpEJszFZjxgawSbcZLVoZRrKEyh4rUIXLaIf13Z+nv9EcKIYuLzY4vVpMGht
 AVp//wl67+V1H1FFvv+pPd0aQFxBfdZfhCBAx5Y2UAtu9H8GNfsCArtCtMxaseUg53U4
 eJO0jaJh31zVFH9enp+l2BKZbWx8p8ugrahPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9H1D9Nqf+4PUZlmYIEOQ3XEEn2RwgBMkN+9rPJV20eA=;
 b=DWF/XQxFe21HEmV6JjCD6sU+3nCiGWihmPdcz35EnAqmqqMMMLokL6CkJK8H3cDqKo
 5kieCDFmATJcxpFBLASdGIA1MZ37WSWIj3DplcTEiVqMwnUxwUFkvCgFYfINyXDBrgOY
 IHz7DV9sct/pbtH7YbKzhDBoncQJYngnPCFA//NAU30THBjY8f/GxA8ZlzjUzy7sacCd
 vFp5XxnoQBqMYemJ3Mqf4+xYvErsksyhpPlMBxfjNe4r/npEcIY7Ld/51tITTPwGEhRp
 LKQaiU1bDcTaawOugn2BlLYpT2YdGhkfM+uaNDqLQA9pfXCjtzpZFY3VJdBVZ2JcohL6
 nglQ==
X-Gm-Message-State: AA+aEWZSYb903b0myvkFiCbSNTR0Zf2Twt/nJ/kSgS8BmnyFmo9plwrD
 G+eWBThjNv1CefaXHSpgff8saxqO5u8nUT+7j9gsvw==
X-Google-Smtp-Source: AFSGD/Uk6uM1l3M/mKJcTj7wq5496QVOwEUnJ3E3Itj92NycddxmrafAKhArHCoj68PE12CqYTNVpBN4ZSYaFOD5FNU=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr972568qts.144.1545367639289; 
 Thu, 20 Dec 2018 20:47:19 -0800 (PST)
MIME-Version: 1.0
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
 <1544258371-4600-14-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1544258371-4600-14-git-send-email-yong.wu@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Fri, 21 Dec 2018 12:47:08 +0800
Message-ID: <CANMq1KA4GLZHcDH31=W==8BTBZOVbRX9HBTJrpPFNQ3rWaM4xg@mail.gmail.com>
Subject: Re: [PATCH v4 13/18] memory: mtk-smi: Add bus_sel for mt8183
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_204731_910778_337B0092 
X-CRM114-Status: GOOD (  20.62  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, arnd@arndb.de,
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 8, 2018 at 4:43 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> mmu0 or mmu1 to balance the bandwidth via the smi-common register
> SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
>
> In mt8183, For better performance, we switch larb1/2/5/7 to enter
> mmu1 while the others still keep enter mmu0.
>
> In mt8173 and mt2712, we don't get the performance issue,
> Keep its default value(0x0), that means all the larbs enter mmu0.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index ee6165e..88eb61a 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -49,6 +49,12 @@
>  #define SMI_LARB_NONSEC_CON(id)        (0x380 + ((id) * 4))
>  #define F_MMU_EN               BIT(0)
>
> +/* SMI COMMON */
> +#define SMI_BUS_SEL                    0x220
> +#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> +/* All are MMU0 defaultly. Only specialize mmu1 here. */
> +#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
> +
>  enum mtk_smi_gen {
>         MTK_SMI_GEN1,
>         MTK_SMI_GEN2
> @@ -57,6 +63,7 @@ enum mtk_smi_gen {
>  struct mtk_smi_common_plat {
>         enum mtk_smi_gen gen;
>         bool             has_gals;
> +       u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
>  };
>
>  struct mtk_smi_larb_gen {
> @@ -72,8 +79,8 @@ struct mtk_smi {
>         struct clk                      *clk_apb, *clk_smi;
>         struct clk                      *clk_gals0, *clk_gals1;
>         struct clk                      *clk_async; /*only needed by mt2701*/
> -       void __iomem                    *smi_ao_base;
> -
> +       void __iomem                    *smi_ao_base; /* only for gen1 */
> +       void __iomem                    *base;        /* only for gen2 */
>         const struct mtk_smi_common_plat *plat;
>  };
>
> @@ -409,6 +416,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
>         .gen      = MTK_SMI_GEN2,
>         .has_gals = true,
> +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
> +                   F_MMU1_LARB(7),

Maybe it's ok for now, but I wonder if this is something that should
be specified in device tree? Maybe different applications will want
different larb split between MMU0 and MMU1?

>  };
>
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
> @@ -481,6 +490,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>                 ret = clk_prepare_enable(common->clk_async);
>                 if (ret)
>                         return ret;
> +       } else {
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +               common->base = devm_ioremap_resource(dev, res);
> +               if (IS_ERR(common->base))
> +                       return PTR_ERR(common->base);
>         }
>         pm_runtime_enable(dev);
>         platform_set_drvdata(pdev, common);
> @@ -496,6 +510,7 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
>  static int __maybe_unused mtk_smi_common_resume(struct device *dev)
>  {
>         struct mtk_smi *common = dev_get_drvdata(dev);
> +       u32 bus_sel = common->plat->bus_sel;
>         int ret;
>
>         ret = mtk_smi_clk_enable(common);
> @@ -503,6 +518,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
>                 dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
>                 return ret;
>         }
> +
> +       if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
> +               writel(bus_sel, common->base + SMI_BUS_SEL);
>         return 0;
>  }
>
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
