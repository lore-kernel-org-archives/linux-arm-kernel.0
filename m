Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B675C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:20:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182E321738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XE4MTUPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182E321738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/dwstdPB6EW24eAiTqcUAa/6gOHouO7D8agiPOf7sPE=; b=XE4MTUPLfglS2H
	ODAi+HGWM4MHe1+YxUdyiFlGTfnuwepja1PyujWcaW4xF8wJEWj4sjHk+aqrJiDaMxqGDape4hm2I
	CCHexwcnTCvN06GBAanlKpyx55tkR4rtHzoMXoX8R2Pe4Nle/vHBlU5rQ3YxMlXPaW85OMlTTEg/x
	zWs/hPbaXF8AD4NBVCqVBiyGP37dTXVhoHCL4dvaieekb8chhvb+HM70JjOqQLmP3V14CBVmZHVcq
	UuSUkfufrvLT2OBkPei13ginJiUuwtnrgbuyxoV2JrEflB7UFMlIIQ5D+Pu4D2Ar1piO8sAxMo35h
	QaLwyF5J142v4/Jnyobg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqKx-0005nz-4J; Mon, 18 Feb 2019 21:20:27 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqKt-0005nX-7M
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:20:25 +0000
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr
 [86.202.231.219])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E0EDC240005;
 Mon, 18 Feb 2019 21:20:07 +0000 (UTC)
Date: Mon, 18 Feb 2019 22:20:07 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 2/3] clk: at91: sckc: add support for SAM9X60
Message-ID: <20190218212007.GW10129@piout.net>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550146447-1441-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_132023_428495_93DC241D 
X-CRM114-Status: GOOD (  17.16  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 mturquette@baylibre.com, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/02/2019 12:14:32+0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add support for SAM9X60.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/clk/at91/sckc.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> index b7163d3a2269..b3075c51d260 100644
> --- a/drivers/clk/at91/sckc.c
> +++ b/drivers/clk/at91/sckc.c
> @@ -459,6 +459,36 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
>  CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
>  	       of_at91sam9x5_sckc_setup);
>  
> +static const struct clk_slow_offsets at91sam9x60_offsets = {
> +	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
> +	.cr_osc32en = 1,
> +	.cr_osc32byp = 2,
> +	.cr_oscsel = 24,
> +};
> +
> +static void __init of_at91sam9x60_sckc_setup(struct device_node *np)
> +{
> +	struct device_node *childnp;
> +	void (*clk_setup)(struct device_node *np, void __iomem *io,
> +			  const struct clk_slow_offsets *offsets);
> +	const struct of_device_id *clk_id;
> +	void __iomem *regbase = of_iomap(np, 0);
> +
> +	if (!regbase)
> +		return;
> +
> +	for_each_child_of_node(np, childnp) {
> +		clk_id = of_match_node(sckc_clk_ids, childnp);
> +		if (!clk_id)
> +			continue;
> +		clk_setup = clk_id->data;
> +		clk_setup(childnp, regbase, &at91sam9x60_offsets);
> +	}

You actually need to have new bindings. The sam9x60 registration should
look more like the sama5d4 registration. I have a rework for the sam9x5
sckc that I will send this week to have a proper binding (i.e: no
children).

However, there is a fundamental change in the sam9x60, previously, the
sckc had only one output clock. the sam9x60 has both td_slck and
md_slck. Both need to be accessible because they are input to the PMC.

This means you will have to register the sckc with of_clk_hw_onecell_get
as the get callback.

We could still decide to do the same with sam9x5 even if it has only one
output clock.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
