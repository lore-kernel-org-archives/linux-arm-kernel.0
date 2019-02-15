Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCF0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:23:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1805D21A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="moffPAY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1805D21A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=up3SOn03RK6dL/mryWKNiK4menJtTr0dF7hnF5411S8=; b=moffPAY5QdXSDo
	N8RpZufq50VELZBjMy0t0NVf7Ha2COk0HOmwmnfAdHlVsTzKWHX7Jkr81qFw8gElM8kNrSaEvJ0dj
	RWWfmOtOSCpoIiQqnqzMVzFAVQVv/i1wHhi4CZnIPkAY7f/lpEWS1+LSF9O7iv73sZsLNT0LagIwz
	JrEbng/x36VPfSHv/5SMHmFObU1jjuSwEoZTVX7xc37THQ/zzQwX+Tzg2n9Gj30wYrPIxkDN+YGKY
	9FZvtzSO1MOjjghLfxHbk0h1lS8TsWVupZW4mreuNziUR60TIwld8QNQiJnaK4iYVAMQPVXeLY7vX
	pZntKKvHCR+GegHSV+NA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guaeD-0002E2-Ua; Fri, 15 Feb 2019 10:23:09 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guaeA-0002Dg-SA
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 10:23:08 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1guadu-0006rX-9h; Fri, 15 Feb 2019 11:22:50 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1guads-0006Oy-2E; Fri, 15 Feb 2019 11:22:48 +0100
Date: Fri, 15 Feb 2019 11:22:48 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v3 3/3] pwm: core: add consumer device link
Message-ID: <20190215102248.i2mggrw74lgs2owq@pengutronix.de>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
 <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
 <f6fecafc-3946-9680-c58b-a20aa46e8e71@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f6fecafc-3946-9680-c58b-a20aa46e8e71@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_022307_074853_A5C20A33 
X-CRM114-Status: GOOD (  21.18  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 tduszyns@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 thierry.reding@gmail.com, linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com,
 fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 09:23:48AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> =

> =

> On 13.02.2019 12:50, Fabrice Gasnier wrote:
> > Add a device link between the PWM consumer and the PWM provider. This
> > enforces the PWM user to get suspended before the PWM provider. It
> > allows proper synchronization of suspend/resume sequences: the PWM user
> > is responsible for properly stopping PWM, before the provider gets
> > suspended: see [1]. Add the device link in:
> > - of_pwm_get()
> > - pwm_get()
> > - devm_ variants
> > as it requires a reference to the device for the PWM consumer.
> > =

> > [1] https://lkml.org/lkml/2019/2/5/770
> > =

> > Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> > Changes in v3:
> > - add struct device to of_get_pwm() arguments to handle device link from
> >   there.
> > ---
> >  drivers/pwm/core.c  | 14 +++++++++++---
> >  include/linux/pwm.h |  6 ++++--
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> > =

> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 1581f6a..8cb5d4bc 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -638,6 +638,7 @@ static struct pwm_chip *of_node_to_pwmchip(struct d=
evice_node *np)
> >  =

> >  /**
> >   * of_pwm_get() - request a PWM via the PWM framework
> > + * @dev: device for PWM consumer
> >   * @np: device node to get the PWM from
> >   * @con_id: consumer name
> >   *
> > @@ -655,7 +656,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct d=
evice_node *np)
> >   * Returns: A pointer to the requested PWM device or an ERR_PTR()-enco=
ded
> >   * error code on failure.
> >   */
> > -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_=
id)
> > +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *=
np,
> > +			      const char *con_id)
> >  {
> >  	struct pwm_device *pwm =3D NULL;
> >  	struct of_phandle_args args;
> > @@ -689,6 +691,9 @@ struct pwm_device *of_pwm_get(struct device_node *n=
p, const char *con_id)
> >  	if (IS_ERR(pwm))
> >  		goto put;
> >  =

> > +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER=
))
> > +		pr_debug("%s(): device link not added\n", __func__);
> > +
> =

> Just asking... will this mechanism also be working for PWMs requested via
> sysfs? At a first look it seems not.

No, but I would not expect a problem because AFAIU userspace is
suspended before kernel devices. However as userspace might not notice
the suspend it probably fails to stop the pwm and so will likely prevent
the suspend.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
