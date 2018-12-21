Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD0EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:44:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FE221903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m0B5GWlj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lVkpBMj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FE221903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1ozGyeTaY/92CdLqGNXh+KwM12WzgIB+kNqm+0LuMsQ=; b=m0B5GWljoyfZHK
	A6C7nmHRg8FgrKwkdNfrqGGun7TTRldQ8elpU38w2P1zwtxMu283K4W+6qO9OrN5VxWpxNcqnWE+0
	mgoy9Zl0cXRpEF+fuVojJ4wYAlSgy85JGR6zUCl/H0Nj4ZjUZTrhswbSw04iDz9PFNKxPf3iEQXEo
	a11YWsCIAjD1PC/GLorc53CB1WGofplKzIuRtaMDLRs5GkSkUYfGQ3shVYRiOBvaJpDU3jY8LZyrR
	e0Roj8FICNeZ1JloPJEm0i8Imm3N6j8fsbQFu9bO6+ltvV1063holNlr4lMaVyG5yv/SL9i0bUdGg
	/FCuEvmuWsvoGC6lBvVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaCfM-0007N5-F1; Fri, 21 Dec 2018 04:44:04 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaCfJ-0007LX-1x
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 04:44:02 +0000
Received: by mail-qk1-x742.google.com with SMTP id y16so2384228qki.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 20:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dJtoVP/WBM+yokpO/MfpqAes+qj0HoWyz9Dh/VqCCqg=;
 b=lVkpBMj6TP1absix+Ja1Gh494aEv++FxtRtXgR1BqtWFdKVAYmHKd/0LwmdX3MG3mu
 Js+8pLCFsjRlspJ6qnK6bY0ET0PiiSRdKh89v1oTyhCdF45onwqoANDPGQZOD2BwPZHe
 ZybunO3P2UkrigkZnWsbPmTCbtskhh4ZNwxNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dJtoVP/WBM+yokpO/MfpqAes+qj0HoWyz9Dh/VqCCqg=;
 b=PEfjO5+2lubFnbuXVMBxXuKmocHOQWTyawVJcGPJiohnI3ospbjllxMZEeOghOPBYm
 8yElqQyeeOG1uQ9zZSBy06kepVatHinfCxiPCqVWsVpw3XIqKcSwZ9KF5flOa3DcJmYi
 QplulSS5AhR1BpgQq6sj/r16jmK4QXckvsXxEQbRMF6dV42q6AX2TgkDAK5NQuXJzgaZ
 jx5y9JHUkWZr6aQPLFoyGLoCMxmgb92NLiE3tZZY7rOB4fJGfAzHVOZHbGBp7ETLGG6C
 6UaRNQdjUpV9EOcEjmHQh+bmCQItSWfLY5+Wz4SU2y/ZTEDxYDM3jKTxNqB7MfEjIkF7
 aTMg==
X-Gm-Message-State: AJcUukdmSraoqC48RUY3wBGEgfDnhkuI516dPEBBcpS5dozXvsRNlRuv
 dn18HuZpiAc3GwSzWPH02yDBs1EcU9F4jdBiDgPCpA==
X-Google-Smtp-Source: ALg8bN5OyqeTBsiZJakuN+YDKNjc3jx9FFFM+k7iUwl4HzWlg7tZkjwrnEzkpDErEvDmd3QPS4hzrOe7JWL0CIcwuhg=
X-Received: by 2002:a37:7885:: with SMTP id t127mr899092qkc.323.1545367428691; 
 Thu, 20 Dec 2018 20:43:48 -0800 (PST)
MIME-Version: 1.0
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
 <1544258371-4600-11-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1544258371-4600-11-git-send-email-yong.wu@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Fri, 21 Dec 2018 12:43:37 +0800
Message-ID: <CANMq1KBMWM8BhMDJo1paVbToibsZGYVOCWBOua81w7fnTCO-bw@mail.gmail.com>
Subject: Re: [PATCH v4 10/18] iommu/mediatek: Add mt8183 IOMMU support
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_204401_368670_E9695F2D 
X-CRM114-Status: GOOD (  28.76  )
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

