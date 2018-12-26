Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D674C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:02:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AAD214D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MOQeCHIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AAD214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8I4WinUtt+AjLB70yc1BjMKrp567jQvVF5p5YOlGzyc=; b=MOQeCHIivWLoX1
	zoTQCpBU8bWphR7NyelvE1RmFwcpGAZNGwzEK3LpRxGuSOsTcfqiT2qFChVhcd24oksoCYWY/vhsD
	o16WF5RASF/PygQcTRedTQqkniuE7U3yXAb2c4qZHwq7UlWjTjI4t9Ohu9fuUPZp7VV87aH7q8+4L
	/y6cwcVgnQN9vIXJXKYBS1M6Fv+tE50MNOQQwsgpekDyeCGPS2TI3Vyo4siJF41Rf9+yNqdJ6n/6L
	OaqAQjT+gTprbUpc/VItL7b6FciM6HLzB3T8hW1rj++VE2hzTnoEO2jq20N2N+CBqdTpBatumXAUz
	gXoTV9NnfMasyfoU2FVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc2GX-0002Gs-Br; Wed, 26 Dec 2018 06:02:01 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc2GQ-0002G5-RG; Wed, 26 Dec 2018 06:01:59 +0000
X-UUID: c410a71c6ef7489f876e7bf218a04686-20181226
X-UUID: c410a71c6ef7489f876e7bf218a04686-20181226
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 179064635; Wed, 26 Dec 2018 14:01:36 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Dec 2018 14:01:32 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Dec 2018 14:01:32 +0800
Message-ID: <1545804089.14496.30.camel@mtksdaap41>
Subject: Re: [PATCH 06/18] drm/mediatek: add mmsys private data for ddp path
 config
From: CK Hu <ck.hu@mediatek.com>
To: Yongqiang Niu <yongqiang.niu@mediatek.com>
Date: Wed, 26 Dec 2018 14:01:29 +0800
In-Reply-To: <1545638931-24938-7-git-send-email-yongqiang.niu@mediatek.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
 <1545638931-24938-7-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_220155_677144_5EFB14ED 
X-CRM114-Status: GOOD (  19.12  )
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
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Yongqiang:

On Mon, 2018-12-24 at 16:08 +0800, Yongqiang Niu wrote:
> This patch add mmsys private data for ddp path config

