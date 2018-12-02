Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:56:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8212E2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fi5ekj7g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZxuTDV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8212E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mY2ehLrt0RUfPsontU5Ifa6jTYZ4gtUNfxN6WibQd4E=; b=fi5ekj7giaj1Dm
	HIZsOeq6m+A+Jgv648YuEH5bMl68sLayAnISf2PMoVwe+wyv8u6qlptlWmZmD0sJ1+7DN8Kb1vcju
	+k92d+zQX07zoROuyqqDO86yjllw9VMZTFiEpU6KHnv/IdY1hkVfCjWChSLLOmYaCmfmXKrs17eXB
	uCl/jJCRJIAbFAZeiTKxeHncbDM7IJ0a5b1VC/VMDYu630+/9qOpRwm74znpcOArShEM1g8bSGUk5
	TPJVpduaIfwdd2M/fgXTNQKJO8GbYdeZZuW3sLkiCdzHpEFhuV3PK9Vs4ZGlKrWVRCOt6CFEXr5Pz
	ga3vtzRJtLkMDFy0Z6xQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTbbC-0003wv-Sq; Sun, 02 Dec 2018 23:56:30 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTbb9-0003wA-RO; Sun, 02 Dec 2018 23:56:29 +0000
Received: by mail-wm1-x342.google.com with SMTP id a18so3935036wmj.1;
 Sun, 02 Dec 2018 15:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fEgPUVLJnDeRGZFITzLxOXTmCzjpgUWKPQeWh3b46FQ=;
 b=LZxuTDV6d+Rzz/sft+ttGll/smKGaq4apwQRQWb3qDxFa8BngVL8UMs8Te1qN6CqKa
 s8uTZX+mxPyx4+BaKjFRITssXZXyNL+1CnNmtRwvcq04IZQPCkxfqVANCrN+Dve6n2p4
 WFqewNmO56PajouU2PERhfrjsdQxjSO9hgNW9omfw9AZ2Vu2H8HgrzC90gNSm4ngPM3J
 J1qbjR31eo90uc5xC+KAU6gUmwW6WBkZWiecyoe6ePgM/b/vdFYCO582cqZspnONmSG6
 rFrw4cPqyoSB8BGqhvtHZRBchm0JqAXj3A54id4eiE20pwFWs7kr26NRziK3LOOEt9Ma
 VCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fEgPUVLJnDeRGZFITzLxOXTmCzjpgUWKPQeWh3b46FQ=;
 b=i+mYNwYr63V95WR05HBfw3PN4wObA37pkmvIB3wu9oUioGXaIFcSL+p8v/0gHXNXnn
 +qGmL2cyHvrv5iU8DpMnAxE9Vl5+RdZMYA1rluEz01H0YwSVfIDdNwbpLPTvR/5zkZqT
 oVFapa1lblAQV2A8RAi0YaCsv1bNMW4eF5nloHUenlCU23FzKPRKW50hmCE515aD7oKP
 wfEpOyKZbyAAJWVQlH32o7be/0RT3C3ozcMElMIMNxNh3YueuLBAE1+5ddN86Spo7Xiq
 DJQjyzIOw960uhFetP/lzMIe60mY2fDbulUPvvBWWE4VqtbC5XsS9rEJJpdMt9x/YItU
 I9Cg==
X-Gm-Message-State: AA+aEWbjyclPdh+40T2iy0Z9oh7VzooyBSCXAf1LejwVqMOVUAqjn/kx
 0pZb9z0sc1X/QuC8rrw4fwc=
X-Google-Smtp-Source: AFSGD/Uw7KXU/oHy17o0cxwnj0uYsRhVs/VSFop3tXBXJ0w32Jm1UHnCDrn1e+lD1Ftzuyo5NXKcKw==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr6261287wmd.15.1543794975693; 
 Sun, 02 Dec 2018 15:56:15 -0800 (PST)
Received: from ziggy.stardust ([93.176.147.153])
 by smtp.gmail.com with ESMTPSA id w80sm5234991wme.38.2018.12.02.15.56.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 15:56:15 -0800 (PST)
Subject: Re: [PATCH v3 06/15] iommu/mediatek: Add mt8183 IOMMU support
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
 <1542422142-30688-7-git-send-email-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <f8528e80-e816-7901-a56a-581f88b29c83@gmail.com>
Date: Mon, 3 Dec 2018 00:56:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542422142-30688-7-git-send-email-yong.wu@mediatek.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_155627_892267_41BD67DE 
X-CRM114-Status: GOOD (  32.75  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Arvind Yadav <arvind.yadav.cs@gmail.com>, yingjoe.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 17/11/2018 03:35, Yong Wu wrote:
> The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> the ARM Short-descriptor like mt8173, and most of the HW registers
> are the same.
> 
> Here list main changes in mt8183:
> 1) mt8183 has only one M4U HW like mt8173.

That's a change?

> 2) mt8183 don't have its "bclk" clock, the M4U use the EMI clock
> which has already been enabled before kernel.
> 3) mt8183 can support the dram over 4GB, but it don't call this "4GB
> mode".
> 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> the bit[33:32] in the physical address of the pgtable base, But the
> standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> we add a mask.
> 5) mt8183 HW has a GALS modules, the SMI should add "gals" clock
> support.
> 6) the larb-id in smi-common has been remapped. This means the
> larb-id reported in the mtk_iommu_isr is not the real larb-id, here
> is the remapping relationship of mt8183:

This whole list is an indicator that you will need several enhancements to the
existing code before you can add mt8183 support.
Please do so in independent patches (e.g. gals modules, remap logic)
Regarding making bclk optional, I think it would be better to set it to NULL for
mt8183 otherwise the driver will work with a broken device tree on systems that
actually need the bclk. Same holds for gals0 and gals1.

