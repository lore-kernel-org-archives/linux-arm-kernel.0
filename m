Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3688C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:10:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7030E2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WIllImXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7030E2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/XrQPCpfUcNoDWw19Ttjlk39Fb8/RjT3NtVz+Yk3wP4=; b=WIllImXXPvsbMm
	lOe72eo7vayO0kbABDFyqrvx2Ggtwy1cD+GXGJSwUWk/sBOoeBO8f6utKrdFwM5A/WwJMKXc7h7RY
	Vzh5iTAOqo61QyY2eTglxz2Oba8B/yv4lR9bb5m9MxRSBFcJBSra9koxhglYABA0PxIEXboAG+y9F
	KVEDZAq9/KLumGzk90OtJ7APhkwO1o8TSpSSGDOsGXYRbl2b0qQ+EwXdfx7kiuqwD3TIZYxziLcLO
	GaA5qC/x9eGoSfQJbxj7d1CNrzv64ijM+IEbMKyeVhS3dSFsL5/67DbTYM/mdA5jYVLfVxXIG/aRs
	+8ZOO8+JYBZKu2DRf1Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqB7-0000Qw-0P; Mon, 18 Feb 2019 21:10:17 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvq9L-000675-P4
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:08:43 +0000
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr
 [86.202.231.219])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 15EDA100003;
 Mon, 18 Feb 2019 21:08:11 +0000 (UTC)
Date: Mon, 18 Feb 2019 22:08:11 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 1/3] clk: at91: sckc: add support to specify registers
 bit offsets
Message-ID: <20190218210811.GV10129@piout.net>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550146447-1441-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_130828_829708_211599C8 
X-CRM114-Status: GOOD (  22.90  )
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

Hi,

On 14/02/2019 12:14:28+0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Different IPs uses different offsets in registers for the same
> functionality, thus adapt the driver to support this.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/clk/at91/sckc.c | 112 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 77 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> index ab6ecefc49ad..b7163d3a2269 100644
> --- a/drivers/clk/at91/sckc.c
> +++ b/drivers/clk/at91/sckc.c
> @@ -22,15 +22,25 @@
>  #define SLOWCK_SW_TIME_USEC	((SLOWCK_SW_CYCLES * USEC_PER_SEC) / \
>  				 SLOW_CLOCK_FREQ)
>  
> -#define	AT91_SCKC_CR			0x00
> -#define		AT91_SCKC_RCEN		(1 << 0)
> -#define		AT91_SCKC_OSC32EN	(1 << 1)
> -#define		AT91_SCKC_OSC32BYP	(1 << 2)
> -#define		AT91_SCKC_OSCSEL	(1 << 3)
> +#define	AT91_SCKC_CR		0x00
> +#define		AT91_SCKC_RCEN(off)	(1 << (off)->cr_rcen)
> +#define		AT91_SCKC_OSC32EN(off)	(1 << (off)->cr_osc32en)
> +#define		AT91_SCKC_OSC32BYP(off)	(1 << (off)->cr_osc32byp)
> +#define		AT91_SCKC_OSCSEL(off)	(1 << (off)->cr_oscsel)

You don't need those macros if you store BIT(off) instead of off in the
members of clk_slow_offsets.

> +
> +#define AT91_SCKC_OFFSET_INVALID        (32)
> +

This would also remove the need for that define as 0 would mean that the
bit doesn't exist.

