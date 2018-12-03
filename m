Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A44AC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:22:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A3E20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WuNZn9C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A3E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=19kc33D7nnC727psVWowhlsWiqBVC/PT3xqgh/qfWB8=; b=WuNZn9C9tf87Vx
	pHYAw2B98LXQZtHbXUx6C/bsSP3v6WEa2AJvRWx2x7Y4L7P4NSv8wWDX8hiTWmXFvEHysYPMF5flB
	89tiVKEpvQ0TWTA3+gQXnh0+huptBP3cbHP+wwZmVonUGzjXnbPwcOW0wPJNqkqHYJzZc23ZWd9yX
	Ia8fmcKjgErhjezWT0agzWUes1nt+6n0xZ5FSCaKP0O9dDh6g++PiHQkk4ETQgnOCkSkloqvyX8pu
	Kv8yA/5L4TtiucthKapiscBsSsznRyk0SlgCe1sZ7AzVVR5ptCuxcTgumG19DRPzzhKYe7PmOU9yr
	tpWVO1mYtbvNhE8Jbx3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrvI-0000DI-LJ; Mon, 03 Dec 2018 17:22:20 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrvE-0008UK-Q2
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:22:19 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gTruz-0003o1-0r; Mon, 03 Dec 2018 18:22:01 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gTruy-0001Ec-5s; Mon, 03 Dec 2018 18:22:00 +0100
Date: Mon, 3 Dec 2018 18:22:00 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthew Starr <mstarr@hedonline.com>
Subject: Re: [PATCH v2 1/3] usb: chipidea: imx: support configuring for
 active low oc signal
Message-ID: <20181203172200.eqevdnpdpiihszq7@pengutronix.de>
References: <20181202213325.26017-1-u.kleine-koenig@pengutronix.de>
 <3C8219BAE02B894A9C69304A12E8AA06CA27CE67@HED-Exchange.hed.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3C8219BAE02B894A9C69304A12E8AA06CA27CE67@HED-Exchange.hed.local>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_092217_113892_5021C177 
X-CRM114-Status: GOOD (  25.74  )
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
Cc: Peter Chen <Peter.Chen@nxp.com>, Rob Herring <robh@kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 04:10:37PM +0000, Matthew Starr wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]
> > Sent: Sunday, December 02, 2018 3:33 PM
> > =

> > The status quo on i.MX6 is that if "over-current-active-high" is
> > specified in the device tree this is configured as expected. If
> > the property is missing polarity isn't changed and so the
> > polarity is kept as setup by the bootloader. Reset default is
> > active high, so active low can only be used with help by the
> > bootloader. On i.MX7 it is similar, but there disabling of
> > over current detection has a similar inconsistency.
> > =

> > This patch introduces a new property that allows to explicitly
> > configure for active low over current detection and consistently
> > sets this up. In the absence of an explicit configuration the
> > bit is kept as is. On i.MX7 over current detection is used unless
> > disabled in the device tree.
> > =

> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  |  5 ++--
> >  drivers/usb/chipidea/ci_hdrc_imx.c            |  9 ++++--
> >  drivers/usb/chipidea/ci_hdrc_imx.h            |  8 +++++-
> >  drivers/usb/chipidea/usbmisc_imx.c            | 28 ++++++++++++++-----
> >  4 files changed, 38 insertions(+), 12 deletions(-)
> > =

> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/D=
ocumentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > index 529e51879fb2..c32f6e983cf6 100644
> > --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > @@ -87,8 +87,9 @@ i.mx specific properties
> >  - fsl,usbmisc: phandler of non-core register device, with one
> >    argument that indicate usb controller index
> >  - disable-over-current: disable over current detect
> > -- over-current-active-high: over current signal polarity is high activ=
e,
> > -  typically over current signal polarity is low active.
> > +- over-current-active-low: over current signal polarity is active low.
> > +- over-current-active-high: over current signal polarity is active hig=
h.
> > +  It's recommended to specify the over current polarity.
> >  - external-vbus-divider: enables off-chip resistor divider for Vbus
> > =

> >  Example:
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/=
ci_hdrc_imx.c
> > index 09b37c0d075d..80b4e4ef9b68 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > @@ -135,8 +135,13 @@ static struct imx_usbmisc_data *usbmisc_get_init_d=
ata(struct device *dev)
> >  	if (of_find_property(np, "disable-over-current", NULL))
> >  		data->disable_oc =3D 1;
> > =

> > -	if (of_find_property(np, "over-current-active-high", NULL))
> > -		data->oc_polarity =3D 1;
> > +	if (of_find_property(np, "over-current-active-high", NULL)) {
> > +		data->oc_pol_active_low =3D 0;
> > +		data->oc_pol_configured =3D 1;
> > +	} else if (of_find_property(np, "over-current-active-low", NULL)) {
> > +		data->oc_pol_active_low =3D 1;
> > +		data->oc_pol_configured =3D 1;
> > +	}
> =

> Since both over-current-active-high and over-current-active-low can be
> enabled, the error case of when both are in the device tree is not
> covered here.  An error or warning should be given.  Also in this case
> the safest thing to do would be to leave the OC polarity bit alone and
> leave it the way it was set by the bootloader.

Given that it obviously cannot describe the hardware correctly when both
(over-current-active-high and over-current-active-low) are given it is
IMHO ok to do anything in this case. In my eyes that's similar to the C
language where the compiler is free to do whatever it seems fit when the
programmer does something unspecified.

Added Rob to Cc, maybe he can comment.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
