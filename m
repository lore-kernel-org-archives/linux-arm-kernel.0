Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8717C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:56:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C2B20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HsghqGGO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lFnV+tQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C2B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=daIP28tEaPm20E1jgsNMkQGAWlBeuJa/wnwS/37w1Ns=; b=HsghqGGOhSSWgM
	0pVr/hzvZxG+Y9F+Jh+8y4vlHIHH+QbTgpY9ksPEo/P3aZRGKDEWS4EWdIkWqoJ2rjTmhC9UC66Pg
	W5v2fU7n7IaOTgeobFQqbUKDQ9gQmmEqc5RhhO4mPPrgyE6JhPleiG6PGjsgpKkVEvFN2ZHzfpv4Z
	+f2IVVpyPxWJ/VRrnASDgWAcEStLiGwl/S4iD3bIIP4uJFF7QIWAKWz74fC44wgiaIqBmntMqLJjS
	J8OOW1+ePnxwNzZUT3+5rRBSIqrgEk/Dc11jETRuCLLFq5qG4M7IkvYKzdm6f0/Pb6LqcJ0E4aovG
	SfPEF8fTFf7LoQEUcRhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTk1Y-00087P-3s; Mon, 03 Dec 2018 08:56:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTk1U-0007wb-HD; Mon, 03 Dec 2018 08:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R9dbjgBuPRTkT1xSEdtcYVC8zaAABOMYzsphPbrGjg8=; b=lFnV+tQkjslpKSpd8o78s266Uy
 IxboMEfF9O1pwPSPfl0DtzhhM2s1uYXmaQCc/32dqt5qwy8o11+afGjm1fpiujedMJoUKdS8VFhfx
 xtUF7lFL3j6M+UXgjzYinlTUxtGQnv7qY2rSAy/gOzAflQkUC5tjibNQlTlgMYDfuvtq6gj7N9D2x
 ejDM2Ix29Y08mNS0bGfa8o+t27EO/bJLSpjFHJst+j+2wVM3LZjyBkxIzeqoTt9um/Rt8rDPRJPSG
 GaShZBkwO6ffPECKDml1djnJMGO1dvxgrcq16Pm3uf651tGx+asFW79qKOtsCeDg9EZ8KBJ5OLeOY
 kXGwJH+A==;
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjmu-0000xu-Fu; Mon, 03 Dec 2018 08:41:10 +0000
X-UUID: 9b3c6b7c37e04bdb8b117459237d06c5-20181203
X-UUID: 9b3c6b7c37e04bdb8b117459237d06c5-20181203
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1912111233; Mon, 03 Dec 2018 16:40:36 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 3 Dec 2018 16:40:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 16:40:33 +0800
Message-ID: <1543826433.23023.34.camel@mhfsdcap03>
Subject: Re: [PATCH v3 06/15] iommu/mediatek: Add mt8183 IOMMU support
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Mon, 3 Dec 2018 16:40:33 +0800
In-Reply-To: <f8528e80-e816-7901-a56a-581f88b29c83@gmail.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
 <1542422142-30688-7-git-send-email-yong.wu@mediatek.com>
 <f8528e80-e816-7901-a56a-581f88b29c83@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_084109_121940_8A5966D6 
X-CRM114-Status: GOOD (  48.19  )
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
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Arvind Yadav <arvind.yadav.cs@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Matthias,

     Thanks very much for your review.

On Mon, 2018-12-03 at 00:56 +0100, Matthias Brugger wrote:
> 
> On 17/11/2018 03:35, Yong Wu wrote:
> > The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> > the ARM Short-descriptor like mt8173, and most of the HW registers
> > are the same.
> > 
> > Here list main changes in mt8183:
> > 1) mt8183 has only one M4U HW like mt8173.
> 
> That's a change?

I guess I should use "difference" rather than "changes".
(mt8173 and mt8183 have only one M4u HW while mt2712 have two.)

> 
> > 2) mt8183 don't have its "bclk" clock, the M4U use the EMI clock
> > which has already been enabled before kernel.
> > 3) mt8183 can support the dram over 4GB, but it don't call this "4GB
> > mode".
> > 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> > the bit[33:32] in the physical address of the pgtable base, But the
> > standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> > we add a mask.
> > 5) mt8183 HW has a GALS modules, the SMI should add "gals" clock
> > support.
> > 6) the larb-id in smi-common has been remapped. This means the
> > larb-id reported in the mtk_iommu_isr is not the real larb-id, here
> > is the remapping relationship of mt8183:
> 
> This whole list is an indicator that you will need several enhancements to the
> existing code before you can add mt8183 support.
> Please do so in independent patches (e.g. gals modules, remap logic)

OK. I will separate them into 2 new preparing patches.

> Regarding making bclk optional, I think it would be better to set it to NULL for
> mt8183 otherwise the driver will work with a broken device tree on systems that
> actually need the bclk. Same holds for gals0 and gals1.

OK. From your comment below, I will add a "has_bclk" in the platform
data and change code like this:

 if (data->plat_data->has_bclk) {
        data->bclk = devm_clk_get();
        if (IS_ERR(data->bclk))
		return PTR_ERR(data->bclk).
 } else {
 	data->bclk = NULL;
 }

