Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E34C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:42:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB02E2192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X6ypGDc9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="SvbiZZcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB02E2192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rb0YRME2fUO36tOwOnOSSI/E7bYpYtZ8xr3yd13OtxQ=; b=X6ypGDc9AyJeuZ
	+nFYeLGdTeQDV01RfcmMrnE/sZfY7ahuG/TRLglIhkzeTeqj6JQl0zDxVZQeV2swylJrAby+8FcBF
	kUbx4Xy1SMSLYC8DSprjUX0fSz5m2iA2uQ5DopvafGT8XPNJ/W/kBBx18Ni2FocXRKGTATYIIQx9K
	Ta2+pKruAWRqwYGYERmA6eREZb9dkMcuO4TFSyCvEY1l05AIbFK7kfZP0xsKR1pqD1OQI0auguGwy
	NkFlMX0J5OJIb4o8wX7Nqbsdvxj5H+V+757tGPWxPGsoRHFQc6Viw/37VSqjBcfKx2xkU5GHgDZw6
	okhIDyoUek4+ThlZm89Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guNpT-0003AP-TE; Thu, 14 Feb 2019 20:41:55 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guNpQ-00039e-L1
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 20:41:54 +0000
Received: by mail-qt1-x842.google.com with SMTP id n32so8433097qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 12:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bfhMe4+CXmiRvcRAWCgmu+lJrINccOKJUvPTFhOLBBs=;
 b=SvbiZZcHAyPGRvhJFgSrREz6TnE+MdP0JuuYGnbGh4+zvhV0RjA7cTtkZ20cYZ82JE
 0VEYrcdvf7yMRaBAvZ+SAXzPt5VxD7cdla0msyXIPFO7pLosJM5MWMeO6MSBwcLS0+s9
 XkorF9y+L7Hx4OBesiPWx1XqaYcxDcE99+MF5nyzGjda+D3tNkZt91zeeOwF9Dbl573e
 B6qqosK3jjCqgYYRlfv17tPbJsYde7HxZSBStrND6l/cHDDimLkhodN+Bblz3gof2ffI
 UvSRYJP6GG7NhFps+mwSKQH8qgEHqnNEC1vUFONx4Xlzl/C8cQiMlYk2ujtHndb2d34m
 89Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bfhMe4+CXmiRvcRAWCgmu+lJrINccOKJUvPTFhOLBBs=;
 b=a8EuwARrdAqRJU2Kl1SHIM956FzHZ7RTWGWVAUmEk/oGYsNH6P7FDSjw4X6J70uAB/
 dlMOfctLUE0KGXBhuoy29vZueNIwxtvILTem/T8ywqSc6p+yqWsvoGmEzyHo4pHmmizK
 7z6ldbcB7nUCA/EG7Xswsi1MAA7qh6KCiLaLZRRYGEoIl5kr07sCqRq7Wy/FmCbLMyQr
 QB90OfuFwrwLBsRQ6uXHl+DxlRow+JuzUQXtAVZZcRM+4MUTOISfMSHtS/9swHsLFbdr
 aZhimmh4OtiS5SYB4G6uhbMEThBuosCFPH1vmPpdtkok5Gwp1BXFeeCJ+Z2AEeAbtCXH
 8KDQ==
X-Gm-Message-State: AHQUAubnOz6edo5QUwT6z9m5f7qcVdoin2Kf+eYf/lJleagKZYlQTTl+
 WffClXHr8j3nzqinQ9IzEBuroA==
X-Google-Smtp-Source: AHgI3Iakb2Tf6qSZJRnBXTFOEa1K25tnKUD4oeuL9riHvph1ITK9hHdsJars1BTxxfnGkCfryhi1Og==
X-Received: by 2002:ac8:22d4:: with SMTP id g20mr4779016qta.50.1550176911125; 
 Thu, 14 Feb 2019 12:41:51 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
 by smtp.gmail.com with ESMTPSA id t123sm1825880qkd.95.2019.02.14.12.41.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 12:41:50 -0800 (PST)
Date: Thu, 14 Feb 2019 15:41:49 -0500
From: Sean Paul <sean@poorly.run>
To: Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH] drm/mediatek: add mt8183 dpi support
Message-ID: <20190214204149.GO114153@art_vandelay>
References: <20190211045059.11821-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211045059.11821-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_124152_732557_63C42D1E 
X-CRM114-Status: GOOD (  19.58  )
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
 dri-devel@lists.freedesktop.org, yingjoe.chen@mediatek.com,
 Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>,
 cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, ck.hu@mediatek.com,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Inki Dae <inki.dae@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org,
 Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Kumar Gala <galak@codeaurora.org>, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 12:50:59PM +0800, Jitao Shi wrote:
> MT8183 sample on rising and falling edge. It can reduce half data io.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 62a9d47df948..610c23334047 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -117,6 +117,7 @@ struct mtk_dpi_conf {
>  	unsigned int (*cal_factor)(int clock);
>  	u32 reg_h_fre_con;
>  	bool edge_sel_en;
> +	bool dual_edge;
>  };
>  
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> @@ -353,6 +354,13 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
>  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
>  }
>  
> +static void mtk_dpi_enable_dual_edge(struct mtk_dpi *dpi)
> +{
> +	mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
> +		     DDR_EN | DDR_4PHASE);
> +	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, EDGE_SEL, EDGE_SEL);
> +}
> +
>  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>  					enum mtk_dpi_out_color_format format)
>  {
> @@ -509,6 +517,8 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	mtk_dpi_config_color_format(dpi, dpi->color_format);
>  	mtk_dpi_config_2n_h_fre(dpi);
>  	mtk_dpi_config_disable_edge(dpi);
> +	if (dpi->conf->dual_edge)
> +		mtk_dpi_enable_dual_edge(dpi);
>  	mtk_dpi_sw_reset(dpi, false);
>  
>  	return 0;
> @@ -671,6 +681,16 @@ static unsigned int mt2701_calculate_factor(int clock)
>  		return 2;
>  }
>  
> +static unsigned int mt8183_calculate_factor(int clock)
> +{
> +	if (clock <= 27000)
> +		return 8;
> +	else if (clock <= 167000)
> +		return 4;
> +	else
> +		return 2;
> +}
> +
>  static const struct mtk_dpi_conf mt8173_conf = {
>  	.cal_factor = mt8173_calculate_factor,
>  	.reg_h_fre_con = 0xe0,
> @@ -682,6 +702,12 @@ static const struct mtk_dpi_conf mt2701_conf = {
>  	.edge_sel_en = true,
>  };
>  
> +static const struct mtk_dpi_conf mt8183_conf = {
> +	.cal_factor = mt8183_calculate_factor,
> +	.reg_h_fre_con = 0xe0,
> +	.dual_edge = true,
> +};
> +
>  static int mtk_dpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -777,6 +803,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
>  	{ .compatible = "mediatek,mt8173-dpi",
>  	  .data = &mt8173_conf,
>  	},
> +	{ .compatible = "mediatek,mt8183-dpi",

Do you need to add this compatible value to the dt binding? If you can do as CK
suggested, maybe you don't need this at all (and mt8183 can use the mt8173
compatible string in the dt).

Sean

> +	  .data = &mt8183_conf,
> +	},
>  	{ },
>  };
>  
> -- 
> 2.12.5
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
