Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56044C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:35:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2302520663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r08I8FVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2302520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kAiC12R2LOOts72zU2Q5w5bVVg6Qm3DNXRX4T1ICZKM=; b=r08I8FVikGnIQ+
	Gvv80Hlp3+yPrQC9BxGM8gDtFCmt02lku+FO88DliGGunHqBMYq0SY1IXrHJm3CH7rJ4MmBT0G3xw
	TMd+c/6CRHw/7UlbJ3M3+lJZA3yzoZaQzIP0mFdtIb/ONZY+krbL0LsS+wu7e4SHqN10Xnoq5cm4u
	fb/A2cgMi/Gpr2B7GEEwfBN3JTwbH2175FP3nKH6OTtrWcbhz0XhK+Ta490JUPNkfcFcEAH2rbWP6
	1UWBRBO3fTWhGw8yKOJva0MfDpQa1wJa6xSp8ixNnPPexs9/DVoWj1ImRKuQwrcCHZ4HjR563/fLV
	ujsmr+QaffT0UR/1kXJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSqRR-0006ir-JQ; Fri, 30 Nov 2018 21:35:17 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSqRD-0005Es-RW
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 21:35:05 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gSqQx-0001mD-B3; Fri, 30 Nov 2018 22:34:47 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gSqQv-0006Od-KV; Fri, 30 Nov 2018 22:34:45 +0100
Date: Fri, 30 Nov 2018 22:34:45 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] usb: chipidea: imx: unify over-current polarity handling
Message-ID: <20181130213445.5rvhkjukv4od6old@pengutronix.de>
References: <20181130205309.17232-1-u.kleine-koenig@pengutronix.de>
 <CAOMZO5AE2Z6+7pYf6CaU0NK8TGBk+WtBBauLHZ-14w-_HLuX1g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMZO5AE2Z6+7pYf6CaU0NK8TGBk+WtBBauLHZ-14w-_HLuX1g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_133504_064067_15C22B2D 
X-CRM114-Status: GOOD (  17.85  )
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
Cc: Peter Chen <Peter.Chen@nxp.com>, USB list <linux-usb@vger.kernel.org>,
 Matthew Starr <mstarr@hedonline.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Fabio,

On Fri, Nov 30, 2018 at 07:16:39PM -0200, Fabio Estevam wrote:
> [Adding Matt]
> =

> On Fri, Nov 30, 2018 at 6:53 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > The status quo is:
> >  - on i.MX25 the overcurrent polarity is always explicitly configured as
> >    active high which matches the reset default.
> >  - on i.MX6 and i.MX7 the overcurrent polarity is active high after
> >    reset. usbmisc_imx6q_init() and usbmisc_imx7d_init() keep the current
> >    state (probably as setup by the bootloader or still the reset
> >    default) unless the polarity is explicitly configured as active high
> >    which then is configured. (So if the pin is active low and the
> >    bootloader didn't set this up the configuration is wrong.)
> >
> > To improve the situation always configure the reset default value unless
> > the device tree configures the polarity (and then use this one).
> >
> > Note that as the reset default is active high on all platforms there is
> > no need to check for the presence of "over-current-active-high". In the
> > absence of "over-current-active-low" it doesn't matter if active high is
> > configured because that's the default or because it is configured
> > explicitly.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> =

> It seems that Matt is also interested in adding the
> 'over-current-active-low' property:
> https://patchwork.kernel.org/patch/10701311/

Looking at Matt's patch I noticed that I applied my patch on an old
kernel version (4.14) :-|

But I think Matt's patch is broken because in usbmisc_imx6q_init() in
the last else branch MX6_BM_OVER_CUR_POLARITY isn't cleared. Other than
that they don't look that different semantically.

I will respin my patch on Monday.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