Describe WHY do this.

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |   4 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 102 ++++++++++++++++++++++++++------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  10 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  11 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   4 ++
>  5 files changed, 112 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 92ecb9b..a5af4be 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -50,6 +50,7 @@ struct mtk_drm_crtc {
>  	bool				pending_planes;
>  
>  	void __iomem			*config_regs;
> +	const struct mtk_mmsys_reg_data *mmsys_reg_data;
>  	struct mtk_disp_mutex		*mutex;
>  	unsigned int			ddp_comp_nr;
>  	struct mtk_ddp_comp		**ddp_comp;
> @@ -271,6 +272,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>  	DRM_DEBUG_DRIVER("mediatek_ddp_ddp_path_setup\n");
>  	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
>  		mtk_ddp_add_comp_to_path(mtk_crtc->config_regs,
> +					 mtk_crtc->mmsys_reg_data,
>  					 mtk_crtc->ddp_comp[i]->id,
>  					 mtk_crtc->ddp_comp[i + 1]->id);
>  		mtk_disp_mutex_add_comp(mtk_crtc->mutex,
> @@ -319,6 +321,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
>  	mtk_disp_mutex_disable(mtk_crtc->mutex);
>  	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
>  		mtk_ddp_remove_comp_from_path(mtk_crtc->config_regs,
> +					      mtk_crtc->mmsys_reg_data,
>  					      mtk_crtc->ddp_comp[i]->id,
>  					      mtk_crtc->ddp_comp[i + 1]->id);
>  		mtk_disp_mutex_remove_comp(mtk_crtc->mutex,
> @@ -561,6 +564,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  		return -ENOMEM;
>  
>  	mtk_crtc->config_regs = priv->config_regs;
> +	mtk_crtc->mmsys_reg_data = priv->reg_data;
>  	mtk_crtc->ddp_comp_nr = path_len;
>  	mtk_crtc->ddp_comp = devm_kmalloc_array(dev, mtk_crtc->ddp_comp_nr,
>  						sizeof(*mtk_crtc->ddp_comp),
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 60cfde7..4be3c11 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -145,6 +145,17 @@
>  #define DPI_SEL_IN_BLS			0x0
>  #define DSI_SEL_IN_RDMA			0x1
>  
> +#define DISP_REG_OVL0_MOUT_EN(data)		((data)->ovl0_mout_en)
> +#define DISP_REG_DPI0_SEL_IN(data)		((data)->dpi0_sel_in)
> +#define DISP_REG_DPI0_SEL_IN_RDMA1(data)	((data)->dpi0_sel_in_rdma1)
> +#define DISP_REG_DSI0_SEL_IN(data)		((data)->dsi0_sel_in)
> +#define DISP_REG_DSI0_SEL_IN_RDMA1(data)	((data)->dsi0_sel_in_rdma1)
> +#define DISP_REG_RDMA0_SOUT_SEL_IN(data)	((data)->rdma0_sout_sel_in)
> +#define DISP_REG_RDMA0_SOUT_COLOR0(data)	((data)->rdma0_sout_color0)
> +#define DISP_REG_RDMA1_SOUT_SEL_IN(data)	((data)->rdma1_sout_sel_in)
> +#define DISP_REG_RDMA1_SOUT_DPI0(data)		((data)->rdma1_sout_dpi0)
> +#define DISP_REG_RDMA1_SOUT_DSI0(data)		((data)->rdma1_sout_dsi0)
> +
>  struct mtk_disp_mutex {
>  	int id;
>  	bool claimed;
> @@ -176,6 +187,19 @@ struct mtk_ddp {
>  	const struct mtk_ddp_data	*data;
>  };
>  
> +struct mtk_mmsys_reg_data {
> +	unsigned int ovl0_mout_en;
> +	unsigned int rdma0_sout_sel_in;
> +	unsigned int rdma0_sout_color0;
> +	unsigned int rdma1_sout_sel_in;
> +	unsigned int rdma1_sout_dpi0;
> +	unsigned int rdma1_sout_dsi0;
> +	unsigned int dpi0_sel_in;
> +	unsigned int dpi0_sel_in_rdma1;
> +	unsigned int dsi0_sel_in;
> +	unsigned int dsi0_sel_in_rdma1;

I would like use 'u32' for these variables.

> +};
> +
>  static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_BLS] = MT2701_MUTEX_MOD_DISP_BLS,
>  	[DDP_COMPONENT_COLOR0] = MT2701_MUTEX_MOD_DISP_COLOR,
> @@ -268,17 +292,34 @@ struct mtk_ddp {
>  	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
>  };
>  
> -static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> +const struct mtk_mmsys_reg_data mt2701_mmsys_reg_data = {
> +	.ovl0_mout_en = DISP_REG_CONFIG_DISP_OVL_MOUT_EN,
> +	.dsi0_sel_in = DISP_REG_CONFIG_DSI_SEL,
> +	.dsi0_sel_in_rdma1 = DSI_SEL_IN_RDMA,
> +};
> +
> +const struct mtk_mmsys_reg_data mt8173_mmsys_reg_data = {
> +	.ovl0_mout_en = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
> +	.rdma1_sout_sel_in = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
> +	.rdma1_sout_dpi0 = RDMA1_SOUT_DPI0,
> +	.dpi0_sel_in = DISP_REG_CONFIG_DPI_SEL_IN,
> +	.dpi0_sel_in_rdma1 = DPI0_SEL_IN_RDMA1,
> +	.dsi0_sel_in = DISP_REG_CONFIG_DSIE_SEL_IN,
> +	.dsi0_sel_in_rdma1 = DSI0_SEL_IN_RDMA1,
> +};
> +
> +static unsigned int mtk_ddp_mout_en(const struct mtk_mmsys_reg_data *data,
> +				    enum mtk_ddp_comp_id cur,
>  				    enum mtk_ddp_comp_id next,
>  				    unsigned int *addr)
>  {
>  	unsigned int value;
>  
>  	if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
> -		*addr = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN;
> +		*addr = DISP_REG_OVL0_MOUT_EN(data);
>  		value = OVL0_MOUT_EN_COLOR0;
>  	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
> -		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
> +		*addr = DISP_REG_OVL0_MOUT_EN(data);
>  		value = OVL_MOUT_EN_RDMA;
>  	} else if (cur == DDP_COMPONENT_OD0 && next == DDP_COMPONENT_RDMA0) {
>  		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
> @@ -302,7 +343,8 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	return value;
>  }
>  
> -static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
> +static unsigned int mtk_ddp_sel_in(const struct mtk_mmsys_reg_data *data,
> +				   enum mtk_ddp_comp_id cur,
>  				   enum mtk_ddp_comp_id next,
>  				   unsigned int *addr)
>  {
> @@ -312,14 +354,14 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>  		*addr = DISP_REG_CONFIG_DISP_COLOR0_SEL_IN;
>  		value = COLOR0_SEL_IN_OVL0;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> -		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
> -		value = DPI0_SEL_IN_RDMA1;
> +		*addr = DISP_REG_DPI0_SEL_IN(data);
> +		value = DISP_REG_DPI0_SEL_IN_RDMA1(data);
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
>  		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
>  		value = DPI1_SEL_IN_RDMA1;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
> -		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
> -		value = DSI0_SEL_IN_RDMA1;
> +		*addr = DISP_REG_DSI0_SEL_IN(data);
> +		value = DISP_REG_DSI0_SEL_IN_RDMA1(data);
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
>  		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
>  		value = DSI1_SEL_IN_RDMA1;
> @@ -360,7 +402,7 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>  	return value;
>  }
>  
> -static unsigned int mtk_ddp_sout_sel(void __iomem *config_regs,
> +static unsigned int mtk_ddp_sout_sel(const struct mtk_mmsys_reg_data *data,
>  				     enum mtk_ddp_comp_id cur,
>  				     enum mtk_ddp_comp_id next,
>  				     unsigned int *addr)
> @@ -373,9 +415,6 @@ static unsigned int mtk_ddp_sout_sel(void __iomem *config_regs,
>  	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_OUT_SEL;
>  		value = BLS_TO_DPI_RDMA1_TO_DSI;
> -	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
> -		*addr = DISP_REG_CONFIG_DSI_SEL;
> -		value = DSI_SEL_IN_RDMA;
>  	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
>  		value = RDMA0_SOUT_DPI0;
> @@ -401,8 +440,8 @@ static unsigned int mtk_ddp_sout_sel(void __iomem *config_regs,
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
>  		value = RDMA1_SOUT_DSI3;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> -		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> -		value = RDMA1_SOUT_DPI0;
> +		*addr = DISP_REG_RDMA1_SOUT_SEL_IN(data);
> +		value = DISP_REG_RDMA1_SOUT_DPI0(data);
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
>  		value = RDMA1_SOUT_DPI1;
> @@ -429,22 +468,23 @@ static unsigned int mtk_ddp_sout_sel(void __iomem *config_regs,
>  }
>  
>  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> +			      const struct mtk_mmsys_reg_data *reg_data,
>  			      enum mtk_ddp_comp_id cur,
>  			      enum mtk_ddp_comp_id next)
>  {
>  	unsigned int addr, value, reg;
>  
> -	value = mtk_ddp_mout_en(cur, next, &addr);
> +	value = mtk_ddp_mout_en(reg_data, cur, next, &addr);
>  	if (value) {
>  		reg = readl_relaxed(config_regs + addr) | value;
>  		writel_relaxed(reg, config_regs + addr);
>  	}
>  
> -	value = mtk_ddp_sout_sel(cur, next, &addr);
> +	value = mtk_ddp_sout_sel(reg_data, cur, next, &addr);
>  	if (value)
>  		writel_relaxed(value, config_regs + addr);
>  
> -	value = mtk_ddp_sel_in(cur, next, &addr);
> +	value = mtk_ddp_sel_in(reg_data, cur, next, &addr);
>  	if (value) {
>  		reg = readl_relaxed(config_regs + addr) | value;
>  		writel_relaxed(reg, config_regs + addr);
> @@ -452,24 +492,48 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
>  }
>  
>  void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
> +				   const struct mtk_mmsys_reg_data *reg_data,
>  				   enum mtk_ddp_comp_id cur,
>  				   enum mtk_ddp_comp_id next)
>  {
>  	unsigned int addr, value, reg;
>  
> -	value = mtk_ddp_mout_en(cur, next, &addr);
> +	value = mtk_ddp_mout_en(reg_data, cur, next, &addr);
>  	if (value) {
>  		reg = readl_relaxed(config_regs + addr) & ~value;
>  		writel_relaxed(reg, config_regs + addr);
>  	}
>  
> -	value = mtk_ddp_sel_in(cur, next, &addr);
> +	value = mtk_ddp_sel_in(reg_data, cur, next, &addr);
>  	if (value) {
>  		reg = readl_relaxed(config_regs + addr) & ~value;
>  		writel_relaxed(reg, config_regs + addr);
>  	}
>  }
>  
> +const struct mtk_mmsys_reg_data *mtk_ddp_get_mmsys_data(enum mtk_mmsys_id id)
> +{
> +	const struct mtk_mmsys_reg_data *data = NULL;
> +
> +	switch (id) {
> +	case MMSYS_MT2701:
> +		data = &mt2701_mmsys_reg_data;
> +		break;
> +	case MMSYS_MT2712:
> +		data = &mt8173_mmsys_reg_data;
> +		break;
> +	case MMSYS_MT8173:
> +		data = &mt8173_mmsys_reg_data;
> +		break;
> +	default:
> +		pr_info("mtk drm not support mmsys id %d\n",
> +			id);
> +		break;
> +	}
> +
> +	return data;
> +}
> +
>  struct mtk_disp_mutex *mtk_disp_mutex_get(struct device *dev, unsigned int id)
>  {
>  	struct mtk_ddp *ddp = dev_get_drvdata(dev);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
> index f9a7991..ed2b702 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
> @@ -19,11 +19,21 @@
>  struct regmap;
>  struct device;
>  struct mtk_disp_mutex;
> +struct mtk_mmsys_reg_data;
> +enum mtk_mmsys_id {
> +	MMSYS_MT2701,
> +	MMSYS_MT2712,
> +	MMSYS_MT8173,
> +	MMSYS_MAX,
> +};
>  
> +const struct mtk_mmsys_reg_data *mtk_ddp_get_mmsys_data(enum mtk_mmsys_id id);
>  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> +			      const struct mtk_mmsys_reg_data *reg_data,
>  			      enum mtk_ddp_comp_id cur,
>  			      enum mtk_ddp_comp_id next);
>  void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
> +				   const struct mtk_mmsys_reg_data *reg_data,
>  				   enum mtk_ddp_comp_id cur,
>  				   enum mtk_ddp_comp_id next);
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 6422e99..be6b142 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -196,6 +196,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
>  	.ext_path = mt2701_mtk_ddp_ext,
>  	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
> +	.mmsys_id = MMSYS_MT2701,
>  	.shadow_register = true,
>  };
>  
> @@ -206,6 +207,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
>  	.third_path = mt2712_mtk_ddp_third,
>  	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
> +	.mmsys_id = MMSYS_MT2712,
>  };
>  
>  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> @@ -213,6 +215,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
>  	.ext_path = mt8173_mtk_ddp_ext,
>  	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
> +	.mmsys_id = MMSYS_MT8173,
>  };
>  
>  static int mtk_drm_kms_init(struct drm_device *drm)
> @@ -461,6 +464,14 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  	INIT_WORK(&private->commit.work, mtk_atomic_work);
>  	private->data = of_device_get_match_data(dev);
>  
> +	private->reg_data = mtk_ddp_get_mmsys_data(private->data->mmsys_id);
> +	if (IS_ERR(private->reg_data)) {
> +		ret = PTR_ERR(private->config_regs);
> +		pr_info("Failed to get mmsys register data: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	private->config_regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(private->config_regs)) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index ecc00ca..11de7f8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -15,6 +15,7 @@
>  #define MTK_DRM_DRV_H
>  
>  #include <linux/io.h>
> +#include "mtk_drm_ddp.h"
>  #include "mtk_drm_ddp_comp.h"
>  
>  #define MAX_CRTC	3
> @@ -36,6 +37,8 @@ struct mtk_mmsys_driver_data {
>  	const enum mtk_ddp_comp_id *third_path;
>  	unsigned int third_len;
>  
> +	enum mtk_mmsys_id mmsys_id;
> +
>  	bool shadow_register;
>  };
>  
> @@ -48,6 +51,7 @@ struct mtk_drm_private {
>  	struct device_node *mutex_node;
>  	struct device *mutex_dev;
>  	void __iomem *config_regs;
> +	const struct mtk_mmsys_reg_data *reg_data;

Why not move reg_data into data? Both could be got by
of_device_get_match_data().

Regards,
CK

>  	struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
>  	struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
>  	const struct mtk_mmsys_driver_data *data;



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
