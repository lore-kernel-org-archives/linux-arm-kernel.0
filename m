Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DC6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:24:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3859E2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q1+GkfjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3859E2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f7acb+lXWbMnXFfa4e0zhnHTDQYFLQFLweIqQK2QCVg=; b=Q1+GkfjCWpyRNL
	LEYWA/Ut/LSr+pc+o1ZrBmm/B1xX74fiZKARggyePYmRHSFCp0yD7HAtkmdRP+jlOjhtaiwXK517b
	7SHhmqvOr0V7gQ++fGbDv//lWBK4nTR6iNdMAJzyWyfARO6o+J0Ba/8404lgZWhxarTAMcopHHhH5
	vYvZ8YkZuEoZGY/x85L+nfC2RfmsJ2QGW/8ZVkiI39V0aBxsHsQlAGU3D7yXywZS3A8qWkfq/z2Tj
	3H+Ad5m+MdIYgsEgvD5ASrQyCDKMly8tIgGHAriu08zaedQnf2hKWkG2uP/kYuj75CVlU8wodLjcV
	FZMmGzY6jc/S7MGa+3eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKNW-0004tI-K3; Wed, 06 Feb 2019 10:24:26 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKNT-0004sv-5X
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:24:24 +0000
X-IronPort-AV: E=Sophos;i="5.58,339,1544511600"; d="scan'208";a="25906397"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 06 Feb 2019 03:24:21 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Wed, 6 Feb 2019
 03:24:20 -0700
Date: Wed, 6 Feb 2019 11:24:06 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 1/7] pinctrl: at91: add option to use drive strength
 bits
Message-ID: <20190206102406.r45rb5bfjk2j45dr@M43218.corp.atmel.com>
Mail-Followup-To: Claudiu.Beznea@microchip.com, linus.walleij@linaro.org,
 robh+dt@kernel.org, mark.rutland@arm.com,
 Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
 <1548951466-26297-2-git-send-email-claudiu.beznea@microchip.com>
 <20190206081304.cv344rjzvz7wzih5@M43218.corp.atmel.com>
 <f0022bfc-6deb-de77-857c-c70d41f4fc78@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0022bfc-6deb-de77-857c-c70d41f4fc78@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_022423_245275_843BF272 
