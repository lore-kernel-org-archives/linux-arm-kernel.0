Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085ACC31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:46:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12ED21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZujhJnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12ED21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uJZ45MxhNzFUHiQ1zzGzGzSjqLe2Zdmrl91sQ3zZ4ew=; b=cZujhJnJPXxnfQ
	tiP3S3QY6bYetz300ihC/7eRNlApN9nwjGW0iMRVBAZvRASWpvDySIRpYt7iIOqk/WJlIXNleAula
	jASA/mdJ8SXn8Kp3qyc/ljBYlXf3lUH16IpgZK9k+f/WyX+xEFAWqqCrYKvOcBnDC27BHG7oo8DVW
	M4p5eHlgJxwl5YYXw+HOHVdOVHDDVKGvQS2eAOGmbzIQzJIaNEhRABePZIEvMJW8Crj8l9kr2ARR/
	yZdui+/etJB8X1e4m5/+4OQ0OUQEX1rZQ11FpJMguH+0PwmV8nTbKK1J2pEsPs7TjxJ9sccurGjoD
	59iZEU3IGrvP7/Jh/xGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gleaw-0004SG-SP; Mon, 21 Jan 2019 18:46:50 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glear-0004OR-Pa
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 18:46:48 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gleak-0003E7-Cu; Mon, 21 Jan 2019 19:46:38 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gleaj-0004Pp-RH; Mon, 21 Jan 2019 19:46:37 +0100
Date: Mon, 21 Jan 2019 19:46:37 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: Re: [PATCH V2 2/4] drivers: pwm: pwm-bcm-kona: Switch to using
 atomic PWM Framework
Message-ID: <20190121184637.httmrtd3coz2m5ie@pengutronix.de>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547669716-20070-3-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547669716-20070-3-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_104646_020307_658923C3 
X-CRM114-Status: GOOD (  25.79  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Thu, Jan 17, 2019 at 01:45:14AM +0530, Sheetal Tigadoli wrote:
> Switch to using atomic PWM Framework on broadcom PWM kona driver
> =

> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 201 +++++++++++++++++++--------------------=
------
>  1 file changed, 83 insertions(+), 118 deletions(-)
> =

> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index 09a95ae..fe63289 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -108,151 +108,116 @@ static void kona_pwmc_apply_settings(struct kona_=
pwmc *kp, unsigned int chan)
>  	ndelay(400);
>  }
>  =

