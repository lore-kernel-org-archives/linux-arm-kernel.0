Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD48C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:54:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE662133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G2jUVZ78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE662133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bmgAxKh4YucPoHJqWK6fy+h7yiUVQNDxJIROC5V+TcY=; b=G2jUVZ78yyll/l
	rfvkhO7AdJsnbIjbijWd1C5LBSDh3q1qKsJgTP+ke9J2X7a7DjloMH+mumBKmUqHFMeSA283VxqFr
	yUeqwdbZNoM79LLODBSzyb6oSfyiPBlXJYKjfHPHg58MlfOWBLGOgVYvMTEFOyPX7VztU6VqZKRxL
	5S5BQjkQlC6ILmzbK7UPIyXFZHs39CLDuTpygs+CIev/fxQlyAXi01siRryzptgKrKNcScaNPKDuS
	GGaP7ePIwJP+46v6m1LT0k3Vubv5nJYTNCD4VYyoQg07MrJ/vUyotSRey0pTpNFQmQoQSm+McbKj6
	vx44joow6vrdgLk4E42w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi3oj-0006sB-LE; Fri, 11 Jan 2019 20:54:13 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi3of-0006rR-T8
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 20:54:12 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gi3oa-0006zN-RV; Fri, 11 Jan 2019 21:54:04 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gi3oZ-0002ty-Sm; Fri, 11 Jan 2019 21:54:04 +0100
Date: Fri, 11 Jan 2019 21:54:03 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: Re: [PATCH 2/3] drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
Message-ID: <20190111205403.e4bgszqbrq65jsgh@pengutronix.de>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_125410_246729_5F8C5E2E 
X-CRM114-Status: GOOD (  26.74  )
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
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Praveen Kumar B <praveen.b@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Fri, Jan 11, 2019 at 10:51:15AM +0530, Sheetal Tigadoli wrote:
> From: Praveen Kumar B <praveen.b@broadcom.com>
> =

> Add support for new version of pwm-kona.
> Add support to make PWM changes configured and stable.
> =

> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 128 ++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 98 insertions(+), 30 deletions(-)
> =

> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index 09a95ae..2b44ad8 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -45,30 +45,39 @@
>   *    high or low depending on its state at that exact instant.
>   */
>  =

> -#define PWM_CONTROL_OFFSET			(0x00000000)
> +#define PWM_CONTROL_OFFSET			0x00000000
>  #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
>  #define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
>  #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
>  #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
>  =

> -#define PRESCALE_OFFSET				(0x00000004)
> +#define PRESCALE_OFFSET				0x00000004
>  #define PRESCALE_SHIFT(chan)			((chan) << 2)
>  #define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
> -#define PRESCALE_MIN				(0x00000000)
> -#define PRESCALE_MAX				(0x00000007)
> +#define PRESCALE_MIN				0x00000000
> +#define PRESCALE_MAX				0x00000007
>  =

>  #define PERIOD_COUNT_OFFSET(chan)		(0x00000008 + ((chan) << 3))
> -#define PERIOD_COUNT_MIN			(0x00000002)
> -#define PERIOD_COUNT_MAX			(0x00ffffff)
> +#define PERIOD_COUNT_MIN			0x00000002
> +#define PERIOD_COUNT_MAX			0x00ffffff
>  =

>  #define DUTY_CYCLE_HIGH_OFFSET(chan)		(0x0000000c + ((chan) << 3))
> -#define DUTY_CYCLE_HIGH_MIN			(0x00000000)
> -#define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
> +#define DUTY_CYCLE_HIGH_MIN			0x00000000
> +#define DUTY_CYCLE_HIGH_MAX			0x00ffffff

All these are unrelated changes.

> +#define PWM_MONITOR_OFFSET			0xb0
> +#define PWM_MONITOR_TIMEOUT_US			5
> +
> +enum kona_pwmc_ver {
> +	KONA_PWM_V1 =3D 1,
> +	KONA_PWM_V2
> +};
>  =

>  struct kona_pwmc {
>  	struct pwm_chip chip;
>  	void __iomem *base;
>  	struct clk *clk;
> +	enum kona_pwmc_ver version;
>  };
>  =

