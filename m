Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8078C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:39:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893B92184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hmMAOJTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893B92184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=t8RED/lFh0dQ9ipFMHABCq7IucawCJ81DNwJ0TxYrWI=; b=hmMAOJTLYW/CO9qKA4HWyZ1j+
	2x/VxbkQmeppYV0dxK8xO/Zia7GB8Hc2yNJQkxp+EsNTvFZd8pxuHr6elGm2uOGX0giHF/x4BGCHD
	AcOS52vRCuU4aZ+8CeEiAghzArSq65jTvZ35I2uvGO/bqiD4Cjcp8hHyf5n8EfNLdoOvTiWDx1dZn
	YaERq6/newdDu8WOKHL19CgtY9iMkJAvQsVxNmjgMlJtiKHN814NU2eopYUcbu3CH/bThE825d+1u
	JFKOYmkieihBFrouiFQLxsOfw1WzP0MxlOCFrCHSsexbdh2rVNiv75ku+GNmk83yulWmYz1yaHdcT
	ikbAr4c6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTak-0006wZ-BX; Tue, 12 Feb 2019 08:38:58 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTag-0006vn-8Y
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:38:56 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 050F91BF207;
 Tue, 12 Feb 2019 08:38:50 +0000 (UTC)
Date: Tue, 12 Feb 2019 09:38:50 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
Message-ID: <20190212083850.7genwc6ipnxtl7eo@flea>
References: <20190211111245.GA18147@lst.de>
 <E1gtBlV-0000Wl-Cv@stardust.g4.wien.funkfeuer.at>
 <20190211153945.e34fpwkuk67l7lc6@flea>
 <E1gtHJj-0000iY-G8@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
In-Reply-To: <E1gtHJj-0000iY-G8@stardust.g4.wien.funkfeuer.at>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_003854_447865_47B22E69 
X-CRM114-Status: GOOD (  14.43  )
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
 info@olimex.com, Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, ibu@radempa.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7772432879733703169=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7772432879733703169==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mbfotkrj5qb4aubt"
Content-Disposition: inline


--mbfotkrj5qb4aubt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 08:32:35PM +0100, Harald Geyer wrote:
> > We want to model this properly. I guess using a pinctrl driver
> > controlled through GPIO (similar to what regulator-gpio is) would be a
> > good first step.
>=20
> I considered this too, but didn't like it:
>=20
> 1) Seems like a bit of overkill.
>
> 2) The HW at hand is a rather different kind of multiplexer than
> what pinctrl assumes. We don't want two mutually exclusive devices,
> (Ie don't make the kernel unbind /dev/console for the sake of audio.)
> but we want switch the jack between two devices, that might both be
> active at the same time. This looks more like the channel multiplexers
> used with many ADCs and such. I guess, I could start a new subsystem
> around this. Seems like even more overkill.

I'm not quite sure about how that's different from what pinctrl
assumes. pinctrl assumes to handle devices that have multiple signals
as input, and one as output. Isn't that exactly what you have?

And pinctrl can be used dynamically as well if you need to

> Instead I just got the original patch working, by implementing
> "output-high" DT property in sunxi-pinctrl. I'll send a patch for
> review soon.

What do you want to do with output-high exactly?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mbfotkrj5qb4aubt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGKGGgAKCRDj7w1vZxhR
xYuZAQCp23Sdst8xXZYRMCqrva1rMoo7KVAz/EnclmklBSRcBwEAlMhswxQCB6Dp
RricCHumMDXZn3wRD/p4F0DLvdczYA4=
=+Dq1
-----END PGP SIGNATURE-----

--mbfotkrj5qb4aubt--


--===============7772432879733703169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7772432879733703169==--