X-CRM114-Status: GOOD (  20.74  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 09:46:28AM +0000, Claudiu.Beznea@microchip.com wrote:
> 
> 
> On 06.02.2019 10:13, Ludovic Desroches wrote:
> > On Thu, Jan 31, 2019 at 05:18:04PM +0100, Claudiu Beznea - M18063 wrote:
> >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>
> >> SAM9X60 uses high and low drive strengths. To implement this, in
> >> at91_pinctrl_mux_ops::set_drivestrength and
> >> at91_pinctrl_mux_ops::get_drivestrength we need bit numbers of
> >> drive strengths (1 for low, 2 for high), thus change the code to
> >> allow the usage of drive strength bit numbers.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >> ---
> >>  drivers/pinctrl/pinctrl-at91.c | 32 ++++++++++++++++++++------------
> >>  1 file changed, 20 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> >> index 3d49bbbcdbc7..31f06dafca2e 100644
> >> --- a/drivers/pinctrl/pinctrl-at91.c
> >> +++ b/drivers/pinctrl/pinctrl-at91.c
> >> @@ -72,10 +72,15 @@ static int gpio_banks;
> >>   * DRIVE_STRENGTH_DEFAULT is just a placeholder to avoid changing the drive
> >>   * strength when there is no dt config for it.
> >>   */
> >> -#define DRIVE_STRENGTH_DEFAULT		(0 << DRIVE_STRENGTH_SHIFT)
> >> -#define DRIVE_STRENGTH_LOW          (1 << DRIVE_STRENGTH_SHIFT)
> >> -#define DRIVE_STRENGTH_MED          (2 << DRIVE_STRENGTH_SHIFT)
> >> -#define DRIVE_STRENGTH_HI           (3 << DRIVE_STRENGTH_SHIFT)
> >> +enum drive_strength_bit {
> >> +	DRIVE_STRENGTH_BIT_DEF,
> >> +	DRIVE_STRENGTH_BIT_LOW,
> >> +	DRIVE_STRENGTH_BIT_MED,
> >> +	DRIVE_STRENGTH_BIT_HI,
> >> +};
> >> +
> >> +#define DRIVE_STRENGTH_BIT_MSK(name)	(DRIVE_STRENGTH_BIT_##name << \
> >> +					 DRIVE_STRENGTH_SHIFT)
> >>  
> >>  /**
> >>   * struct at91_pmx_func - describes AT91 pinmux functions
> >> @@ -551,7 +556,7 @@ static unsigned at91_mux_sama5d3_get_drivestrength(void __iomem *pio,
> >>  	/* SAMA5 strength is 1:1 with our defines,
> >>  	 * except 0 is equivalent to low per datasheet */
> >>  	if (!tmp)
> >> -		tmp = DRIVE_STRENGTH_LOW;
> >> +		tmp = DRIVE_STRENGTH_BIT_MSK(LOW);
> >>  
> >>  	return tmp;
> >>  }
> >> @@ -564,7 +569,7 @@ static unsigned at91_mux_sam9x5_get_drivestrength(void __iomem *pio,
> >>  
> >>  	/* strength is inverse in SAM9x5s hardware with the pinctrl defines
> >>  	 * hardware: 0 = hi, 1 = med, 2 = low, 3 = rsvd */
> >> -	tmp = DRIVE_STRENGTH_HI - tmp;
> >> +	tmp = DRIVE_STRENGTH_BIT_MSK(HI) - tmp;
> >>  
> >>  	return tmp;
> >>  }
> >> @@ -600,7 +605,7 @@ static void at91_mux_sam9x5_set_drivestrength(void __iomem *pio, unsigned pin,
> >>  
> >>  	/* strength is inverse on SAM9x5s with our defines
> >>  	 * 0 = hi, 1 = med, 2 = low, 3 = rsvd */
> >> -	setting = DRIVE_STRENGTH_HI - setting;
> >> +	setting = DRIVE_STRENGTH_BIT_MSK(HI) - setting;
> >>  
> >>  	set_drive_strength(pio + at91sam9x5_get_drive_register(pin), pin,
> >>  				setting);
> >> @@ -959,11 +964,11 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
> >>  	}					\
> >>  } while (0)
> >>  
> >> -#define DBG_SHOW_FLAG_MASKED(mask,flag) do {	\
> >> +#define DBG_SHOW_FLAG_MASKED(mask,flag,name) do {	\
> > 
> > checkpatch error: space required
> 
> I'm aware of that but I added it in the way it was previously (were the
> checkpatch error was still present). Please let me know if you want me to
> send a new version fixing this.

I think it's the opportunity to fix it. If you can resend a new version
including my ack.

Regards

Ludovic

> 
> Thank you,
> Claudiu Beznea
> 
> > 
> >>  	if ((config & mask) == flag) {		\
> >>  		if (num_conf)			\
> >>  			seq_puts(s, "|");	\
> >> -		seq_puts(s, #flag);		\
> >> +		seq_puts(s, #name);		\
> >>  		num_conf++;			\
> >>  	}					\
> >>  } while (0)
> >> @@ -981,9 +986,12 @@ static void at91_pinconf_dbg_show(struct pinctrl_dev *pctldev,
> >>  	DBG_SHOW_FLAG(PULL_DOWN);
> >>  	DBG_SHOW_FLAG(DIS_SCHMIT);
> >>  	DBG_SHOW_FLAG(DEGLITCH);
> >> -	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_LOW);
> >> -	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_MED);
> >> -	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_HI);
> >> +	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(LOW),
> >> +			     DRIVE_STRENGTH_LOW);
> >> +	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(MED),
> >> +			     DRIVE_STRENGTH_MED);
> >> +	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(HI),
> >> +			     DRIVE_STRENGTH_HI);
> >>  	DBG_SHOW_FLAG(DEBOUNCE);
> >>  	if (config & DEBOUNCE) {
> >>  		val = config >> DEBOUNCE_VAL_SHIFT;
> >> -- 
> >> 2.7.4
> >>
> > 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