>  static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
> @@ -76,11 +85,40 @@ static inline struct kona_pwmc *to_kona_pwmc(struct p=
wm_chip *_chip)
>  	return container_of(_chip, struct kona_pwmc, chip);
>  }
>  =

> +static int kona_pwmc_wait_stable(struct pwm_chip *chip, unsigned int cha=
n,
> +				 unsigned int kona_ver)
> +{
> +	struct kona_pwmc *kp =3D to_kona_pwmc(chip);
> +	unsigned int value;
> +	unsigned int count =3D PWM_MONITOR_TIMEOUT_US * 1000;
> +
> +	switch (kona_ver) {
> +	case KONA_PWM_V1:
> +		/*
> +		 * There must be a min 400ns delay between clearing trigger and
> +		 * settingit. Failing to do this may result in no PWM signal.

Space missing.

> +		 */
> +		ndelay(400);
> +		return 0;
> +	case KONA_PWM_V2:
> +		do {
> +			value =3D readl(kp->base + PWM_MONITOR_OFFSET);
> +			if (!(value & (BIT(chan))))
> +				return 0;
> +			ndelay(1);
> +		} while (count--);
> +
> +		return -ETIMEDOUT;
> +	default:
> +		return -ENODEV;
> +	}

I wonder if v1 and v2 are different enough to justify a separate driver
for v2.

> +}
> +
>  /*
>   * Clear trigger bit but set smooth bit to maintain old output.
>   */
> -static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
> -	unsigned int chan)
> +static int kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
> +					  unsigned int chan)
>  {
>  	unsigned int value =3D readl(kp->base + PWM_CONTROL_OFFSET);
>  =

> @@ -88,14 +126,10 @@ static void kona_pwmc_prepare_for_settings(struct ko=
na_pwmc *kp,
>  	value &=3D ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
>  	writel(value, kp->base + PWM_CONTROL_OFFSET);
>  =

> -	/*
> -	 * There must be a min 400ns delay between clearing trigger and setting
> -	 * it. Failing to do this may result in no PWM signal.
> -	 */
> -	ndelay(400);
> +	return kona_pwmc_wait_stable(&kp->chip, chan, kp->version);
>  }
>  =

> -static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int =
chan)
> +static int kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int c=
han)
>  {
>  	unsigned int value =3D readl(kp->base + PWM_CONTROL_OFFSET);
>  =

> @@ -104,8 +138,7 @@ static void kona_pwmc_apply_settings(struct kona_pwmc=
 *kp, unsigned int chan)
>  	value |=3D 1 << PWM_CONTROL_TRIGGER_SHIFT(chan);
>  	writel(value, kp->base + PWM_CONTROL_OFFSET);
>  =

> -	/* Trigger bit must be held high for at least 400 ns. */
> -	ndelay(400);
> +	return kona_pwmc_wait_stable(&kp->chip, chan, kp->version);
>  }
>  =

>  static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> @@ -115,6 +148,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,

It would be great if you converted the driver to new-style (that is
implementing .apply instead of .config, .enable, .disable and
.set_polarity). This usually simplifies the driver and maybe adding
support for v2 would be easier then, too.

>  	u64 val, div, rate;
>  	unsigned long prescale =3D PRESCALE_MIN, pc, dc;
>  	unsigned int value, chan =3D pwm->hwpwm;
> +	int ret;
>  =

>  	/*
>  	 * Find period count, duty count and prescale to suit duty_ns and
> @@ -156,7 +190,12 @@ static int kona_pwmc_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	 * validated immediately instead of on enable.
>  	 */
>  	if (pwm_is_enabled(pwm)) {
> -		kona_pwmc_prepare_for_settings(kp, chan);
> +		ret =3D kona_pwmc_prepare_for_settings(kp, chan);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "failed to prepare pwm settings: %d\n",
> +				ret);
> +			return ret;
> +		}
>  =

>  		value =3D readl(kp->base + PRESCALE_OFFSET);
>  		value &=3D ~PRESCALE_MASK(chan);
> @@ -167,7 +206,12 @@ static int kona_pwmc_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  =

>  		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
>  =

> -		kona_pwmc_apply_settings(kp, chan);
> +		ret =3D kona_pwmc_apply_settings(kp, chan);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "failed to apply settings: %d\n",
> +				ret);
> +			return ret;
> +		}
>  	}
>  =

