Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:07:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A5A20685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hQ8SCak6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kBz7zU80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A5A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W7u0AmrxU1r8bNWN+x4rT5cbZf8371jBLS1pJgWbeQg=; b=hQ8SCak6XU87sT
	kmowlfnq1FKTaV+nH2fPsb/7Ae+cB3YFY3cnbXfzNHTJl1yRMgWVDln12Xe+IUVaR3yMGDgD0vHXK
	RQfB5pu3NDxNCHNDLX8SSJRhDw0mGUT2hVj3nb8tuuPg+pdg683LtTV1PuejBnbWaf5r1276HASM2
	oJyKJNoWj9m3zONOq+dxkERO38WUtahxFqnWt5MMKrEM0OcSL1mRU/x6mUeUQvFmhsrzfILo6tU4z
	BP5NbE4gmeyb0a57e6SvqiHkQ2NGdbtWkZtOlEEHAvgsRfjpwM3Lnhsn7gwSlE/8RnW0dHPYnK9a1
	KENeCXh7FFrmtzjYpHXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPio-0004Ik-3g; Wed, 20 Feb 2019 11:07:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPim-0004Ia-BD
 for linux-arm-kernel@bombadil.infradead.org; Wed, 20 Feb 2019 11:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M2JVAEuXX6bjQ+A7htB3fLoknpK3v/SScVb3+dv8xr0=; b=kBz7zU807W6+Zs4hsgg/czhFB
 yrvkW5aJDpkSj8gqlfBHR2eVcFggMnB++kirOlSk0kBdSQXU8eXAGW9xXfNaFkjMmoSN2szFqdNM2
 073wIDrtpzwG9vAUDF0ED8HFNTLDQCL9Y3yVZwXIFKQ2nIRBJQMitYWxV/xqNbK7oyiPKAtWgSyEb
 RoERvwKDnMx/G0gBFJLb7oVyjECZeiGJgBckMRZayniOPLVKcEZCfx9DngwZg/k9cKAKrROcT2X2B
 Ji9cqTgK8b96DVKdCMEtp6PApZBXBHdnuVQ4N6bS983pdaqaPEJlgLjVezL/gi6ferOLHYX/+PqCT
 CD/Z3Rfrw==;
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPii-0006T5-2z
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:07:21 +0000
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr
 [109.212.12.126])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 57F0E240020;
 Wed, 20 Feb 2019 11:06:43 +0000 (UTC)
Date: Wed, 20 Feb 2019 12:06:43 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 2/3] clk: at91: sckc: add support for SAM9X60
Message-ID: <20190220110643.GI11432@piout.net>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-3-git-send-email-claudiu.beznea@microchip.com>
 <20190218212007.GW10129@piout.net>
 <c00fb195-1688-6ac4-a606-5e08509a2c39@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c00fb195-1688-6ac4-a606-5e08509a2c39@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_060720_375814_72256577 
X-CRM114-Status: GOOD (  31.37  )
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

On 19/02/2019 09:17:43+0000, Claudiu.Beznea@microchip.com wrote:
> 
> 
> On 18.02.2019 23:20, Alexandre Belloni wrote:
> > On 14/02/2019 12:14:32+0000, Claudiu.Beznea@microchip.com wrote:
> >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>
> >> Add support for SAM9X60.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >> ---
> >>  drivers/clk/at91/sckc.c | 30 ++++++++++++++++++++++++++++++
> >>  1 file changed, 30 insertions(+)
> >>
> >> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> >> index b7163d3a2269..b3075c51d260 100644
> >> --- a/drivers/clk/at91/sckc.c
> >> +++ b/drivers/clk/at91/sckc.c
> >> @@ -459,6 +459,36 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
> >>  CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
> >>  	       of_at91sam9x5_sckc_setup);
> >>  
> >> +static const struct clk_slow_offsets at91sam9x60_offsets = {
> >> +	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
> >> +	.cr_osc32en = 1,
> >> +	.cr_osc32byp = 2,
> >> +	.cr_oscsel = 24,
> >> +};
> >> +
> >> +static void __init of_at91sam9x60_sckc_setup(struct device_node *np)
> >> +{
> >> +	struct device_node *childnp;
> >> +	void (*clk_setup)(struct device_node *np, void __iomem *io,
> >> +			  const struct clk_slow_offsets *offsets);
> >> +	const struct of_device_id *clk_id;
> >> +	void __iomem *regbase = of_iomap(np, 0);
> >> +
> >> +	if (!regbase)
> >> +		return;
> >> +
> >> +	for_each_child_of_node(np, childnp) {
> >> +		clk_id = of_match_node(sckc_clk_ids, childnp);
> >> +		if (!clk_id)
> >> +			continue;
> >> +		clk_setup = clk_id->data;
> >> +		clk_setup(childnp, regbase, &at91sam9x60_offsets);
> >> +	}
> > 
> > You actually need to have new bindings. The sam9x60 registration should
> > look more like the sama5d4 registration. I have a rework for the sam9x5
> > sckc that I will send this week to have a proper binding (i.e: no
> > children).
> 
> Does this means that this would also solve the problem I tried to address
> with this patch?
> 

I've sent the series now. It doesn't solve this particular issue.

> > 
> > However, there is a fundamental change in the sam9x60, previously, the
> > sckc had only one output clock. the sam9x60 has both td_slck and
> > md_slck. Both need to be accessible because they are input to the PMC.
> 
> I was guided by the fact that md_slck is generated by the always on slow RC
> oscillator (part of slow clock controller) and since there is no control
> for it on slow clock controller there is no need to be described by this
> driver.
> 

Well, then it would need to be added as an input to the sckc which would
mean that you still need to change the binding. This doesn't matter too
much but else your clock tree would be wrong.

> > 
> > This means you will have to register the sckc with of_clk_hw_onecell_get
> > as the get callback.
> 
> Ok, I'll look into it.
> 
> > 
> > We could still decide to do the same with sam9x5 even if it has only one
> > output clock.
> > 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
