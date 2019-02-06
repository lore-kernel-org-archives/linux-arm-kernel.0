Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530BAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:24:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E531218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MGpPoFdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E531218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pAk0Syp1Kk6F4sAVsk6639WPzO4slWoHZFvBYDdh7j8=; b=MGpPoFdj0C0HPW
	/a7IRLVR6tCgW1vqG/Ryn/OeQXuJgx/79dTYi3jvhl+jH/9RfuGhjoq81qT2eIn/VgcrvRuorkJ33
	ch97fKaekU4HfcfdebH2TNgjm6CyJq7uacM38WRDjpJdr5MwIUfWZiHZ4RHjAzzwWJiL17J+/FLzm
	0YU1KKB8/jocZ8WYaZPK9JKXTmKQBaXHA8d8Vz0aTo+X0dRR7ov9a5S92ukvPZ2/v9qQqpJXcNxuC
	db6HoqjmJJNvOCDS2vMMr7GT18myl6ObZCMa0jiEScYP3D3dveGpwpNhCb7o1zLt68lwSVLaRHpOR
	kQW+c9FUnJ6vYzAYhy+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grIVm-00054F-1R; Wed, 06 Feb 2019 08:24:50 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grIVh-00053W-Ju
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 08:24:48 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1grIVV-0001Kn-Q9; Wed, 06 Feb 2019 09:24:33 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1grIVU-0002an-E2; Wed, 06 Feb 2019 09:24:32 +0100
Date: Wed, 6 Feb 2019 09:24:32 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Message-ID: <20190206082432.6imbcuwlxhtsw4s4@pengutronix.de>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
 <67e881c5-0ea7-3d2f-5910-534729097d11@microchip.com>
 <20190107221040.uos5qlnkjmcayv73@pengutronix.de>
 <20190205230125.GE1372@mithrandir>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190205230125.GE1372@mithrandir>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_002445_991099_41206948 
X-CRM114-Status: GOOD (  49.26  )
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
 Ludovic.Desroches@microchip.com, Claudiu.Beznea@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Thierry,

On Wed, Feb 06, 2019 at 12:01:26AM +0100, Thierry Reding wrote:
> On Mon, Jan 07, 2019 at 11:10:40PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jan 07, 2019 at 09:30:55AM +0000, Claudiu.Beznea@microchip.com =
wrote:
> > > On 05.01.2019 23:05, Uwe Kleine-K=F6nig wrote:
> > > > On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.=
com wrote:
> > > >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> > > >>
> > > >> Add basic PWM modes: normal and complementary. These modes should
> > > >> differentiate the single output PWM channels from two outputs PWM
> > > >> channels. These modes could be set as follow:
> > > >> 1. PWM channels with one output per channel:
> > > >> - normal mode
> > > >> 2. PWM channels with two outputs per channel:
> > > >> - normal mode
> > > >> - complementary mode
> > > >> Since users could use a PWM channel with two output as one output =
PWM
> > > >> channel, the PWM normal mode is allowed to be set for PWM channels=
 with
> > > >> two outputs; in fact PWM normal mode should be supported by all PW=
Ms.
> > > > =

> > > > I still think that my suggestion that I sent in reply to your v5 us=
ing
> > > > .alt_duty_cycle and .alt_offset is the better one as it is more gen=
eric.
> > > =

> > > I like it better my way, I explained myself why.
> > =

> > I couldn't really follow your argument though. You seemed to acknowledge
> > that using .alt_duty_cycle and .alt_offset is more generic. Then you
> > wrote that the push-pull mode is hardware generated on Atmel with some
> > implementation details. IMHO these implementation details shouldn't be
> > part of the PWM API and atmel's .apply should look as follows:
> > =

> > 	if (state->alt_duty_cycle =3D=3D 0) {
> > =

> > 		... configure for normal mode ...
> > =

> > 	} else if (state->duty_cycle =3D=3D state->alt_duty_cycle &&
> > 	           state->alt_offset =3D=3D state->period / 2) {
> > =

> > 		... configure for push pull mode ...
> > =

> > 	} else if (state->duty_cycle + state->alt_duty_cycle =3D=3D state->per=
iod &&
> > 		   state->alt_offset =3D=3D state->duty_cycle) {
> > =

> > 		... configure for complementary mode ...
> > =

> > 	} else {
> > 		return -EINVAL;
> > 	}
> > =

> > If it turns out to be a common pattern, we can add helper functions =E0=
 la
> > pwm_is_complementary_mode(state) and
> > pwm_set_complementary_mode(state, period, duty_cycle). This allows to
> > have a generic way to describe a wide range of wave forms in a uniform
> > way in the API (which is good) and each driver implements the parts of
> > this range that it can support.
> =