> 
> >                        M4U
> >                         |
> > ---------------------------------------------
> > |               SMI common                  |
> > -0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
> >  |     |     |     |     |     |      |     |
> > larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
> > disp  vdec  img   cam   venc  img    cam
> > As above, larb0 connects with the id 0 in smi-common.
> >           larb1 connects with the id 7 in smi-common.
> >           ...
> > Take a example, if the larb-id reported in the mtk_iommu_isr is 7,
> > actually it is larb1(vdec).
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 38 ++++++++++++++++++++++++++++----------
> >  drivers/iommu/mtk_iommu.h |  5 +++++
> >  drivers/memory/mtk-smi.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 80 insertions(+), 10 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index a243047..e5fd8ee 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -39,11 +39,16 @@ enum mtk_iommu_plat {
> >  	M4U_MT2701,
> >  	M4U_MT2712,
> >  	M4U_MT8173,
> > +	M4U_MT8183,
> >  };
> >  
> >  struct mtk_iommu_plat_data {
> >  	enum mtk_iommu_plat m4u_plat;
> >  	bool has_4gb_mode;
> > +
> > +	/* The larb-id may be remapped in the smi-common. */
> > +	bool larbid_remap_enable;
> > +	unsigned int larbid_remapped[MTK_LARB_NR_MAX];
> 
> Please add new features to the driver as single patches. Don't add this kind of
> things in the patch where you enable a new SoC.

OK.

> 
> >  };
> >  
> >  struct mtk_iommu_domain;
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index e37e54b..979153b 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -59,6 +59,7 @@ struct mtk_smi_larb_gen {
> >  struct mtk_smi {
> >  	struct device			*dev;
> >  	struct clk			*clk_apb, *clk_smi;
> > +	struct clk			*clk_gals0, *clk_gals1;
> >  	struct clk			*clk_async; /*only needed by mt2701*/
> >  	void __iomem			*smi_ao_base;
> >  };
> > @@ -93,8 +94,20 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
> >  	if (ret)
> >  		goto err_disable_apb;
> >  
> > +	ret = clk_prepare_enable(smi->clk_gals0);
> > +	if (ret)
> > +		goto err_disable_smi;
> > +
> > +	ret = clk_prepare_enable(smi->clk_gals1);
> > +	if (ret)
> > +		goto err_disable_gals0;
> > +>  	return 0;
> >  
> > +err_disable_gals0:
> > +	clk_disable_unprepare(smi->clk_gals0);
> > +err_disable_smi:
> > +	clk_disable_unprepare(smi->clk_smi);
> >  err_disable_apb:
> >  	clk_disable_unprepare(smi->clk_apb);
> >  err_put_pm:
> > @@ -104,6 +117,8 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
> >  
> >  static void mtk_smi_disable(const struct mtk_smi *smi)
> >  {
> > +	clk_disable_unprepare(smi->clk_gals1);
> > +	clk_disable_unprepare(smi->clk_gals0);
> >  	clk_disable_unprepare(smi->clk_smi);
> >  	clk_disable_unprepare(smi->clk_apb);
> >  	pm_runtime_put_sync(smi->dev);
> > @@ -262,6 +277,12 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
> >  	.larb_special_mask = BIT(8) | BIT(9), /* bdpsys */
> >  };
> >  
> > +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> > +	.need_larbid = true,
> > +	.config_port = mtk_smi_larb_config_port_gen2_general,
> > +	.larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
> > +};
> > +
> >  static const struct of_device_id mtk_smi_larb_of_ids[] = {
> >  	{
> >  		.compatible = "mediatek,mt8173-smi-larb",
> > @@ -275,6 +296,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
> >  		.compatible = "mediatek,mt2712-smi-larb",
> >  		.data = &mtk_smi_larb_mt2712
> >  	},
> > +	{
> > +		.compatible = "mediatek,mt8183-smi-larb",
> > +		.data = &mtk_smi_larb_mt8183
> > +	},
> >  	{}
> >  };
> >  
> > @@ -304,6 +329,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> >  	larb->smi.clk_smi = devm_clk_get(dev, "smi");
> >  	if (IS_ERR(larb->smi.clk_smi))
> >  		return PTR_ERR(larb->smi.clk_smi);
> > +
> > +	larb->smi.clk_gals0 = devm_clk_get(dev, "gals");> +	if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
> > +		larb->smi.clk_gals0 = NULL;
> > +	else if (IS_ERR(larb->smi.clk_gals0))
> > +		return PTR_ERR(larb->smi.clk_gals0);
> >  	larb->smi.dev = dev;
> >  
> >  	if (larb->larb_gen->need_larbid) {
> > @@ -364,6 +395,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
> >  		.compatible = "mediatek,mt2712-smi-common",
> >  		.data = (void *)MTK_SMI_GEN2
> >  	},
> > +	{
> > +		.compatible = "mediatek,mt8183-smi-common",
> > +		.data = (void *)MTK_SMI_GEN2
> > +	},
> >  	{}
> >  };
> >  
> > @@ -388,6 +423,18 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
> >  	if (IS_ERR(common->clk_smi))
> >  		return PTR_ERR(common->clk_smi);
> >  
> > +	common->clk_gals0 = devm_clk_get(dev, "gals0");
> > +	if (PTR_ERR(common->clk_gals0) == -ENOENT)
> > +		common->clk_gals0 = NULL;
> > +	else if (IS_ERR(common->clk_gals0))
> > +		return PTR_ERR(common->clk_gals0);
> > +
> > +	common->clk_gals1 = devm_clk_get(dev, "gals1");
> > +	if (PTR_ERR(common->clk_gals1) == -ENOENT)
> > +		common->clk_gals1 = NULL;
> > +	else if (IS_ERR(common->clk_gals1))
> > +		return PTR_ERR(common->clk_gals1);
> > +
> 
> I'd prefer to check for clk_gals[01] for SoCs that need this clocks instead of
> making them optional.

OK. like "bclk", I will add a "has_gals" in the SOCs data.

> 
> Regards,
> Matthias



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
