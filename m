Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF03CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:46:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E40020C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nS2KmglV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E40020C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HZfCRi1Zs6WZuAMcvJimDsNdCyryrLRSGo9vnhKCk9U=; b=nS2KmglV2k28hwPSu/Khbk3PN
	MChOtgSOSNMwuXNij8edvBH7UcKfUkOdEQjaao+o5KxZ+m4yq03vmZIqZbS805fmrz14osMyFqjXX
	AWkU9R5kYa15eDjomjzcaSWyPLzes2/74cs/OnQAgvjeC5JXpGez2d5QP57cVEm5p4nGD2nrBihWA
	BtSn/dx1Yl1wvROTZsmG/6YKuGnuJDVWMP4TH9wMt07AndZYJDxrBgFds0W1vNHL6VqKGlh5Vio3T
	Dk9esHoyYw1SeDXw0QWti8ZEVRcjg2dP9VkddHc+Csthz4xcL7fLcXBLVoNn/5Bf6SqmIokWPmf1C
	yTnAeSBEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwRGr-0008MF-TK; Wed, 20 Feb 2019 12:46:41 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwRGo-0008Lm-90
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 12:46:40 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EFDF11BF204;
 Wed, 20 Feb 2019 12:46:23 +0000 (UTC)
Date: Wed, 20 Feb 2019 13:46:23 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Subject: Re: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
Message-ID: <20190220124623.ayurp2juq7dvxw64@flea>
References: <20190216182132.12895-1-mans@mansr.com>
 <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
 <20190220090617.aprfndnidcamwcvy@flea> <yw1x36oiybbl.fsf@mansr.com>
MIME-Version: 1.0
In-Reply-To: <yw1x36oiybbl.fsf@mansr.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_044638_466028_E4F61C9B 
X-CRM114-Status: GOOD (  17.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5114092502804404021=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5114092502804404021==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gutps5hnjkqh6r63"
Content-Disposition: inline


--gutps5hnjkqh6r63
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 20, 2019 at 10:59:58AM +0000, M=E5ns Rullg=E5rd wrote:
> Maxime Ripard <maxime.ripard@bootlin.com> writes:
>=20
> > On Wed, Feb 20, 2019 at 04:58:49PM +0800, Chen-Yu Tsai wrote:
> >> On Sun, Feb 17, 2019 at 2:21 AM Mans Rullgard <mans@mansr.com> wrote:
> >> >
> >> > This adds pinctrl settings for various missing uart options.
> >> >
> >> > Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> > ---
> >> >  arch/arm/boot/dts/sun7i-a20.dtsi | 45 +++++++++++++++++++++++++++++=
+++
> >> >  1 file changed, 45 insertions(+)
> >> >
> >> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/su=
n7i-a20.dtsi
> >> > index af5b067a5f83..2295ff5adf48 100644
> >> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> >> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> >> > @@ -944,6 +944,31 @@
> >> >                                 function =3D "uart0";
> >> >                         };
> >> >
> >> > +                       uart0_pf_pins: uart0-pf-pins {
> >> > +                               pins =3D "PF2", "PF4";
> >> > +                               function =3D "uart0";
> >> > +                       };
> >>=20
> >> We've had the policy of not adding pinctrl nodes that aren't used in-t=
ree,
> >> to avoid bloating up the blob size. However DTC 1.4.7 introduced the n=
ew
> >> /omit-if-no-ref/ directive, which would make the compiler discard mark=
ed
> >> nodes if they aren't referenced.
> >>=20
> >> So please add this to all the new nodes. It seems to work regardless w=
hether
> >> you add it before or after the label, though having it after the label=
 seems
> >> to make vim syntax highlighting happier.
>=20
> Should we also add this to existing nodes?

If you want to send an additional patch, then yes sure :)

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gutps5hnjkqh6r63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG1MHwAKCRDj7w1vZxhR
xSWWAQDUhhIzuMRsf2NWQ6TaNe4HvPVNtvT0VbRRjTbIKAXklwEAtcjMe4dwfTcu
3IviC/XLZMCLMXzqeo6JJ51w6iE5XQI=
=7rTZ
-----END PGP SIGNATURE-----

--gutps5hnjkqh6r63--


--===============5114092502804404021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5114092502804404021==--

