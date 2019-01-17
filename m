Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C57C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:28:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DE720851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bLlQcXAs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NP0si3ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DE720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L8bBKYQIwH+b90MN4dYoq8YCaX/OHNetQrGWvONQa00=; b=bLlQcXAsfgg9v5
	XQ5PULl7sIwRrWr2jj03QSSz3N8CvCnZIzcSlbD4H7emgCdMf3rMpbqTKPQ2wykzf4bBZtPPk8e23
	y5fledbGZ1Ta/B2djEk1F4hbbE1Cc3iHWfIoJ+D2K87qkD7PNhHGGdR1BMrQuVO7DpuZ/hZKznmio
	yvJbLXoQvi3oG9Ibsrw1FDnhcTFGY+6Zsjhxg8mLh8OxFiu03+Q7LMMKBjTalN579q9j4wsAAGvUz
	X2ep4Z4WXUqwQfRAm9UiNJRM4xSZj4jqlwCN991ojVSUoBpHaSJKAfIyLlu32n3l5Lpgk/RIOWwHA
	xktJdIZnwHQq7l4c1TLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk1AE-0007gJ-Ee; Thu, 17 Jan 2019 06:28:30 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk1A9-0007fu-Um
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:28:27 +0000
Received: by mail-pl1-x643.google.com with SMTP id u6so4231778plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mCTsp1TTN24owrN3MkvyzPcw6V8d8yP34TwiCxlzb8c=;
 b=NP0si3icH+q949vp9PsZlav441VAes3Iasb9e4lrP2xKcjFSv+lD5enZ3ImNJRIg0t
 CWlEtH81nkckNERuyHwAjjRkMuqI3ZBPy0sRTv+3QKhdBfEwJPsMV4eIeb6Let2qgYUW
 ucQI2iMJfKSQ9OPf4jtd3543DnAh+mqShy4Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mCTsp1TTN24owrN3MkvyzPcw6V8d8yP34TwiCxlzb8c=;
 b=RKdntvTrAAkrFmJmIBlPig6mHAso9uYgYqR0GuhwzwJCLqSTewjSC9DKKvGYE3rvqx
 wtvjFo/lTbSAZoUduHz+1STulANDvRXZwrcKKFnjrXCmsU9Ci29H01KVER48/PwvUj23
 ykrZ23F+r1RRcXpQXFgs64LS0VxcWaO8DRVD3GgwNYc6qNOtWHoOM/wg0jBKW1/feia4
 srqE68O53alYPEfzx8pdnfrD3zQ0HuLPDLUxkRWCYPCRzC+QaC1gmqdjD/uIUl+tll89
 tNa28MyKWqkD8iTiqTeRPkcv9rwthKu6FR+HRlOPuSNWzZX4eVaP8esYfpJV3r7katgc
 hZMg==
X-Gm-Message-State: AJcUukdBNclBXt6c1nrFLX29riA4UDQBxqaS4elnaPloqy+B71S2f5lG
 FwciS6J4uyJ1nQX+LImkt+DUzQ==
X-Google-Smtp-Source: ALg8bN6S2LSSTkwbXEfiV7zbbXX4x9A+nE0YeIh5T7O3Cy3pZEJW9a6Jh4dS+fn7V4CINpZ1PZX4CA==
X-Received: by 2002:a17:902:24d:: with SMTP id
 71mr13353580plc.225.1547706505216; 
 Wed, 16 Jan 2019 22:28:25 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id y29sm755820pga.59.2019.01.16.22.28.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 22:28:24 -0800 (PST)
Date: Wed, 16 Jan 2019 22:27:44 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 06/13] clk: qcom: hfpll: get parent clock names from DT
Message-ID: <20190117062744.GC25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-7-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545039990-19984-7-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_222825_997750_B7D602CD 
X-CRM114-Status: GOOD (  17.28  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, david.brown@linaro.org, linux-clk@vger.kernel.org,
 jassisinghbrar@gmail.com, jagan@amarulasolutions.com, andy.gross@linaro.org,
 sibis@codeaurora.org, devicetree@vger.kernel.org, arnd@arndb.de,
 niklas.cassel@linaro.org, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, olof@lixom.net, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> Allow accessing the parent clock name required for the driver
> operation using the device tree node.
> 
> This permits extending the driver to other platforms without having to
> modify its source code.
> 
> For backwards compatibility leave the previous value as default.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/clk/qcom/hfpll.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
> index a6de7101..87b7f46 100644
> --- a/drivers/clk/qcom/hfpll.c
> +++ b/drivers/clk/qcom/hfpll.c
> @@ -52,6 +52,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	struct regmap *regmap;
>  	struct clk_hfpll *h;
> +	struct clk *pclk;
>  	struct clk_init_data init = {
>  		.parent_names = (const char *[]){ "xo" },
>  		.num_parents = 1,
> @@ -75,6 +76,13 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  					  0, &init.name))
>  		return -ENODEV;
>  
> +	/* get parent clock from device tree (optional) */
> +	pclk = devm_clk_get(dev, "xo");
> +	if (!IS_ERR(pclk))
> +		init.parent_names = (const char *[]){ __clk_get_name(pclk) };
> +	else if (PTR_ERR(pclk) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
>  	h->d = &hdata;
>  	h->clkr.hw.init = &init;
>  	spin_lock_init(&h->lock);
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
