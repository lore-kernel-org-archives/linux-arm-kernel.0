Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1EFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:47:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4D22075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mKDfSHCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4D22075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hzYZX0ifdYtZwFtz+5bLvSewP1zSbducCyLzrokwP3s=; b=mKDfSHCaD2C0It
	tqHragAN44JOMdYQSWhXJHSYDTZckMeuUdAc9X8e8TtXD+pTl4OgqBoBkaDnvnXNBWsO4LOZZAmlI
	++fE4dNBx60J87S5nmkw+2r3SK67S9Q2JaMRbsENDgzQXGd9LZgL7c6DSQIZMP2UjFTXpNrLvc4/J
	eSTdL7eEygJKu/HDfqXxBkajid5WkobGkWSImLxPRrQMvOCfs3nTONdNZHkbLW+OIgLQYM8jqmfcR
	6B5LaaGV5s5SPYH7+Y+vjVglwDSj6LxOzqKqfgAxaCpQ9fP/OU3W2mUWoBwNjJpGJW8+aKlq/MNoC
	ePJg4PwEyAmW1ND8mrAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghPRP-0007m0-Mr; Thu, 10 Jan 2019 01:47:27 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghPRK-0007l6-Tk; Thu, 10 Jan 2019 01:47:25 +0000
X-UUID: 930d26b3f2c34e27b83b53d4e0f6980b-20190109
X-UUID: 930d26b3f2c34e27b83b53d4e0f6980b-20190109
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 763015884; Wed, 09 Jan 2019 17:47:12 -0800
Received: from MTKMBS06N1.mediatek.inc (172.21.101.129) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 17:47:11 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 09:47:09 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 09:47:09 +0800
Message-ID: <1547084829.27684.8.camel@mtksdaap41>
Subject: Re: [PATCH 1/9] drm/mediatek: recalculate hdmi phy clock of MT2701
 by querying hardware
From: CK Hu <ck.hu@mediatek.com>
To: chunhui dai <chunhui.dai@mediatek.com>
Date: Thu, 10 Jan 2019 09:47:09 +0800
In-Reply-To: <1546585439-30455-2-git-send-email-chunhui.dai@mediatek.com>
References: <1546585439-30455-1-git-send-email-chunhui.dai@mediatek.com>
 <1546585439-30455-2-git-send-email-chunhui.dai@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_174722_974313_E75489F2 
X-CRM114-Status: GOOD (  15.42  )
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
> Recalculate the rate of this clock, by querying hardware.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        |  7 ++--
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  3 +-
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 49 ++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  8 +++++
>  4 files changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index 4ef9c57..79e737d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -29,12 +29,11 @@ long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  	return rate;
>  }
>  
> -unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> -				       unsigned long parent_rate)
> +u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset)
>  {
> -	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	void __iomem *reg = hdmi_phy->regs + offset;
>  
> -	return hdmi_phy->pll_rate;
> +	return readl(reg);

reg is used only once, so

return readl(hdmi_phy->regs + offset);

>  }
>  
>  void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index f39b1fc..fdad8b1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -41,6 +41,7 @@ struct mtk_hdmi_phy {
>  	unsigned int ibias_up;
>  };
>  
> +u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset);
>  void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  			     u32 bits);
>  void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> @@ -50,8 +51,6 @@ void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
>  long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  			     unsigned long *parent_rate);
> -unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> -				       unsigned long parent_rate);
>  
>  extern struct platform_driver mtk_hdmi_phy_driver;
>  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index fcc42dc..b5ed6b7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -153,6 +153,55 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  			  RG_HDMITX_DRV_IBIAS_MASK);
>  	return 0;
>  }
> +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> +				       unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	unsigned long out_rate, val;
> +
> +	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON6)
> +			& RG_HTPLL_PREDIV_MASK) >> RG_HTPLL_PREDIV;
> +	switch (val) {
> +	case 0x00:
> +		out_rate = parent_rate;
> +		break;
> +	case 0x01:
> +		out_rate = parent_rate / 2;
> +		break;
> +	default:
> +		out_rate = parent_rate / 4;
> +		break;

If the val would not be 3, maybe out_rate could be calculate as

out_rate >>= val;

> +	}
> +
> +	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON6)
> +			& RG_HTPLL_FBKDIV_MASK) >> RG_HTPLL_FBKDIV;
> +	out_rate = out_rate * (val + 1) * 2;

out_rate *= (val + 1) * 2;

> +	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON2)
> +			& RG_HDMITX_TX_POSDIV_MASK) >> RG_HDMITX_TX_POSDIV;
> +	switch (val) {
> +	case 0x00:
> +		out_rate = out_rate;
> +		break;
> +	case 0x01:
> +		out_rate = out_rate / 2;
> +		break;
> +	case 0x02:
> +		out_rate = out_rate / 4;
> +		break;
> +	case 0x03:
> +		out_rate = out_rate / 8;
> +		break;
> +	default:
> +		break;
> +	}

out_rate >>= val;

Regards,
CK

> +
> +	if (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON2) & RG_HDMITX_EN_TX_POSDIV)
> +		out_rate = out_rate / 5;
> +
> +	hdmi_phy->pll_rate = out_rate;
> +
> +	return hdmi_phy->pll_rate;
> +}
>  
>  static const struct clk_ops mtk_hdmi_phy_pll_ops = {
>  	.prepare = mtk_hdmi_pll_prepare,
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> index ed5916b..cb23c1e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> @@ -285,6 +285,14 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return 0;
>  }
>  
> +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> +				       unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	return hdmi_phy->pll_rate;
> +}
> +
>  static const struct clk_ops mtk_hdmi_phy_pll_ops = {
>  	.prepare = mtk_hdmi_pll_prepare,
>  	.unprepare = mtk_hdmi_pll_unprepare,



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