> -static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> -			    int duty_ns, int period_ns)
> -{
> -	struct kona_pwmc *kp =3D to_kona_pwmc(chip);
> -	u64 val, div, rate;
> -	unsigned long prescale =3D PRESCALE_MIN, pc, dc;
> -	unsigned int value, chan =3D pwm->hwpwm;
> -
> -	/*
> -	 * Find period count, duty count and prescale to suit duty_ns and
> -	 * period_ns. This is done according to formulas described below:
> -	 *
> -	 * period_ns =3D 10^9 * (PRESCALE + 1) * PC / PWM_CLK_RATE
> -	 * duty_ns =3D 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
> -	 *
> -	 * PC =3D (PWM_CLK_RATE * period_ns) / (10^9 * (PRESCALE + 1))
> -	 * DC =3D (PWM_CLK_RATE * duty_ns) / (10^9 * (PRESCALE + 1))
> -	 */
> -
> -	rate =3D clk_get_rate(kp->clk);
> -
> -	while (1) {
> -		div =3D 1000000000;
> -		div *=3D 1 + prescale;
> -		val =3D rate * period_ns;
> -		pc =3D div64_u64(val, div);
> -		val =3D rate * duty_ns;
> -		dc =3D div64_u64(val, div);
> -
> -		/* If duty_ns or period_ns are not achievable then return */
> -		if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
> -			return -EINVAL;
> -
> -		/* If pc and dc are in bounds, the calculation is done */
> -		if (pc <=3D PERIOD_COUNT_MAX && dc <=3D DUTY_CYCLE_HIGH_MAX)
> -			break;
> -
> -		/* Otherwise, increase prescale and recalculate pc and dc */
> -		if (++prescale > PRESCALE_MAX)
> -			return -EINVAL;
> -	}
> -
> -	/*
> -	 * Don't apply settings if disabled. The period and duty cycle are
> -	 * always calculated above to ensure the new values are
> -	 * validated immediately instead of on enable.
> -	 */
> -	if (pwm_is_enabled(pwm)) {
> -		kona_pwmc_prepare_for_settings(kp, chan);
> -
> -		value =3D readl(kp->base + PRESCALE_OFFSET);
> -		value &=3D ~PRESCALE_MASK(chan);
> -		value |=3D prescale << PRESCALE_SHIFT(chan);
> -		writel(value, kp->base + PRESCALE_OFFSET);
> -
> -		writel(pc, kp->base + PERIOD_COUNT_OFFSET(chan));
> -
> -		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
> -
> -		kona_pwmc_apply_settings(kp, chan);
> -	}
> -
> -	return 0;
> -}
> -
> -static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> -				  enum pwm_polarity polarity)
> +static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *=
pwm)
>  {
>  	struct kona_pwmc *kp =3D to_kona_pwmc(chip);
>  	unsigned int chan =3D pwm->hwpwm;
>  	unsigned int value;
> -	int ret;
> -
> -	ret =3D clk_prepare_enable(kp->clk);
> -	if (ret < 0) {
> -		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
> -		return ret;
> -	}
>  =

>  	kona_pwmc_prepare_for_settings(kp, chan);
>  =

> -	value =3D readl(kp->base + PWM_CONTROL_OFFSET);
> -
> -	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> -		value |=3D 1 << PWM_CONTROL_POLARITY_SHIFT(chan);
> -	else
> -		value &=3D ~(1 << PWM_CONTROL_POLARITY_SHIFT(chan));
> +	/* Simulate a disable by configuring for zero duty */
> +	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
> +	writel(0, kp->base + PERIOD_COUNT_OFFSET(chan));
>  =

> -	writel(value, kp->base + PWM_CONTROL_OFFSET);
> +	/* Set prescale to 0 for this channel */

kona_pwmc_apply uses PRESCALE_MIN instead of a plain 0. To make the
comment more helpful tell *why* you do it instead of stating the obvious
for the fluent C programmer.

> +	value =3D readl(kp->base + PRESCALE_OFFSET);
> +	value &=3D ~PRESCALE_MASK(chan);
> +	writel(value, kp->base + PRESCALE_OFFSET);
>  =

>  	kona_pwmc_apply_settings(kp, chan);
>  =

>  	clk_disable_unprepare(kp->clk);
> -
> -	return 0;
>  }
>  =

