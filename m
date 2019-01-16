Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB429C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:37:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8125C20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BzwmaDXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8125C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fUYOGGW8ymSTEXgRi4AUGdSKgSLxditFSFzuXueeN2E=; b=BzwmaDXGYCB9Ju
	lTg+ZwdHFZphJwog7dGC6CIrCZqNabrnty0lzMkytOC21P2fU28oeaWM0miWe7ay0RTdTz4hlnr/X
	4mNlfXeMgQYdWj8sq2DdnHmadoeQpFlhLg7Bw9l8dW5NhP1Hx+0q2hIEqnM4Huph1uDmHbbdqoanw
	PMW54P7wi2mENDdQPhJFh7msmA9maT/aWqHfCS0gNIfAVDQhJAEn8SqWrBDc/7zNxohvIfl5ww4GT
	SXILyxvhK2vjI0m9DebzxbgXT3QsR5nePxJfOZvJWGhN2V6YgaD4rdJIo8h60jaJ6NMokxWsHoXEC
	ILFoUqePaqq5POqbh5zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjepd-0004JW-TA; Wed, 16 Jan 2019 06:37:45 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjepa-0004II-16; Wed, 16 Jan 2019 06:37:43 +0000
X-UUID: 0feebee775644810bbee2520f2626bca-20190115
X-UUID: 0feebee775644810bbee2520f2626bca-20190115
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1919665909; Tue, 15 Jan 2019 22:37:35 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 22:37:33 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 14:37:25 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 14:37:25 +0800
Message-ID: <1547620645.5335.3.camel@mtksdaap41>
Subject: Re: [PATCH 3/9] drm/mediatek: using different flags of clk for HDMI
 phy
From: CK Hu <ck.hu@mediatek.com>
To: chunhui dai <chunhui.dai@mediatek.com>
Date: Wed, 16 Jan 2019 14:37:25 +0800
In-Reply-To: <1546585439-30455-4-git-send-email-chunhui.dai@mediatek.com>
References: <1546585439-30455-1-git-send-email-chunhui.dai@mediatek.com>
 <1546585439-30455-4-git-send-email-chunhui.dai@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_223742_081682_E3B39EA0 
X-CRM114-Status: GOOD (  16.59  )
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
Cc: jamesjj.liao@mediatek.com, Ryder Lee <ryder.lee@mediatek.com>,
 jitao.shi@mediatek.com, bibby.hsieh@mediatek.com, srv_heupstream@mediatek.com,
 Stephen Boyd <sboyd@kernel.org>,
 --to=Michael Turquette <mturquette@baylibre.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 linux-mediatek@lists.infradead.org, Philipp
 Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>,
 Colin Ian King <colin.king@canonical.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Chunhui:

On Fri, 2019-01-04 at 15:03 +0800, chunhui dai wrote:
> The parent rate of hdmi phy had set by DPI driver.

The difference of DPI driver in MT8173 and MT2701 is

static const struct mtk_dpi_conf mt8173_conf = {
	.cal_factor = mt8173_calculate_factor,
	.reg_h_fre_con = 0xe0,
};

static const struct mtk_dpi_conf mt2701_conf = {
	.cal_factor = mt2701_calculate_factor,
	.reg_h_fre_con = 0xb0,
	.edge_sel_en = true,
};

Which one influence the phy setting?

Regards,
CK

> We should not set or change the parent rate of MT2701 hdmi phy,
> as a result we should remove the flags of "CLK_SET_RATE_PARENT"
> from the clock of MT2701 hdmi phy.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 13 +++++--------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  1 +
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c |  1 +
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  1 +
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index 79e737d..c0a9cf5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -109,13 +109,11 @@ static int mtk_hdmi_phy_power_off(struct phy *phy)
>  		return NULL;
>  }
>  
> -static void mtk_hdmi_phy_clk_get_ops(struct mtk_hdmi_phy *hdmi_phy,
> -				     const struct clk_ops **ops)
> +static void mtk_hdmi_phy_clk_get_data(struct mtk_hdmi_phy *hdmi_phy,
> +				     struct clk_init_data *clk_init)
>  {
> -	if (hdmi_phy && hdmi_phy->conf && hdmi_phy->conf->hdmi_phy_clk_ops)
> -		*ops = hdmi_phy->conf->hdmi_phy_clk_ops;
> -	else
> -		dev_err(hdmi_phy->dev, "Failed to get clk ops of phy\n");
> +	clk_init->flags = hdmi_phy->conf->flags;
> +	clk_init->ops = hdmi_phy->conf->hdmi_phy_clk_ops;
>  }
>  
>  static int mtk_hdmi_phy_probe(struct platform_device *pdev)
> @@ -128,7 +126,6 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>  	struct clk_init_data clk_init = {
>  		.num_parents = 1,
>  		.parent_names = (const char * const *)&ref_clk_name,
> -		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	};
>  
>  	struct phy *phy;
> @@ -166,7 +163,7 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>  	hdmi_phy->dev = dev;
>  	hdmi_phy->conf =
>  		(struct mtk_hdmi_phy_conf *)of_device_get_match_data(dev);
> -	mtk_hdmi_phy_clk_get_ops(hdmi_phy, &clk_init.ops);
> +	mtk_hdmi_phy_clk_get_data(hdmi_phy, &clk_init);
>  	hdmi_phy->pll_hw.init = &clk_init;
>  	hdmi_phy->pll = devm_clk_register(dev, &hdmi_phy->pll_hw);
>  	if (IS_ERR(hdmi_phy->pll)) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index fdad8b1..446e2ac 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -21,6 +21,7 @@
>  
>  struct mtk_hdmi_phy_conf {
>  	bool tz_disabled;
> +	unsigned long flags;
>  	const struct clk_ops *hdmi_phy_clk_ops;
>  	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
>  	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index 68b124f..a28a32d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -248,6 +248,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
>  
>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
>  	.tz_disabled = true,
> +	.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_GATE,
>  	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
>  	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
>  	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> index cb23c1e..63dde42 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> @@ -317,6 +317,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
>  }
>  
>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf = {
> +	.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
>  	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
>  	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
