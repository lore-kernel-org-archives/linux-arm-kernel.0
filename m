Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2406C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:39:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD20B20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OkIx8cZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD20B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hedonline.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CgqM5Nef6SxRPPEz/FcTPTKpMa5gQz5XNxAQnTiY/zI=; b=OkIx8cZbqKIU6C
	bms7NRBDDNf+dKagdfe3lYBfsa/sY0LjMj7zYuZ9m/2gZamLOH84RBZginXDhjnpOd8w+ck+hOuRE
	BAYEbUTdQs3irnN/D7CiBUOY9bdytqM2QxnmHF2dUWkMnnbz0O5T//G956hkBZwW/rs3FkaqyikYC
	k6vNhyIcDB9ISyaBzszeT1kCRhlvTx8fRTV72O6Jfr5zFusuuS0AjpeHqYsgAmoCNXptJxemSpk/J
	udMW9zWZisZoKaS4K1XJFdiWkkGfPvinlJtExWu5M4ThR8qm0pameSk+Zu6cn+KBAn55E0Gwnr6yj
	Qn2O1g8tcNVvqpDYlH+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsNk-0004Jw-RV; Fri, 30 Nov 2018 23:39:36 +0000
Received: from mail.hedonline.com ([12.133.124.242]
 helo=HED-Exchange.hed.local)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsNh-0004J7-5j
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:39:34 +0000
Received: from HED-EXCHANGE.hed.local ([fe80::4dca:ec11:8ab6:1fd3]) by
 HED-Exchange.hed.local ([fe80::4dca:ec11:8ab6:1fd3%21]) with mapi id
 14.03.0319.002; Fri, 30 Nov 2018 17:39:14 -0600
From: Matthew Starr <mstarr@hedonline.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Subject: RE: [PATCH] usb: chipidea: imx: unify over-current polarity handling
Thread-Topic: [PATCH] usb: chipidea: imx: unify over-current polarity handling
Thread-Index: AQHUiPH+Y7xFqbucCkiliBsV1+l8L6VpO7eA//+3QoA=
Date: Fri, 30 Nov 2018 23:39:13 +0000
Message-ID: <3C8219BAE02B894A9C69304A12E8AA06CA27C632@HED-Exchange.hed.local>
References: <20181130205309.17232-1-u.kleine-koenig@pengutronix.de>
 <CAOMZO5AE2Z6+7pYf6CaU0NK8TGBk+WtBBauLHZ-14w-_HLuX1g@mail.gmail.com>
 <20181130213445.5rvhkjukv4od6old@pengutronix.de>
In-Reply-To: <20181130213445.5rvhkjukv4od6old@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.1.90]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_153933_211931_3DD64D0D 
X-CRM114-Status: GOOD (  17.18  )
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
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]
> Sent: Friday, November 30, 2018 3:35 PM
> =

> Hello Fabio,
> =

> On Fri, Nov 30, 2018 at 07:16:39PM -0200, Fabio Estevam wrote:
> > [Adding Matt]
> >
> > On Fri, Nov 30, 2018 at 6:53 PM Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > The status quo is:
> > >  - on i.MX25 the overcurrent polarity is always explicitly configured=
 as
> > >    active high which matches the reset default.
> > >  - on i.MX6 and i.MX7 the overcurrent polarity is active high after
> > >    reset. usbmisc_imx6q_init() and usbmisc_imx7d_init() keep the curr=
ent
> > >    state (probably as setup by the bootloader or still the reset
> > >    default) unless the polarity is explicitly configured as active hi=
gh
> > >    which then is configured. (So if the pin is active low and the
> > >    bootloader didn't set this up the configuration is wrong.)
> > >
> > > To improve the situation always configure the reset default value unl=
ess
> > > the device tree configures the polarity (and then use this one).
> > >
> > > Note that as the reset default is active high on all platforms there =
is
> > > no need to check for the presence of "over-current-active-high". In t=
he
> > > absence of "over-current-active-low" it doesn't matter if active high=
 is
> > > configured because that's the default or because it is configured
> > > explicitly.
> > >
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >
> > It seems that Matt is also interested in adding the
> > 'over-current-active-low' property:
> > https://patchwork.kernel.org/patch/10701311/
> =

> Looking at Matt's patch I noticed that I applied my patch on an old
> kernel version (4.14) :-|
> =

> But I think Matt's patch is broken because in usbmisc_imx6q_init() in
> the last else branch MX6_BM_OVER_CUR_POLARITY isn't cleared. Other
> than
> that they don't look that different semantically.
> =

> I will respin my patch on Monday.
> =


Uwe,

You are correct that I missed the clearing of MX6_BM_OVER_CUR_POLARITY.

Also I don't see any reason why that last else that should clear MX6_BM_OVE=
R_CUR_POLARITY and MX6_BM_OVER_CUR_DIS shouldn't also be in the usbmisc_imx=
7d_init function too.

I just resubmitted my patch based on 4.20-rc4 with the mentioned changes.

Matt Starr

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
