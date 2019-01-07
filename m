Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016C7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:10:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55722147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JfvFijYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55722147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X2jGhdRlLURUqi5IyrgT0TkC86SL9FYXqPhLIBDq4cA=; b=JfvFijYCFTaWZ0
	olFTnvnI3pZOPxMztEjwnUwJSrfekJ++GZcioH1cFLUZhOaRFg2fB0NRW4AhWrZYWJdCc8t35Np3T
	vIJFXBAIUR2QAxQBOy8zGy5Iisg5rZlpfP0BrwzdNbA4pHJvS5mbVtSCh1TLyNLN4QIcomu/xaQsX
	JbmD58E9Fwcq/TheN9CyY5wS8TTpXKzmu4vdrtWNTw7EM1jqK/aVzTw8HxBzGON4dGtowZEHEehgH
	s0JJErlwIvK+02rqZFtsU0cIi8e9q3/WHaObE2THgSEdxKV1Rm/oW303q7gWKr7JR3n5U2PM57XcZ
	COx/q4HoWgeITp7hPI+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggd6m-0002jZ-O0; Mon, 07 Jan 2019 22:10:56 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggd6i-0002ih-U7
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 22:10:55 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ggd6Y-00078D-46; Mon, 07 Jan 2019 23:10:42 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ggd6W-0008NU-Ow; Mon, 07 Jan 2019 23:10:40 +0100
Date: Mon, 7 Jan 2019 23:10:40 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Message-ID: <20190107221040.uos5qlnkjmcayv73@pengutronix.de>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
 <67e881c5-0ea7-3d2f-5910-534729097d11@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <67e881c5-0ea7-3d2f-5910-534729097d11@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_141053_130160_728D64B0 
X-CRM114-Status: GOOD (  27.01  )
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
Cc: linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Claudiu,

On Mon, Jan 07, 2019 at 09:30:55AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 05.01.2019 23:05, Uwe Kleine-K=F6nig wrote:
> > On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.com =
wrote:
> >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>
> >> Add basic PWM modes: normal and complementary. These modes should
> >> differentiate the single output PWM channels from two outputs PWM
> >> channels. These modes could be set as follow:
> >> 1. PWM channels with one output per channel:
> >> - normal mode
> >> 2. PWM channels with two outputs per channel:
> >> - normal mode
> >> - complementary mode
> >> Since users could use a PWM channel with two output as one output PWM
> >> channel, the PWM normal mode is allowed to be set for PWM channels with
> >> two outputs; in fact PWM normal mode should be supported by all PWMs.
> > =

> > I still think that my suggestion that I sent in reply to your v5 using
> > .alt_duty_cycle and .alt_offset is the better one as it is more generic.
> =

> I like it better my way, I explained myself why.

I couldn't really follow your argument though. You seemed to acknowledge
that using .alt_duty_cycle and .alt_offset is more generic. Then you
wrote that the push-pull mode is hardware generated on Atmel with some
implementation details. IMHO these implementation details shouldn't be
part of the PWM API and atmel's .apply should look as follows:

	if (state->alt_duty_cycle =3D=3D 0) {

		... configure for normal mode ...

	} else if (state->duty_cycle =3D=3D state->alt_duty_cycle &&
	           state->alt_offset =3D=3D state->period / 2) {

		... configure for push pull mode ...

	} else if (state->duty_cycle + state->alt_duty_cycle =3D=3D state->period =
&&
		   state->alt_offset =3D=3D state->duty_cycle) {

		... configure for complementary mode ...

	} else {
		return -EINVAL;
	}

If it turns out to be a common pattern, we can add helper functions =E0 la
pwm_is_complementary_mode(state) and
pwm_set_complementary_mode(state, period, duty_cycle). This allows to
have a generic way to describe a wide range of wave forms in a uniform
way in the API (which is good) and each driver implements the parts of
this range that it can support.

> > I don't repeat what I wrote there assuming you still remember or are
> > willing to look it up at
> > e.g. https://www.spinics.net/lists/linux-pwm/msg08174.html (in the 2nd =
half
> > of my mail).
> =

> Yes, I remember it.

I expected that, my words were more directed to Thierry than you.
 =

> > Also I think that if the capabilities function is the way forward adding
> > support to detect availability of polarity inversion should be
> > considered. =

> =

> Yep, why not. But it should be done in a different patch. It is not relat=
ed
> to this series.

Yes, given that polarity already exists, this would be a good
opportunity to introduce the capability function for that and only
afterwards add the new use case with modes. (But having said this, read
further as I think that this capability function is a bad idea.)

> > This would also be an opportunity to split the introduction
> > of the capabilities function and the introduction of complementary mode.
> > (But my personal preference would be to just let .apply fail when an
> > unsupported configuration is requested.)
> =

> .apply fails when something wrong is requested.

If my controller doesn't support a second output is it "wrong" to
request complementary mode? I'd say yes. So you have to catch that in
.apply anyhow and there is little benefit to be able to ask the
controller if it supports it beforehand.

I don't have a provable statistic at hand, but my feeling is that quite
some users of the i2c frame work get it wrong to first check the
capabilities and only then try to use them. This is at least error prone
and harder to use than the apply function returning an error code.
And on the driver side the upside is to have all stuff related to which
wave form can be generated and which cannot is a single place. (Just
consider "inverted complementary mode". Theoretically this should work
if your controller supports complementary mode and inverted mode. If you
now have a driver for a controller that can do both, but not at the same
time, the separation gets ugly. OK, this is a constructed example, but
in my experience something like that happens earlier or later.)

> >> [...]
> >> @@ -53,12 +75,14 @@ enum {
> >>   * @period: PWM period (in nanoseconds)
> >>   * @duty_cycle: PWM duty cycle (in nanoseconds)
> >>   * @polarity: PWM polarity
> >> + * @modebit: PWM mode bit
> >>   * @enabled: PWM enabled status
> >>   */
> >>  struct pwm_state {
> >>  	unsigned int period;
> >>  	unsigned int duty_cycle;
> >>  	enum pwm_polarity polarity;
> >> +	unsigned long modebit;
> > =

> > I fail to see the upside of storing the mode as 2^mode instead of a
> > plain enum pwm_mode. Given that struct pwm_state is visible for pwm
> > users a plain pwm_mode would at least be more intuitive.
> =

> To have all modes supported by a controller grouped in pwm_caps::modes_ms=
k.

My question was not about struct pwm_caps::modes_msk but about
struct pwm_state::modebit. As struct pwm_state has visibility even
outside of the pwm API (i.e. it is used by consumers) it is beneficial
to keep that simple. Letting a consumer pass in the mode he wants is
easier to explain than setting a single bit. Also error checking with a
plain enum is easier because you just do:

	if (mode >=3D MODE_CNT)
		error()

which is easy to grasp. Compare that to

	if (!is_power_of_two(modebit) || modebit >=3D PWM_MODE_BIT(CNT))
		error()

(modulo syntactical correctness).

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
