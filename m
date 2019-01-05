Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F548C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:05:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCB72231B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EQYarQtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCB72231B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TlVS+BRn/Ni2o5k/lI1fgk/EutvrmgtvNklAnuOFMyU=; b=EQYarQtrdPVjZT
	P7HVytLpVrNJq/n2JZmZD4C3zCHOZKSaYo6W7Yx7no5r4E3Qel9nIy4x0tuHJmjNMsxht6fdKQ8l6
	D1JPsDNsosZ2PU0FOmXTQ6eptHpkAP4Fs8E0tjwRS5Uj4eDKityMHZbhKebXu+qbbV1udC9zMsANK
	oOTDux2Kf8S0+QfywhSAjauh6kJYY6rlakNDtvSui6dRrUUu1k3NB+2ANJAnuLuf8uFPmeTz2/1Ch
	vximMS3x+BRHVxviwzsNO5iX+jJWto0tKJMpyEo1vAVZ6OXUf00LeMmfF/SfW/i71QEXpcf62zy/+
	PE6jFgcEHw/wERRAL9nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gft8R-0002zz-Tm; Sat, 05 Jan 2019 21:05:35 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gft8N-0002yx-Kb
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 21:05:34 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gft8F-0004tL-M5; Sat, 05 Jan 2019 22:05:23 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gft8E-00086A-C5; Sat, 05 Jan 2019 22:05:22 +0100
Date: Sat, 5 Jan 2019 22:05:22 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu.Beznea@microchip.com, thierry.reding@gmail.com
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Message-ID: <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_130531_833236_781A4982 
X-CRM114-Status: GOOD (  15.67  )
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
Cc: linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> =

> Add basic PWM modes: normal and complementary. These modes should
> differentiate the single output PWM channels from two outputs PWM
> channels. These modes could be set as follow:
> 1. PWM channels with one output per channel:
> - normal mode
> 2. PWM channels with two outputs per channel:
> - normal mode
> - complementary mode
> Since users could use a PWM channel with two output as one output PWM
> channel, the PWM normal mode is allowed to be set for PWM channels with
> two outputs; in fact PWM normal mode should be supported by all PWMs.

I still think that my suggestion that I sent in reply to your v5 using
.alt_duty_cycle and .alt_offset is the better one as it is more generic.
A word about that from Thierry before putting the mode into the pwm API
would be great.

I don't repeat what I wrote there assuming you still remember or are
willing to look it up at
e.g. https://www.spinics.net/lists/linux-pwm/msg08174.html (in the 2nd half
of my mail).

Also I think that if the capabilities function is the way forward adding
support to detect availability of polarity inversion should be
considered. This would also be an opportunity to split the introduction
of the capabilities function and the introduction of complementary mode.
(But my personal preference would be to just let .apply fail when an
unsupported configuration is requested.)

> +static int pwm_get_default_caps(struct pwm_caps *caps)
> +{
> +	static const struct pwm_caps default_caps =3D {
> +		.modes_msk =3D PWM_MODE_BIT(NORMAL),
> +	};
> +
> +	if (!caps)
> +		return -EINVAL;
> +
> +	*caps =3D default_caps;
> +
> +	return 0;
> +}
> +
> +/**
> + * pwm_get_caps() - get PWM capabilities of a PWM device
> + * @pwm: PWM device to get the capabilities for
> + * @caps: returned capabilities
> + *
> + * Returns: 0 on success or a negative error code on failure
> + */
> +int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps)
> +{
> +	if (!pwm || !caps)
> +		return -EINVAL;
> +
> +	if (pwm->chip->ops->get_caps)
> +		return pwm->chip->ops->get_caps(pwm->chip, pwm, caps);
> +
> +	return pwm_get_default_caps(caps);

I'd drop pwm_get_default_caps (unless you introduce some more callers
later) and fold its implementation into pwm_get_caps.

> +}
> +EXPORT_SYMBOL_GPL(pwm_get_caps);
> [...]
> @@ -53,12 +75,14 @@ enum {
>   * @period: PWM period (in nanoseconds)
>   * @duty_cycle: PWM duty cycle (in nanoseconds)
>   * @polarity: PWM polarity
> + * @modebit: PWM mode bit
>   * @enabled: PWM enabled status
>   */
>  struct pwm_state {
>  	unsigned int period;
>  	unsigned int duty_cycle;
>  	enum pwm_polarity polarity;
> +	unsigned long modebit;

I fail to see the upside of storing the mode as 2^mode instead of a
plain enum pwm_mode. Given that struct pwm_state is visible for pwm
users a plain pwm_mode would at least be more intuitive.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
