Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7C9C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:53:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D5820834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FnKAmMd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D5820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4+Bo0fYJRhZFv1CmexS6y/zpyaOJPLyrS04tNf6uYB0=; b=FnKAmMd+5R3auV
	3Q5B3TUpck/WVZ2p0TB34bxcI5FG9rmseb1jjUoVLK5kowv4aoUdbAEI37gEHW0dk4e9g/O/tm9v7
	x3wW0ZSWT4T6J9vjz41oXIC6B1xl6zfZAOq5zRf87KTb5CmnVRGfGWbU3EPl+VuEWsO+Nt55bFMLZ
	SWE6B/fMGqMXknK2ytnv5inwrf+ZgMkfd9KAcq9RK6TP/HxIRcUiX4qHy1y6EoG5bItD35ASQ2Xn/
	puft1yigOG2BaM2c51YXL2Wjqc+lzefZ5Ybg2vEVxVakD6l1iB9Ln40rMB7eNp8Iz1D5qqeHZbwXE
	2lXRB8tN1gJkCgniZHFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6S4-0000HE-TF; Tue, 04 Dec 2018 08:53:08 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6S1-0000Gk-GY
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:53:07 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gU6Rn-0008A9-Jp; Tue, 04 Dec 2018 09:52:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gU6Rm-0007Vc-Lk; Tue, 04 Dec 2018 09:52:50 +0100
Date: Tue, 4 Dec 2018 09:52:50 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v3 1/3] usb: chipidea: imx: support configuring for
 active low oc signal
Message-ID: <20181204085250.o4vaviz7ta43zpfo@pengutronix.de>
References: <20181204083131.12524-1-u.kleine-koenig@pengutronix.de>
 <20181204083131.12524-2-u.kleine-koenig@pengutronix.de>
 <ce751026-d61f-400e-cb5d-abd9d45dc05f@i2se.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ce751026-d61f-400e-cb5d-abd9d45dc05f@i2se.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_005305_707548_9EB1D45B 
X-CRM114-Status: GOOD (  24.45  )
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
Cc: Peter Chen <Peter.Chen@nxp.com>, devicetree@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, linux-usb@vger.kernel.org,
 Matthew Starr <mstarr@hedonline.com>, Rob Herring <robh+dt@kernel.org>,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Stefan,

On Tue, Dec 04, 2018 at 09:40:26AM +0100, Stefan Wahren wrote:
> Am 04.12.18 um 09:31 schrieb Uwe Kleine-K=F6nig:
> > The status quo on i.MX6 is that if "over-current-active-high" is
> > specified in the device tree this is configured as expected. If
> > the property is missing polarity isn't changed and so the
> > polarity is kept as setup by the bootloader. Reset default is
> > active high, so active low can only be used with help by the
> > bootloader. On i.MX7 it is similar, but there disabling of
> > over current detection has a similar inconsistency.
> >
> > This patch introduces a new property that allows to explicitly
> > configure for active low over current detection and consistently
> > sets this up. In the absence of an explicit configuration the
> > bit is kept as is. On i.MX7 over current detection is used unless
> > disabled in the device tree.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  |  5 ++--
> >  drivers/usb/chipidea/ci_hdrc_imx.c            | 16 ++++++++---
> >  drivers/usb/chipidea/ci_hdrc_imx.h            |  8 +++++-
> >  drivers/usb/chipidea/usbmisc_imx.c            | 28 ++++++++++++++-----
> >  4 files changed, 43 insertions(+), 14 deletions(-)
> >
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
> >  =

> >  Example:
> =

> thanks for making this configurable. But shouldn't this be a separate
> patch and reviewed by the devicetree guys?

I'm not sure about the separate patch part. My impression is it depends
on the maintainer if a change to the binding (opposed to the
introduction of a binding) should be separate or not.

But for the review you are right, I added the dt people to Cc for them
to comment. In v2 Matthew also noted that he would prefer to handle the
situation when both over-current-active-low and over-current-active-high
were given differently. I think we don't need that as this is a case of
"broken dt" and it doesn't matter much what is done then. (With my patch
we're configuring for active high in that case.) A feedback here would
be great, too.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
