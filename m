Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05907C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:08:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD12B2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aYzdGgZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD12B2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7lKMFk2nm7rkk/13FITsaJqzdBgsf1Vu39As5DMkn2w=; b=aYzdGgZPRmlJ/e
	O2dDUmVSaXU6ohRyNYsbrd/Lyf3t8KR8A59b5tvHgVH1D2vR9hEUPVCp44dOwilBKNGWxZS7PXhsw
	HfBPucXuMr4Iggbu7TlqRqevlPqpql24f9/J43tx73o0Jri9xivCpRZwWt/tJJUQdrFPyqcKC9q27
	uPYHt8a37xjRxo573Heyn63vMJz8K9031yrdm/xn5vgkWRohPHtKj8cFb5z/lAZqfx9h1VTpAj2aN
	3GdX76CMjlbxcR//vHHJ6ikIaWRXQ9VcHHRNVOPRRWvhBgucy8H5aL8yag7qtBcOoc0QMfhj6qsnE
	wOtlV8dZOuirRx2JNXVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzYP-0003pO-6r; Tue, 08 Jan 2019 22:08:57 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzYK-0003oq-D9
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 22:08:54 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ggzY8-0001yS-Cz; Tue, 08 Jan 2019 23:08:40 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ggzY6-0002vf-Ug; Tue, 08 Jan 2019 23:08:38 +0100
Date: Tue, 8 Jan 2019 23:08:38 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Message-ID: <20190108220838.amrun6jsa24yeisg@pengutronix.de>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
 <67e881c5-0ea7-3d2f-5910-534729097d11@microchip.com>
 <20190107221040.uos5qlnkjmcayv73@pengutronix.de>
 <0ef0b4f1-45c3-0280-c1f0-6d499957f74c@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ef0b4f1-45c3-0280-c1f0-6d499957f74c@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_140852_600873_9D251EC5 
X-CRM114-Status: GOOD (  21.99  )
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
 Ludovic.Desroches@microchip.com, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 09:21:34AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Hi Uwe,
> =

> On 08.01.2019 00:10, Uwe Kleine-K=F6nig wrote:
> > Hello Claudiu,
> > =

> > On Mon, Jan 07, 2019 at 09:30:55AM +0000, Claudiu.Beznea@microchip.com =
wrote:
> >> On 05.01.2019 23:05, Uwe Kleine-K=F6nig wrote:
> >>> On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.co=
m wrote:
> >>>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>>>
> >>>> Add basic PWM modes: normal and complementary. These modes should
> >>>> differentiate the single output PWM channels from two outputs PWM
> >>>> channels. These modes could be set as follow:
> >>>> 1. PWM channels with one output per channel:
> >>>> - normal mode
> >>>> 2. PWM channels with two outputs per channel:
> >>>> - normal mode
> >>>> - complementary mode
> >>>> Since users could use a PWM channel with two output as one output PWM
> >>>> channel, the PWM normal mode is allowed to be set for PWM channels w=
ith
> >>>> two outputs; in fact PWM normal mode should be supported by all PWMs.
> >>>
> >>> I still think that my suggestion that I sent in reply to your v5 using
> >>> .alt_duty_cycle and .alt_offset is the better one as it is more gener=
ic.
> >>
> >> I like it better my way, I explained myself why.
> > =

> > I couldn't really follow your argument though. You seemed to acknowledge
> > that using .alt_duty_cycle and .alt_offset is more generic.
> =

> True it is more generic in the way that it gives the possibility to
> configure all kind of waveforms. But not all controllers supports this.
> The use case of this would be to have dead-times with any values, right?

Well, I didn't target that. The model I suggested is just a generic set
of parameters that are able to describe the wave forms for all three
modes you suggested. That it allows to express dead-times is just a nice
by-product.

> >>> I fail to see the upside of storing the mode as 2^mode instead of a
> >>> plain enum pwm_mode. Given that struct pwm_state is visible for pwm
> >>> users a plain pwm_mode would at least be more intuitive.
> >>
> >> To have all modes supported by a controller grouped in pwm_caps::modes=
_msk.
> > =

> > My question was not about struct pwm_caps::modes_msk but about
> > struct pwm_state::modebit. As struct pwm_state has visibility even
> > outside of the pwm API (i.e. it is used by consumers) it is beneficial
> > to keep that simple. Letting a consumer pass in the mode he wants is
> > easier to explain than setting a single bit. Also error checking with a
> > plain enum is easier because you just do:
> > =

> > 	if (mode >=3D MODE_CNT)
> > 		error()
> > =

> > which is easy to grasp. Compare that to
> > =

> > 	if (!is_power_of_two(modebit) || modebit >=3D PWM_MODE_BIT(CNT))
> > 		error()
> > =

> > (modulo syntactical correctness).
> =

> The reason I choose to have it as bit was the memcmp() at the beginning of
> pwm_apply_state() and to avoid starting enum pwm_mode from 1 and to avoid
> having bit 0 of pwm_caps::modes_msk unused (in the driver I'm using
> PWM_MODE_BIT() macro to fill in the driver's supported modes).

Does that mean you are convinced by my argument?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