> +struct clk_slow_offsets {
> +	u8 cr_rcen;
> +	u8 cr_osc32en;
> +	u8 cr_osc32byp;
> +	u8 cr_oscsel;
> +};
>  
>  struct clk_slow_osc {
>  	struct clk_hw hw;
>  	void __iomem *sckcr;
> +	const struct clk_slow_offsets *offsets;
>  	unsigned long startup_usec;
>  };
>  
> @@ -39,6 +49,7 @@ struct clk_slow_osc {
>  struct clk_sama5d4_slow_osc {
>  	struct clk_hw hw;
>  	void __iomem *sckcr;
> +	const struct clk_slow_offsets *offsets;
>  	unsigned long startup_usec;
>  	bool prepared;
>  };
> @@ -48,6 +59,7 @@ struct clk_sama5d4_slow_osc {
>  struct clk_slow_rc_osc {
>  	struct clk_hw hw;
>  	void __iomem *sckcr;
> +	const struct clk_slow_offsets *offsets;
>  	unsigned long frequency;
>  	unsigned long accuracy;
>  	unsigned long startup_usec;
> @@ -58,6 +70,7 @@ struct clk_slow_rc_osc {
>  struct clk_sam9x5_slow {
>  	struct clk_hw hw;
>  	void __iomem *sckcr;
> +	const struct clk_slow_offsets *offsets;
>  	u8 parent;
>  };
>  
> @@ -69,10 +82,11 @@ static int clk_slow_osc_prepare(struct clk_hw *hw)
>  	void __iomem *sckcr = osc->sckcr;
>  	u32 tmp = readl(sckcr);
>  
> -	if (tmp & (AT91_SCKC_OSC32BYP | AT91_SCKC_OSC32EN))
> +	if (tmp & (AT91_SCKC_OSC32BYP(osc->offsets) |
> +		   AT91_SCKC_OSC32EN(osc->offsets)))
>  		return 0;
>  
> -	writel(tmp | AT91_SCKC_OSC32EN, sckcr);
> +	writel(tmp | AT91_SCKC_OSC32EN(osc->offsets), sckcr);
>  
>  	usleep_range(osc->startup_usec, osc->startup_usec + 1);
>  
> @@ -85,10 +99,10 @@ static void clk_slow_osc_unprepare(struct clk_hw *hw)
>  	void __iomem *sckcr = osc->sckcr;
>  	u32 tmp = readl(sckcr);
>  
> -	if (tmp & AT91_SCKC_OSC32BYP)
> +	if (tmp & AT91_SCKC_OSC32BYP(osc->offsets))
>  		return;
>  
> -	writel(tmp & ~AT91_SCKC_OSC32EN, sckcr);
> +	writel(tmp & ~AT91_SCKC_OSC32EN(osc->offsets), sckcr);
>  }
>  
>  static int clk_slow_osc_is_prepared(struct clk_hw *hw)
> @@ -97,10 +111,10 @@ static int clk_slow_osc_is_prepared(struct clk_hw *hw)
>  	void __iomem *sckcr = osc->sckcr;
>  	u32 tmp = readl(sckcr);
>  
> -	if (tmp & AT91_SCKC_OSC32BYP)
> +	if (tmp & AT91_SCKC_OSC32BYP(osc->offsets))
>  		return 1;
>  
> -	return !!(tmp & AT91_SCKC_OSC32EN);
> +	return !!(tmp & AT91_SCKC_OSC32EN(osc->offsets));
>  }
>  
>  static const struct clk_ops slow_osc_ops = {
> @@ -114,7 +128,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
>  			   const char *name,
>  			   const char *parent_name,
>  			   unsigned long startup,
> -			   bool bypass)
> +			   bool bypass,
> +			   const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_slow_osc *osc;
>  	struct clk_hw *hw;
> @@ -137,9 +152,11 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
>  	osc->hw.init = &init;
>  	osc->sckcr = sckcr;
>  	osc->startup_usec = startup;
> +	osc->offsets = offsets;
>  
>  	if (bypass)
> -		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN) | AT91_SCKC_OSC32BYP,
> +		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN(osc->offsets)) |
> +					AT91_SCKC_OSC32BYP(osc->offsets),
>  		       sckcr);
>  
>  	hw = &osc->hw;
> @@ -153,7 +170,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
>  }
>  
>  static void __init
> -of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
> +of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr,
> +				 const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_hw *hw;
>  	const char *parent_name;
> @@ -167,7 +185,7 @@ of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
>  	bypass = of_property_read_bool(np, "atmel,osc-bypass");
>  
>  	hw = at91_clk_register_slow_osc(sckcr, name, parent_name, startup,
> -					 bypass);
> +					bypass, offsets);
>  	if (IS_ERR(hw))
>  		return;
>  
> @@ -195,7 +213,7 @@ static int clk_slow_rc_osc_prepare(struct clk_hw *hw)
>  	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
>  	void __iomem *sckcr = osc->sckcr;
>  
> -	writel(readl(sckcr) | AT91_SCKC_RCEN, sckcr);
> +	writel(readl(sckcr) | AT91_SCKC_RCEN(osc->offsets), sckcr);
>  
>  	usleep_range(osc->startup_usec, osc->startup_usec + 1);
>  
> @@ -207,14 +225,14 @@ static void clk_slow_rc_osc_unprepare(struct clk_hw *hw)
>  	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
>  	void __iomem *sckcr = osc->sckcr;
>  
> -	writel(readl(sckcr) & ~AT91_SCKC_RCEN, sckcr);
> +	writel(readl(sckcr) & ~AT91_SCKC_RCEN(osc->offsets), sckcr);
>  }
>  
>  static int clk_slow_rc_osc_is_prepared(struct clk_hw *hw)
>  {
>  	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
>  
> -	return !!(readl(osc->sckcr) & AT91_SCKC_RCEN);
> +	return !!(readl(osc->sckcr) & AT91_SCKC_RCEN(osc->offsets));
>  }
>  
>  static const struct clk_ops slow_rc_osc_ops = {
> @@ -230,7 +248,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
>  			      const char *name,
>  			      unsigned long frequency,
>  			      unsigned long accuracy,
> -			      unsigned long startup)
> +			      unsigned long startup,
> +			      const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_slow_rc_osc *osc;
>  	struct clk_hw *hw;
> @@ -252,6 +271,7 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
>  
>  	osc->hw.init = &init;
>  	osc->sckcr = sckcr;
> +	osc->offsets = offsets;
>  	osc->frequency = frequency;
>  	osc->accuracy = accuracy;
>  	osc->startup_usec = startup;
> @@ -267,7 +287,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
>  }
>  
>  static void __init
> -of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
> +of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr,
> +				    const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_hw *hw;
>  	u32 frequency = 0;
> @@ -281,7 +302,7 @@ of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
>  	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
>  
>  	hw = at91_clk_register_slow_rc_osc(sckcr, name, frequency, accuracy,
> -					    startup);
> +					   startup, offsets);
>  	if (IS_ERR(hw))
>  		return;
>  
> @@ -299,14 +320,14 @@ static int clk_sam9x5_slow_set_parent(struct clk_hw *hw, u8 index)
>  
>  	tmp = readl(sckcr);
>  
> -	if ((!index && !(tmp & AT91_SCKC_OSCSEL)) ||
> -	    (index && (tmp & AT91_SCKC_OSCSEL)))
> +	if ((!index && !(tmp & AT91_SCKC_OSCSEL(slowck->offsets))) ||
> +	    (index && (tmp & AT91_SCKC_OSCSEL(slowck->offsets))))
>  		return 0;
>  
>  	if (index)
> -		tmp |= AT91_SCKC_OSCSEL;
> +		tmp |= AT91_SCKC_OSCSEL(slowck->offsets);
>  	else
> -		tmp &= ~AT91_SCKC_OSCSEL;
> +		tmp &= ~AT91_SCKC_OSCSEL(slowck->offsets);
>  
>  	writel(tmp, sckcr);
>  
> @@ -319,7 +340,7 @@ static u8 clk_sam9x5_slow_get_parent(struct clk_hw *hw)
>  {
>  	struct clk_sam9x5_slow *slowck = to_clk_sam9x5_slow(hw);
>  
> -	return !!(readl(slowck->sckcr) & AT91_SCKC_OSCSEL);
> +	return !!(readl(slowck->sckcr) & AT91_SCKC_OSCSEL(slowck->offsets));
>  }
>  
>  static const struct clk_ops sam9x5_slow_ops = {
> @@ -331,7 +352,8 @@ static struct clk_hw * __init
>  at91_clk_register_sam9x5_slow(void __iomem *sckcr,
>  			      const char *name,
>  			      const char **parent_names,
> -			      int num_parents)
> +			      int num_parents,
> +			      const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_sam9x5_slow *slowck;
>  	struct clk_hw *hw;
> @@ -353,7 +375,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
>  
>  	slowck->hw.init = &init;
>  	slowck->sckcr = sckcr;
> -	slowck->parent = !!(readl(sckcr) & AT91_SCKC_OSCSEL);
> +	slowck->offsets = offsets;
> +	slowck->parent = !!(readl(sckcr) & AT91_SCKC_OSCSEL(slowck->offsets));
>  
>  	hw = &slowck->hw;
>  	ret = clk_hw_register(NULL, &slowck->hw);
> @@ -366,7 +389,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
>  }
>  
>  static void __init
> -of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
> +of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr,
> +			     const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_hw *hw;
>  	const char *parent_names[2];
> @@ -382,7 +406,7 @@ of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
>  	of_property_read_string(np, "clock-output-names", &name);
>  
>  	hw = at91_clk_register_sam9x5_slow(sckcr, name, parent_names,
> -					    num_parents);
> +					   num_parents, offsets);
>  	if (IS_ERR(hw))
>  		return;
>  
> @@ -406,10 +430,18 @@ static const struct of_device_id sckc_clk_ids[] __initconst = {
>  	{ /*sentinel*/ }
>  };
>  
> +static const struct clk_slow_offsets at91sam9x5_offsets = {
> +	.cr_rcen = 0,
> +	.cr_osc32en = 1,
> +	.cr_osc32byp = 2,
> +	.cr_oscsel = 3,
> +};
> +
>  static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
>  {
>  	struct device_node *childnp;
> -	void (*clk_setup)(struct device_node *, void __iomem *);
> +	void (*clk_setup)(struct device_node *np, void __iomem *io,
> +			  const struct clk_slow_offsets *offsets);
>  	const struct of_device_id *clk_id;
>  	void __iomem *regbase = of_iomap(np, 0);
>  
> @@ -421,7 +453,7 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
>  		if (!clk_id)
>  			continue;
>  		clk_setup = clk_id->data;
> -		clk_setup(childnp, regbase);
> +		clk_setup(childnp, regbase, &at91sam9x5_offsets);
>  	}
>  }
>  CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
> @@ -438,7 +470,7 @@ static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
>  	 * Assume that if it has already been selected (for example by the
>  	 * bootloader), enough time has aready passed.
>  	 */
> -	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL)) {
> +	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL(osc->offsets))) {
>  		osc->prepared = true;
>  		return 0;
>  	}
> @@ -461,6 +493,13 @@ static const struct clk_ops sama5d4_slow_osc_ops = {
>  	.is_prepared = clk_sama5d4_slow_osc_is_prepared,
>  };
>  
> +static const struct clk_slow_offsets at91sama5d4_offsets = {
> +	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
> +	.cr_osc32en = AT91_SCKC_OFFSET_INVALID,
> +	.cr_osc32byp = AT91_SCKC_OFFSET_INVALID,
> +	.cr_oscsel = 3,
> +};
> +

I don't think you need to change the sama5d4 part as it is not affected
by any change in the sam9x5 part.

>  static void __init of_sama5d4_sckc_setup(struct device_node *np)
>  {
>  	void __iomem *regbase = of_iomap(np, 0);
> @@ -498,9 +537,11 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
>  	osc->hw.init = &init;
>  	osc->sckcr = regbase;
>  	osc->startup_usec = 1200000;
> +	osc->offsets = &at91sama5d4_offsets;
>  
>  	if (bypass)
> -		writel((readl(regbase) | AT91_SCKC_OSC32BYP), regbase);
> +		writel((readl(regbase) | AT91_SCKC_OSC32BYP(osc->offsets)),
> +		       regbase);
>  
>  	hw = &osc->hw;
>  	ret = clk_hw_register(NULL, &osc->hw);
> @@ -509,7 +550,8 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
>  		return;
>  	}
>  
> -	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2);
> +	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2,
> +					   &at91sama5d4_offsets);
>  	if (IS_ERR(hw))
>  		return;
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
