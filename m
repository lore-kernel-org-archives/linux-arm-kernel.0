Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:32:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CB92146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XsZ1x88Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CB92146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GH4EtKWj4fHTVu3PydiWNezLZThiT8sju3J7NB13REo=; b=XsZ1x88Zu/pOEY
	JrH3Jz7AO2BWFKNrt2r0RC/Z5+7V5JjtU2e4JQLfNUaWVQFigfkjiEYk2D10gZkhfpgQSKTq3qY8l
	YjZb0ybc6uA3irfeocFQA3jhn36IzF9ATpWljD5OupQARRxwnwFGFvC8VfDwGcLwKy25KlwXLqN5s
	7ZtglKAP6BVIH6NjqxvIgALQUcGrGUJAiyFmJ6bfd1Q7b4PO9qBjMDgE4D+RRK08e2QKWSIZ9WqA+
	RXJzVBKhYmeJcY4Z9C0EafQFj0kN45QEZLxLkor1SDG5ktokCyK8/H/49XytEREY6RYIFNl5kqSR/
	/iMMxbs+5qddGLaeglhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwLQm-0002to-J6; Wed, 20 Feb 2019 06:32:32 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwLQi-0002sv-Lz; Wed, 20 Feb 2019 06:32:30 +0000
X-UUID: 64df23ee412d493292b2681cc2649aca-20190219
X-UUID: 64df23ee412d493292b2681cc2649aca-20190219
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1794674079; Tue, 19 Feb 2019 22:32:21 -0800
Received: from MTKMBS33DR.mediatek.inc (172.27.6.106) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 22:32:19 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 14:32:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 14:32:16 +0800
Message-ID: <1550644336.14153.8.camel@mtksdaap41>
Subject: Re: [PATCH v1 1/2] drm/mediatek: separate mipi_tx to different file
From: CK Hu <ck.hu@mediatek.com>
To: Jitao Shi <jitao.shi@mediatek.com>
Date: Wed, 20 Feb 2019 14:32:16 +0800
In-Reply-To: <20190219091404.89370-2-jitao.shi@mediatek.com>
References: <20190219091404.89370-1-jitao.shi@mediatek.com>
 <20190219091404.89370-2-jitao.shi@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_223228_726909_F813836F 
X-CRM114-Status: GOOD (  17.29  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, stonea168@163.com,
 dri-devel@lists.freedesktop.org, yingjoe.chen@mediatek.com, Ajay
 Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>,
 cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Inki Dae <inki.dae@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Andy Yan <andy.yan@rock-chips.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, Rahul
 Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Kumar Gala <galak@codeaurora.org>, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Jitao:

On Tue, 2019-02-19 at 17:14 +0800, Jitao Shi wrote:
> Different IC has different mipi_tx setting of dsi.
> This patch separates the mipi_tx hardware relate part for mt8173.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile             |   1 +
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 350 ++----------------
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  51 +++
>  drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c | 290 +++++++++++++++
>  4 files changed, 377 insertions(+), 315 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mipi_tx.h
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
> 

[snip]
>  
> +static void mtk_mipi_tx_clk_get_ops(struct mtk_mipi_tx *mipi_tx,
> +				    const struct clk_ops **ops)
> +{
> +	if (mipi_tx && mipi_tx->driver_data &&
> +	    mipi_tx->driver_data->mipi_tx_clk_ops)
> +		*ops = mipi_tx->driver_data->mipi_tx_clk_ops;
> +	else
> +		dev_err(mipi_tx->dev, "Failed to get clk ops of phy\n");

Any where call mtk_mipi_tx_clk_get_ops() would make sure mipi_tx is not
NULL, so you need not to check mipi_tx. And the checking of driver_data
and mipi_tx_clk_ops looks unnecessary because any one who implement this
driver would never let this happen. So this function just need do the
assignment and therefore this assignment could just do in probe().

Regards,
CK

> +}
> +
>  static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct mtk_mipi_tx *mipi_tx;
>  	struct resource *mem;
> -	struct clk *ref_clk;
>  	const char *ref_clk_name;
>  	struct clk_init_data clk_init = {
> -		.ops = &mtk_mipi_tx_pll_ops,
>  		.num_parents = 1,
>  		.parent_names = (const char * const *)&ref_clk_name,
>  		.flags = CLK_SET_RATE_GATE,
> @@ -408,6 +132,7 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mipi_tx->driver_data = of_device_get_match_data(dev);
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	mipi_tx->regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(mipi_tx->regs)) {
> @@ -416,13 +141,14 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ref_clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(ref_clk)) {
> -		ret = PTR_ERR(ref_clk);
> +	mipi_tx->ref_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(mipi_tx->ref_clk)) {
> +		ret = PTR_ERR(mipi_tx->ref_clk);
>  		dev_err(dev, "Failed to get reference clock: %d\n", ret);
>  		return ret;
>  	}
> -	ref_clk_name = __clk_get_name(ref_clk);
> +
> +	ref_clk_name = __clk_get_name(mipi_tx->ref_clk);
>  
>  	ret = of_property_read_string(dev->of_node, "clock-output-names",
>  				      &clk_init.name);
> @@ -431,6 +157,8 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	mtk_mipi_tx_clk_get_ops(mipi_tx, &clk_init.ops);
> +
>  	mipi_tx->pll_hw.init = &clk_init;
>  	mipi_tx->pll = devm_clk_register(dev, &mipi_tx->pll_hw);
>  	if (IS_ERR(mipi_tx->pll)) {
> @@ -465,20 +193,12 @@ static int mtk_mipi_tx_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct mtk_mipitx_data mt2701_mipitx_data = {
> -	.mppll_preserve = (3 << 8)
> -};
> -
> -static const struct mtk_mipitx_data mt8173_mipitx_data = {
> -	.mppll_preserve = (0 << 8)
> -};
> -
>  static const struct of_device_id mtk_mipi_tx_match[] = {
>  	{ .compatible = "mediatek,mt2701-mipi-tx",
>  	  .data = &mt2701_mipitx_data },
>  	{ .compatible = "mediatek,mt8173-mipi-tx",
>  	  .data = &mt8173_mipitx_data },
> -	{},
> +	{ },
>  };
>  




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