On Sat, Dec 8, 2018 at 4:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
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
> 6) the larb-id in smi-common is remapped. M4U should enable
> larbid_remapped support.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 31 ++++++++++++++++++++++---------
>  drivers/iommu/mtk_iommu.h |  1 +
>  drivers/memory/mtk-smi.c  | 19 +++++++++++++++++++
>  3 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 8ab3b69..d91a554 100644
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
> @@ -54,7 +55,7 @@
>  #define REG_MMU_CTRL_REG                       0x110
>  #define F_MMU_PREFETCH_RT_REPLACE_MOD          BIT(4)
>  #define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
> -       ((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
> +       ((data)->plat_data->m4u_plat == M4U_MT8173 ? 5 : 4)

Should the shift value be a member of plat_data instead?

>  /* It's named by F_MMU_TF_PROT_SEL in mt2712. */
>  #define F_MMU_TF_PROTECT_SEL(prot, data) \
>         (((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
> @@ -347,7 +348,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>         /* Update the pgtable base address register of the M4U HW */
>         if (!data->m4u_dom) {
>                 data->m4u_dom = dom;
> -               writel(dom->cfg.arm_v7s_cfg.ttbr[0],
> +               writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
>                        data->base + REG_MMU_PT_BASE_ADDR);
>         }
>
> @@ -510,6 +511,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>
>  static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  {
> +       enum mtk_iommu_plat m4u_plat = data->plat_data->m4u_plat;
>         u32 regval;
>         int ret;
>
> @@ -520,7 +522,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>         }
>
>         regval = F_MMU_TF_PROTECT_SEL(2, data);
> -       if (data->plat_data->m4u_plat == M4U_MT8173)
> +       if (m4u_plat == M4U_MT8173)
>                 regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
>         writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
>
> @@ -541,14 +543,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>                 F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
>         writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
>
> -       if (data->plat_data->m4u_plat == M4U_MT8173)
> +       if (m4u_plat == M4U_MT8173)
>                 regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
>         else
>                 regval = lower_32_bits(data->protect_base) |
>                          upper_32_bits(data->protect_base);
>         writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
>
> -       if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> +       if (data->enable_4GB && m4u_plat == M4U_MT2712) {
>                 /*
>                  * If 4GB mode is enabled, the validate PA range is from
>                  * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> @@ -558,8 +560,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>         }
>         writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>
> -       /* It's MISC control register whose default value is ok except mt8173.*/
> -       if (data->plat_data->m4u_plat == M4U_MT8173)
> +       /*
> +        * It's MISC control register whose default value is ok
> +        * except mt8173 and mt8183.
> +        */
> +       if (m4u_plat == M4U_MT8173 || m4u_plat == M4U_MT8183)

Again, should this be a field in plat_data?

>                 writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
>
>         if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> @@ -713,6 +718,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  {
>         struct mtk_iommu_data *data = dev_get_drvdata(dev);
>         struct mtk_iommu_suspend_reg *reg = &data->reg;
> +       struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
>         void __iomem *base = data->base;
>         int ret;
>
> @@ -728,8 +734,8 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>         writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
>         writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
>         writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
> -       if (data->m4u_dom)
> -               writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
> +       if (m4u_dom)
> +               writel(m4u_dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
>                        base + REG_MMU_PT_BASE_ADDR);
>         return 0;
>  }
> @@ -750,9 +756,16 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>         .has_bclk     = true,
>  };
>
> +static const struct mtk_iommu_plat_data mt8183_data = {
> +       .m4u_plat            = M4U_MT8183,
> +       .larbid_remap_enable = true,
> +       .larbid_remapped     = {0, 4, 5, 6, 7, 2, 3, 1},
> +};
> +
>  static const struct of_device_id mtk_iommu_of_ids[] = {
>         { .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
>         { .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
> +       { .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
>         {}
>  };
>
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 3877050..6385dec 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -39,6 +39,7 @@ enum mtk_iommu_plat {
>         M4U_MT2701,
>         M4U_MT2712,
>         M4U_MT8173,
> +       M4U_MT8183,
>  };
>
>  struct mtk_iommu_plat_data {
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 3720c77..bced778 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -285,6 +285,12 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>         .larb_special_mask = BIT(8) | BIT(9),          /* bdpsys */
>  };
>
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> +       .has_gals          = true,
> +       .config_port       = mtk_smi_larb_config_port_gen2_general,
> +       .larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
> +};
> +
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
>         {
>                 .compatible = "mediatek,mt8173-smi-larb",
> @@ -298,6 +304,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>                 .compatible = "mediatek,mt2712-smi-larb",
>                 .data = &mtk_smi_larb_mt2712
>         },
> +       {
> +               .compatible = "mediatek,mt8183-smi-larb",
> +               .data = &mtk_smi_larb_mt8183
> +       },
>         {}
>  };
>
> @@ -391,6 +401,11 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>         .gen = MTK_SMI_GEN2,
>  };
>
> +static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
> +       .gen      = MTK_SMI_GEN2,
> +       .has_gals = true,
> +};
> +
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
>         {
>                 .compatible = "mediatek,mt8173-smi-common",
> @@ -404,6 +419,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>                 .compatible = "mediatek,mt2712-smi-common",
>                 .data = &mtk_smi_common_gen2,
>         },
> +       {
> +               .compatible = "mediatek,mt8183-smi-common",
> +               .data = &mtk_smi_common_mt8183,
> +       },
>         {}
>  };
>
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
