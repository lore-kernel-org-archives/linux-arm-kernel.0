Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FA4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 20:00:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4A5217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 20:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jmpysJAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4A5217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+vvoDPRItZ9MCIvssaWm9JT3X/tHKZyg2NEKcS/rGbA=; b=jmpysJAcbDTaOzCQ091d5uG9u
	Z/dJT1i7Pe0bvAo4O+jk6HNNiC12o1X2sSJEoeQN9FxLFVUCNv1CbKjAq7vo8KWHjVd54V+NWwdiB
	tHLmcAB0VdHijFXwDYkqB4NbtDdmTf8Enw1J/O9+0EHyt8ZbGqpE9dZuDmrqwfApQl9HvpaFbnnQ4
	hOtx2/6U3jkdUVdJbL9qb8HQGxFZZU6NEXDc9dYD9g0ITRNIaqgcfJD0yngy+J0aTRP7bzMFmZyYM
	CMotem5PXF+aGJS6RpDpmNJqOusi2NRCeoO5tCbA8hfj9sKRIxIn1uSzzIZ0Yro3CmJrrhV8Iyze6
	83cjWj/Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb9uo-0004xr-LY; Sun, 23 Dec 2018 19:59:58 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb9ul-0004xB-0q
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 19:59:57 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id ED91880897; Sun, 23 Dec 2018 20:59:33 +0100 (CET)
Date: Sun, 23 Dec 2018 20:59:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181223195937.GE15237@amd>
References: <20181217004450.GW6707@atomide.com> <20181223103315.GA1936@amd>
 <20181223111059.GB1936@amd> <20181223155147.GI6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181223155147.GI6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_115955_218234_30D11678 
X-CRM114-Status: GOOD (  15.25  )
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
Cc: Rob Herring <robh@kernel.org>, Marcel Partap <mpartap@gmx.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, omerlle@gmail.com,
 Merlijn Wajer <merlijn@wizzup.org>, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 NeKit <nekit1000@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Michael Scott <hashcode0f@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
Content-Type: multipart/mixed; boundary="===============0786780197805892010=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0786780197805892010==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-23 07:51:47, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181223 11:11]:
> > I added some printks to motmdm_probe, and they don't appear to be
> > called. I wonder if I'm missing something else in the config? I do
> > have serial
> >=20
> > root@devuan:/my/ko# ls -al /dev/ttyS0
> > crw-rw---- 1 root dialout 4, 64 Dec 23 11:52 /dev/ttyS0
> >=20
> > but not gsm multiplex:
> >=20
> > root@devuan:/my/ko# ls -al /dev/gsm*
> > ls: cannot access '/dev/gsm*': No such file or directory
>=20
> Hmm with serdev you should not get /dev/ttyS0, so maybe you're missing:
>=20
> CONFIG_SERIAL_DEV_BUS=3Dy
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=3Dy

I had those enabled.

I also have

CONFIG_SERIAL_OMAP=3Dy
CONFIG_SERIAL_OMAP_CONSOLE=3Dy

> Probably the Kconfig dependency should be for SERIAL_DEV_CTRL_TTYPORT
> instead of SERIAL_DEV_BUS in these patches if that helps.
>=20
> Or else you're missing the serdev related dts changes?

Thanks for the hints, but dts looks ok, too.

We still have
uart1: serial@0 {
   compatible =3D "ti,omap4-uart";

in omap4-l4.dtsi, right? ...

I see that CONFIG_SERIAL_OMAP=3Dy and 8250_omap handles same
hardware. Let me try disabling CONFIG_SERIAL_OMAP=3Dy.

Best regards,
								Pavel

Oh and you may want to apply this:

diff --git a/drivers/mfd/motorola-mdm.c b/drivers/mfd/motorola-mdm.c
index 2b7c324..2cdc9e8 100644
--- a/drivers/mfd/motorola-mdm.c
+++ b/drivers/mfd/motorola-mdm.c
@@ -1141,5 +1152,5 @@ module_serdev_device_driver(motmdm_driver);
=20
 MODULE_ALIAS("platform:motorola-mdm");
 MODULE_DESCRIPTION("Motorola Modem TS 27.010 serdev driver");
-MODULE_AUTHOR("Tony Lindgren <tony@atomide.com");
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_LICENSE("GPL v2");


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwf6SkACgkQMOfwapXb+vLc+QCfdzhtFpsJJdQyVDvOhFUBkjXB
UN0An3P/at06sNp/7TZ5GaTB+bYfIYyK
=ZCa/
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--


--===============0786780197805892010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0786780197805892010==--