> I think this is going to be the rule rather than the exception, so I'd
> expect we'll see these helpers used in pretty much all drivers that
> support more than just the normal mode.

If you intended to contradict me here: You didn't. I have the same
expectation.

> But I really don't see the point in having consumers jump through hoops
> to set one of the standard modes just to have the driver jump through
> more hoops to determine which mode was meant.

I think my approach is more natural and not more complicated at all. In
all modes where this secondary output makes sense both outputs share the
period length. In all modes both outputs have a falling and a raising
edge each. Let's assume we support

 - normal mode (one output, secondary (if available) inactive)
 - complementary mode (secondary output is the inverse of primary
   output)
 - push-pull mode (primary output only does every second active phase,
   the secondy output does the ones that are skiped by the primary one)
 - complementary mode with deadtime (like above but there is a pause
   where both signals are inactive at the switch points, so the active
   phase of the secondary output is $deadtime_pre + $deadtime_post
   shorter than the primary output's inactive phase).

To describe these modes we need with the approach suggested by Claudiu
the following defines:

 enum mode {
 	NORMAL,
	COMPLEMENTARY,
	PUSH_PULL
	PUSH_PULL_WITH_DEADTIME
 }

 struct pwm_state {
 	unsigned int period;
	unsigned int duty_cycle;
	enum pwm_polarity polarity;
	bool enabled;
	enum mode mode;
	unsigned int deadtime_pre;
	unsigned int deadtime_post;
 }

This has the following downsides:

 - The period in push-pull mode is somehow wrong because the signal
   combination repeats only every 2x $period ns. (I guess this is an
   implementation detail of the atmel hardware that leaks into the API
   here.)

 - There is redundancy in the description:

   { .period =3D U, .duty_cycle =3D V, .polarity =3D W, .enabled =3D true, =
.mode =3D PUSH_PULL, .deadtime_pre =3D DC, .deadtime_post =3D DC }

   is the same as

   { .period =3D U, .duty_cycle =3D V, .polarity =3D W, .enabled =3D true, =
.mode =3D PUSH_PULL_WITH_DEADTIME, .deadtime_pre =3D 0, .deadtime_post =3D =
0 }

   .

This is all more sane with my suggestion, and pwm_state is smaller with
my approach. .period has always the same meaning and for a device that
supports secondary mode .alt_offset and .alt_period always have the same
semantic. (Opposed to .deadtime_X that only matter sometimes.)

Also I don't see hoops for the implementing pwm driver: Assume it only
supports normal and complementary mode. The difference is:

 - With Claudiu's approach:

	switch (state->mode) {
	case NORMAL:
		... do normal ...
		break;
	case COMPLEMENTARY:
		... do complementary ...
		break;
	default:
		return -ESOMETHING;
		break;
	}

 - with my approach:

	if (pwm_is_normal_mode(state) {
		... do normal ...
	} else if (pwm_is_complementary_mode(state) {
		.. do complementary ...
	} else {
		return -ESOMETHING;
	}

So I don't see a hoop apart from needed some pwm_is_XX_mode helpers in
the core. Moreover for a flexible hardware that supports the full range
(e.g. the hifive one where a driver is currently under discussion if
only one pwm cell is implemented as I suggested in my review) the
implementation is simpler with my approach it just looks as follows:

	configure(period, duty_cycle, alt_offset, alt_period)

instead of

	switch (state->mode) {
	case NORMAL:
		configure(period, duty_cycle, 0, 0);
		break;
	case COMPLEMENTARY:
		configure(period, duty_cycle, duty_cycle, period - duty_cycle);
		break;
	case PUSH_PULL:
		configure(2 * period, duty_cycle, period, duty_cycle);
		break;
	case PUSH_PULL_WITH_DEADTIME:
		configure(2 * period, duty_cycle, period + deadtime_pre,
			  duty_cycle - deadtime_pre - deadtime_post);
		break;
	default:
		return -ESOMETHING;
		break;
	}

> There are only so many modes and I have never seen hardware that
> actually implements the kind of fine-grained control that would be
> possible with your proposal.

That there is hardware that actually implements all the flexibility that
is available is second-order. (But as said above, the hifive
implementation can do it. And I think the ST implementation I saw some
time ago can do it, too; I didn't recheck though.) The key here is to
have a natural description of the intended waveform. And describing it
using a mode and additional parameters depending on the mode is more
complex than two additional parameters that can cover all waveforms.

That not all drivers can implement all waveforms that consumers might
request is common to both approaches.

> The goal of an API is to abstract, but .alt_duty_cycle and .alt_offset
> would be an inversion of API abstraction.

No, the goal of an API is to give a way that is easy and natural to let
consumers request all the stuff they might want. And if there is a
single set of parameters that describes a broad subset of waveforms with
parameters that you can measure in the wave form that is better than to
separate waveforms into categories (modes) and implement each of these
with their own parameter set. And then your categorisation might not
match the capabilities of some hardware. Consider a device that can
implement PUSH_PULL_WITH_DEADTIME but only with .deadtime_pre =3D
.deadtime_post.

That the API has to abstract is actually bad because it limits users.
If a consumer wants push-pull mode with dead time and the hardware
supports that but the API has abstracted that away, that's bad.
If a consumer doesn't care if the configured duty cycle is already
active when pwm_apply_state() returns or is only scheduled in the
hardware for after the current period ends, this forces a delay on the
consumer because the abstraction is that the configured wave form is
already on the wire on return.

Abstraction is necessary to cover different hardware implementations and
allow users to handle these in a uniform way. So from a consumer's POV
an abstraction that doesn't limit the accessible capabilities of the
hardware is optimal.

Using .alt_offset and .alt_period is an abstraction that limits less and
so gives more possibilities to the consumers.

> That is, we'd be requiring the drivers to abstract the inputs of the
> API, which is the wrong way around.

That is a normal "problem" for drivers. The driver gets a request and it
has to determine if it can implement that. And if this is done using a
comparison of .mode to known "good" values or by using a helper function
that compares .alt_offset to .period is an implementation detail that
doesn't matter much.

> > > > I don't repeat what I wrote there assuming you still remember or are
> > > > willing to look it up at
> > > > e.g. https://www.spinics.net/lists/linux-pwm/msg08174.html (in the =
2nd half
> > > > of my mail).
> > > =

> > > Yes, I remember it.
> > =

> > I expected that, my words were more directed to Thierry than you.
> >  =

> > > > Also I think that if the capabilities function is the way forward a=
dding
> > > > support to detect availability of polarity inversion should be
> > > > considered. =

> > > =

> > > Yep, why not. But it should be done in a different patch. It is not r=
elated
> > > to this series.
> > =

> > Yes, given that polarity already exists, this would be a good
> > opportunity to introduce the capability function for that and only
> > afterwards add the new use case with modes. (But having said this, read
> > further as I think that this capability function is a bad idea.)
> =

> I don't think we need to require this. The series is already big enough
> as it is and has been in the works for long enough. There's no harm in
> integrating polarity support into the capability function later on.

I think "the series is long enough in the works" is not an argument to
stop pointing out weaknesses. The harm that is done in not adding
polarity support now is that it adds another thing to the todo list of
things that are started a bit and need to be completed in the future.

And the harm in adding underdone stuff to an API if there are known
weaknesses is more work later.

> > > > This would also be an opportunity to split the introduction
> > > > of the capabilities function and the introduction of complementary =
mode.
> > > > (But my personal preference would be to just let .apply fail when an
> > > > unsupported configuration is requested.)
> > > =

> > > .apply fails when something wrong is requested.
> > =

> > If my controller doesn't support a second output is it "wrong" to
> > request complementary mode? I'd say yes. So you have to catch that in
> > .apply anyhow and there is little benefit to be able to ask the
> > controller if it supports it beforehand.
> > =

> > I don't have a provable statistic at hand, but my feeling is that quite
> > some users of the i2c frame work get it wrong to first check the
> > capabilities and only then try to use them. This is at least error prone
> > and harder to use than the apply function returning an error code.
> > And on the driver side the upside is to have all stuff related to which
> > wave form can be generated and which cannot is a single place. (Just
> > consider "inverted complementary mode". Theoretically this should work
> > if your controller supports complementary mode and inverted mode. If you
> > now have a driver for a controller that can do both, but not at the same
> > time, the separation gets ugly. OK, this is a constructed example, but
> > in my experience something like that happens earlier or later.)
> =

> I think capabilities are useful in order to be able to implement
> fallbacks in consumer drivers. Sure the same thing could be implemented
> by trying to apply one state first and then downgrade and retry on
> failure and so on, but sometimes it's more convenient to know what's
> possible and determine what's the correct solution upfront.

For me there is no big difference between:

	Oh, the driver cannot do inversed polarity, I have to come up
	with something else.

and

	Oh, the driver can only implement periods that are powers of two
	of the input clk, I have to come up with something else.

and

	Oh, I requested a duty cycle of 89 ns, but the hardware can only
	do 87 or 90 ns so I have to come up with something else.

With capabilities you can only cover the first of these. With an
approach similar to clk_round_rate you can easily cover all.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