>                        M4U
>                         |
> ---------------------------------------------
> |               SMI common                  |
> -0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
>  |     |     |     |     |     |      |     |
> larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
> disp  vdec  img   cam   venc  img    cam
> As above, larb0 connects with the id 0 in smi-common.
>           larb1 connects with the id 7 in smi-common.
>           ...
> Take a example, if the larb-id reported in the mtk_iommu_isr is 7,
> actually it is larb1(vdec).
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 38 ++++++++++++++++++++++++++++----------
>  drivers/iommu/mtk_iommu.h |  5 +++++
>  drivers/memory/mtk-smi.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+), 10 deletions(-)
> 

[...]

> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index a243047..e5fd8ee 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -39,11 +39,16 @@ enum mtk_iommu_plat {
>  	M4U_MT2701,
>  	M4U_MT2712,
>  	M4U_MT8173,
> +	M4U_MT8183,
>  };
>  
>  struct mtk_iommu_plat_data {
>  	enum mtk_iommu_plat m4u_plat;
>  	bool has_4gb_mode;
> +
> +	/* The larb-id may be remapped in the smi-common. */
> +	bool larbid_remap_enable;
> +	unsigned int larbid_remapped[MTK_LARB_NR_MAX];

Please add new features to the driver as single patches. Don't add this kind of
things in the patch where you enable a new SoC.

>  };
>  
>  struct mtk_iommu_domain;
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e37e54b..979153b 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -59,6 +59,7 @@ struct mtk_smi_larb_gen {
>  struct mtk_smi {
>  	struct device			*dev;
>  	struct clk			*clk_apb, *clk_smi;
> +	struct clk			*clk_gals0, *clk_gals1;
>  	struct clk			*clk_async; /*only needed by mt2701*/
>  	void __iomem			*smi_ao_base;
>  };
> @@ -93,8 +94,20 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>  	if (ret)
>  		goto err_disable_apb;
>  
> +	ret = clk_prepare_enable(smi->clk_gals0);
> +	if (ret)
> +		goto err_disable_smi;
> +
> +	ret = clk_prepare_enable(smi->clk_gals1);
> +	if (ret)
> +		goto err_disable_gals0;
> +>  	return 0;
>  
> +err_disable_gals0:
> +	clk_disable_unprepare(smi->clk_gals0);
> +err_disable_smi:
> +	clk_disable_unprepare(smi->clk_smi);
>  err_disable_apb:
>  	clk_disable_unprepare(smi->clk_apb);
>  err_put_pm:
> @@ -104,6 +117,8 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>  
>  static void mtk_smi_disable(const struct mtk_smi *smi)
>  {
> +	clk_disable_unprepare(smi->clk_gals1);
> +	clk_disable_unprepare(smi->clk_gals0);
>  	clk_disable_unprepare(smi->clk_smi);
>  	clk_disable_unprepare(smi->clk_apb);
>  	pm_runtime_put_sync(smi->dev);
> @@ -262,6 +277,12 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  	.larb_special_mask = BIT(8) | BIT(9), /* bdpsys */
>  };
>  
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> +	.need_larbid = true,
> +	.config_port = mtk_smi_larb_config_port_gen2_general,
> +	.larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
> +};
> +
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
>  	{
>  		.compatible = "mediatek,mt8173-smi-larb",
> @@ -275,6 +296,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  		.compatible = "mediatek,mt2712-smi-larb",
>  		.data = &mtk_smi_larb_mt2712
>  	},
> +	{
> +		.compatible = "mediatek,mt8183-smi-larb",
> +		.data = &mtk_smi_larb_mt8183
> +	},
>  	{}
>  };
>  
> @@ -304,6 +329,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	larb->smi.clk_smi = devm_clk_get(dev, "smi");
>  	if (IS_ERR(larb->smi.clk_smi))
>  		return PTR_ERR(larb->smi.clk_smi);
> +
> +	larb->smi.clk_gals0 = devm_clk_get(dev, "gals");> +	if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
> +		larb->smi.clk_gals0 = NULL;
> +	else if (IS_ERR(larb->smi.clk_gals0))
> +		return PTR_ERR(larb->smi.clk_gals0);
>  	larb->smi.dev = dev;
>  
>  	if (larb->larb_gen->need_larbid) {
> @@ -364,6 +395,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>  		.compatible = "mediatek,mt2712-smi-common",
>  		.data = (void *)MTK_SMI_GEN2
>  	},
> +	{
> +		.compatible = "mediatek,mt8183-smi-common",
> +		.data = (void *)MTK_SMI_GEN2
> +	},
>  	{}
>  };
>  
> @@ -388,6 +423,18 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  	if (IS_ERR(common->clk_smi))
>  		return PTR_ERR(common->clk_smi);
>  
> +	common->clk_gals0 = devm_clk_get(dev, "gals0");
> +	if (PTR_ERR(common->clk_gals0) == -ENOENT)
> +		common->clk_gals0 = NULL;
> +	else if (IS_ERR(common->clk_gals0))
> +		return PTR_ERR(common->clk_gals0);
> +
> +	common->clk_gals1 = devm_clk_get(dev, "gals1");
> +	if (PTR_ERR(common->clk_gals1) == -ENOENT)
> +		common->clk_gals1 = NULL;
> +	else if (IS_ERR(common->clk_gals1))
> +		return PTR_ERR(common->clk_gals1);
> +

I'd prefer to check for clk_gals[01] for SoCs that need this clocks instead of
making them optional.

Regards,
Matthias

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