> -static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pw=
m)
> +static int kona_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   struct pwm_state *state)
>  {
>  	struct kona_pwmc *kp =3D to_kona_pwmc(chip);
> +	struct pwm_state cstate;
> +	u64 val, div, rate;
> +	unsigned long prescale =3D PRESCALE_MIN, pc, dc;
> +	unsigned int value, chan =3D pwm->hwpwm;
>  	int ret;
>  =

> -	ret =3D clk_prepare_enable(kp->clk);
> -	if (ret < 0) {
> -		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret =3D kona_pwmc_config(chip, pwm, pwm_get_duty_cycle(pwm),
> -			       pwm_get_period(pwm));
> -	if (ret < 0) {
> -		clk_disable_unprepare(kp->clk);
> -		return ret;
> -	}
> +	pwm_get_state(pwm, &cstate);

The pwm_get_state function is designed for PWM-consumers. It is an
implementation detail that it also works for drivers. So I'd like to see
its usage dropped in drivers. (Note that Thierry might not agree here.)

> +
> +	if (state->enabled) {
> +		/*
> +		 * Find period count, duty count and prescale to suit duty_ns
> +		 * and period_ns. This is done according to formulas described
> +		 * below:
> +		 *
> +		 * period_ns =3D 10^9 * (PRESCALE + 1) * PC / PWM_CLK_RATE
> +		 * duty_ns =3D 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
> +		 *
> +		 * PC =3D (PWM_CLK_RATE * period_ns) / (10^9 * (PRESCALE + 1))
> +		 * DC =3D (PWM_CLK_RATE * duty_ns) / (10^9 * (PRESCALE + 1))
> +		 */
> +		rate =3D clk_get_rate(kp->clk);
> +
> +		while (1) {
> +			div =3D 1000000000;
> +			div *=3D 1 + prescale;
> +			val =3D rate * state->period;
> +			pc =3D div64_u64(val, div);
> +			val =3D rate * state->duty_cycle;
> +			dc =3D div64_u64(val, div);
> +
> +			/* If duty_ns or period_ns are not achievable then

Please stick to the usual style for multi-line comments, i.e. "/*" on a
separate line.

> +			 * return
> +			 */
> +			if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
> +				return -EINVAL;
> +
> +			/* If pc & dc are in bounds, the calculation is done */
> +			if (pc <=3D PERIOD_COUNT_MAX && dc <=3D DUTY_CYCLE_HIGH_MAX)
> +				break;
> +
> +			/* Otherwise, increase prescale & recalculate pc & dc */
> +			if (++prescale > PRESCALE_MAX)
> +				return -EINVAL;
> +		}
> +
> +		if (!cstate.enabled) {
> +			ret =3D clk_prepare_enable(kp->clk);
> +			if (ret < 0) {
> +				dev_err(chip->dev,
> +					"failed to enable clock: %d\n", ret);
> +				return ret;
> +			}
> +		}
>  =

> -	return 0;
> -}
> -
> -static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *=
pwm)
> -{
> -	struct kona_pwmc *kp =3D to_kona_pwmc(chip);
> -	unsigned int chan =3D pwm->hwpwm;
> -	unsigned int value;
> +		kona_pwmc_prepare_for_settings(kp, chan);
>  =

> -	kona_pwmc_prepare_for_settings(kp, chan);
> +		value =3D readl(kp->base + PRESCALE_OFFSET);
> +		value &=3D ~PRESCALE_MASK(chan);
> +		value |=3D prescale << PRESCALE_SHIFT(chan);
> +		writel(value, kp->base + PRESCALE_OFFSET);
> +		writel(pc, kp->base + PERIOD_COUNT_OFFSET(chan));
> +		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
>  =

> -	/* Simulate a disable by configuring for zero duty */
> -	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
> -	writel(0, kp->base + PERIOD_COUNT_OFFSET(chan));
> +		if (cstate.polarity !=3D state->polarity) {
> +			value =3D readl(kp->base + PWM_CONTROL_OFFSET);
> +			if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +				value |=3D 1 << PWM_CONTROL_POLARITY_SHIFT(chan);
> +			else
> +				value &=3D ~(1 <<
> +					   PWM_CONTROL_POLARITY_SHIFT(chan));
>  =

> -	/* Set prescale to 0 for this channel */
> -	value =3D readl(kp->base + PRESCALE_OFFSET);
> -	value &=3D ~PRESCALE_MASK(chan);
> -	writel(value, kp->base + PRESCALE_OFFSET);
> +			writel(value, kp->base + PWM_CONTROL_OFFSET);
> +		}
>  =

> -	kona_pwmc_apply_settings(kp, chan);
> +		kona_pwmc_apply_settings(kp, chan);
> +	} else if (cstate.enabled) {
> +		kona_pwmc_disable(chip, pwm);

If I do:

	pwm_apply_state(pwm, { .polarity =3D PWM_POLARITY_NORMAL, .enabled =3D tru=
e, ... });
	pwm_apply_state(pwm, { .polarity =3D PWM_POLARITY_INVERSED, .enabled =3D f=
alse, ... });

the output is constant low, which is wrong.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
