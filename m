Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857D5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:49:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5238B2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YzPSJEMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5238B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bOgB4SbVm8dxwbouNr8LsI6wCG+wKMMwPDu+Z3XAKnE=; b=YzPSJEMKPKR93L
	zG4YJ6q5PFGxH4+YXn2FfnIzVjDK5wXG87FBNl1P08WRkVqhC+53sxuKk/5Kj/tCtswBViLxNlpsD
	29D3nLXE9SGIRaQV/qlfJUl4d3n6sYHYpNuDVYBJv3MtIqYHZmzuxPLBr1CPKdW38zSCmXdgdFNYB
	VMrlIUr8kbOTD9PvHoXfgkhYYk+GBFuS76ew4WaHSSHIakPSTnPOX39Kai0GFP2dNSEkvkvYZOwwa
	ZedW9F8hg8n6VNPjJd6DepyDwYq47JtCPWtAAGeBnCN2jByYi50H189tgo8TKIEz6jS5ZMaCQfGKo
	pEao7l1IYgVLTDzpgU6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkrA-0000ha-Tg; Mon, 03 Dec 2018 09:49:36 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkr1-0000NW-SZ
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:49:34 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gTkqk-0007kI-En; Mon, 03 Dec 2018 10:49:10 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gTkqi-0000Mw-3M; Mon, 03 Dec 2018 10:49:08 +0100
Date: Mon, 3 Dec 2018 10:49:08 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Hao Zhang <hao5781286@gmail.com>
Subject: Re: [PATCH v3 6/6] ARM: PWM: add allwinner sun8i R40/T3/V40 PWM
 support.
Message-ID: <20181203094908.lga2r56gelaghrej@pengutronix.de>
References: <20181125162319.GA5422@arx-s1>
 <20181126213158.q5m5bbwnmewud2gb@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181126213158.q5m5bbwnmewud2gb@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_014928_643443_5031F999 
X-CRM114-Status: GOOD (  12.66  )
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
 linux-gpio@vger.kernel.org, maxime.ripard@bootlin.com, mturquette@baylibre.com,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, sboyd@kernel.org, wens@csie.org, robh+dt@kernel.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Mon, Nov 26, 2018 at 10:31:58PM +0100, Uwe Kleine-K=F6nig wrote:
> > +static int sun8i_pwm_config(struct sun8i_pwm_chip *sun8i_pwm, u8 ch,
> > +			    struct pwm_state *state)
> > +{
> > +[...]
> > +		clk_rate =3D clk_get_rate(clk);
> > +		val =3D state->period * clk_rate;
> > +		do_div(val, NSEC_PER_SEC);
> > +		if (val <=3D 1) {
> > +			dev_err(sun8i_pwm->chip.dev,
> > +				"Period expects a larger value\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		/* change clock source to "mux-1" */
> > +		clk_disable_unprepare(sun8i_pwm->clk);
> > +		devm_clk_put(sun8i_pwm->chip.dev, sun8i_pwm->clk);
> > +		sun8i_pwm->clk =3D clk;
> =

> sun8i_pwm is shared for all 8 PWMs, right? So if you assign mux-1 here
> for the second mux, how does this influence the first PWM?

To clearify my question:

after the first pwm is used and enabled (maybe using mux-0) changing
sun8i_pwm->clk for the second pwm is broken because then when the first
pwm is disabled the wrong clock is stopped.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
