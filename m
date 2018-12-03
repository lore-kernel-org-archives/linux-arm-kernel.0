Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6394C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:28:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A2221473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="omjPgVMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A2221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OlExI99+5mu06Yz2nsQZuqzh6Qr/jgwf5lzNs9+hvss=; b=omjPgVMZd5+qowED+rGs5P4fU
	MphNn9inOuzpRVu2r0t89hCzw2ppTRLvhxYT5iqD5ZmRs3/WIPWMKnSDg5UlpUz41Ca5nPkTqt3jE
	JJrImMpLbUf8trEOrtW2roLSKg7OaKiHdm66u/wlq4hGE7aldJ0hpt69wI4LTjc2bWoZcTcD/Uni0
	Ps161STRhBtdFV6sU54KSuQGIEhyH24Wegk1BcFpui3dhtYi48uo6ioydvc7EiwscOYkX+fy8Yq4K
	hRUUwe/dXN3Udie3B3DOeEaoPyHxojGNJssEpkBm93Culh4WQG8f72Jjr/Hvh8+KrADnw/k1Y6X5w
	tdNBB6mXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkWn-0007Mc-WF; Mon, 03 Dec 2018 09:28:34 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkWk-0007LQ-IW
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:28:32 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6EA76207B0; Mon,  3 Dec 2018 10:28:19 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 37D752039F;
 Mon,  3 Dec 2018 10:28:09 +0100 (CET)
Date: Mon, 3 Dec 2018 10:28:09 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Hao Zhang <hao5781286@gmail.com>
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner
 sun8i.
Message-ID: <20181203092809.mgeaxpwg6u4s23vq@flea>
References: <20181125161859.GA5277@arx-s1>
 <20181127075226.qo3mv3o6etqdjaop@flea>
 <20181127083523.pciie2gyaplrwiey@pengutronix.de>
 <20181127103253.ubbjjy2ji6sxc7xs@flea>
 <CAJeuY79RRzTqLpaXSe5d8TuNKGeQeYLbXraRVrZk9HBMYBf1+A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJeuY79RRzTqLpaXSe5d8TuNKGeQeYLbXraRVrZk9HBMYBf1+A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_012830_745903_DCDB8BC0 
X-CRM114-Status: GOOD (  19.09  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>,
 linux-sunxi@googlegroups.com, Stephen Boyd <sboyd@codeaurora.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-gpio@vger.kernel.org, wens@csie.org, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0638722765240913857=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0638722765240913857==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zznxkq7h2qi3betk"
Content-Disposition: inline


--zznxkq7h2qi3betk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

(Please keep all the recipiens in Cc)

On Sun, Dec 02, 2018 at 12:13:21AM +0800, Hao Zhang wrote:
> Maxime Ripard <maxime.ripard@bootlin.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=
=8827=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:33=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> > On Tue, Nov 27, 2018 at 09:35:23AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >
> > > On Tue, Nov 27, 2018 at 08:52:26AM +0100, Maxime Ripard wrote:
> > > > On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> > > > > +  - clocks: From common clock binding, handle to the parent cloc=
k.
> > > > > +  - clock-names: Must contain the clock names described just abo=
ve.
> > > >
> > > > [...]
> > > >
> > > > You seem to have used mux-0 and mux-1 for the clock names. I guess =
we
> > > > don't have to use a name there, we can simply use the position to f=
ind
> > > > out (as long as it's documented in the binding)
> > >
> > > I also wondered if the driver relies on the fact that the second clock
> > > is the faster running one. Is this sensible?
> >
> > Not really, I'm not sure we can make those expectations in the DT
> > binding, especially since clock rate can change at runtime.
>
> How about just add one clock on DT, most of the time, 24MHZ is enough
> (apb1 is 100MHZ)
> other one just use as a optional.
> clock rate change at runtime would make the same pair pwm channel
> uncontrollable,
> because previous one would be change by the new one different setting.

The DT is a hardware representation. If the hardware block can use
both clocks, it should be described.

Now, you can totally use only one clock of these 2 in your driver if that's
easier / more reasonable.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zznxkq7h2qi3betk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAT3KQAKCRDj7w1vZxhR
xQeYAQDbnRAmYhwUqiaSbkwrmQzprsqASJeNCuc1rI/hF22HsAD6A/smAChtdem8
w8QGGZGN16H/E9vHXpmuF6xCPL7VDgw=
=gmHJ
-----END PGP SIGNATURE-----

--zznxkq7h2qi3betk--


--===============0638722765240913857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0638722765240913857==--