>  	return 0;
> @@ -187,7 +231,11 @@ static int kona_pwmc_set_polarity(struct pwm_chip *c=
hip, struct pwm_device *pwm,
>  		return ret;
>  	}
>  =

> -	kona_pwmc_prepare_for_settings(kp, chan);
> +	ret =3D kona_pwmc_prepare_for_settings(kp, chan);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
> +		return ret;
> +	}
>  =

>  	value =3D readl(kp->base + PWM_CONTROL_OFFSET);
>  =

> @@ -198,7 +246,11 @@ static int kona_pwmc_set_polarity(struct pwm_chip *c=
hip, struct pwm_device *pwm,
>  =

>  	writel(value, kp->base + PWM_CONTROL_OFFSET);
>  =

> -	kona_pwmc_apply_settings(kp, chan);
> +	ret =3D kona_pwmc_apply_settings(kp, chan);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to apply pwm settings: %d\n", ret);
> +		return ret;
> +	}
>  =

>  	clk_disable_unprepare(kp->clk);
>  =

> @@ -231,8 +283,13 @@ static void kona_pwmc_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
>  	struct kona_pwmc *kp =3D to_kona_pwmc(chip);
>  	unsigned int chan =3D pwm->hwpwm;
>  	unsigned int value;
> +	int ret;
>  =

> -	kona_pwmc_prepare_for_settings(kp, chan);
> +	ret =3D kona_pwmc_prepare_for_settings(kp, chan);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
> +		return;
> +	}
>  =

>  	/* Simulate a disable by configuring for zero duty */
>  	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
> @@ -243,7 +300,11 @@ static void kona_pwmc_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
>  	value &=3D ~PRESCALE_MASK(chan);
>  	writel(value, kp->base + PRESCALE_OFFSET);
>  =

> -	kona_pwmc_apply_settings(kp, chan);
> +	ret =3D kona_pwmc_apply_settings(kp, chan);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
> +		return;
> +	}
>  =

>  	clk_disable_unprepare(kp->clk);
>  }
> @@ -256,14 +317,26 @@ static void kona_pwmc_disable(struct pwm_chip *chip=
, struct pwm_device *pwm)
>  	.owner =3D THIS_MODULE,
>  };
>  =

> +static const struct of_device_id bcm_kona_pwmc_dt[] =3D {
> +	{ .compatible =3D "brcm,kona-pwm", .data =3D (void *)KONA_PWM_V1},
> +	{ .compatible =3D "brcm,kona-pwm-v2", .data =3D (void *)KONA_PWM_V2},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
> +
>  static int kona_pwmc_probe(struct platform_device *pdev)
>  {
>  	struct kona_pwmc *kp;
>  	struct resource *res;
> +	const struct of_device_id *of_id;
>  	unsigned int chan;
>  	unsigned int value =3D 0;
>  	int ret =3D 0;
>  =

> +	of_id =3D of_match_node(bcm_kona_pwmc_dt, pdev->dev.of_node);
> +	if (!of_id)
> +		return -ENODEV;
> +
>  	kp =3D devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
>  	if (kp =3D=3D NULL)
>  		return -ENOMEM;
> @@ -276,6 +349,7 @@ static int kona_pwmc_probe(struct platform_device *pd=
ev)
>  	kp->chip.npwm =3D 6;
>  	kp->chip.of_xlate =3D of_pwm_xlate_with_flags;
>  	kp->chip.of_pwm_n_cells =3D 3;
> +	kp->version =3D (enum kona_pwmc_ver)of_id->data;
>  =

>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	kp->base =3D devm_ioremap_resource(&pdev->dev, res);
> @@ -322,12 +396,6 @@ static int kona_pwmc_remove(struct platform_device *=
pdev)
>  	return pwmchip_remove(&kp->chip);
>  }
>  =

> -static const struct of_device_id bcm_kona_pwmc_dt[] =3D {
> -	{ .compatible =3D "brcm,kona-pwm" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
> -
>  static struct platform_driver kona_pwmc_driver =3D {
>  	.driver =3D {
>  		.name =3D "bcm-kona-pwm",
> -- =

> 1.9.1
> =

> =


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
