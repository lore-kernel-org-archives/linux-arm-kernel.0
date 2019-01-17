Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A88C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:51:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54C520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hCaemX+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54C520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q2gy5e3vw/8sBzYmYZfrJKW/GK1cZivqjGAt/Lic1m0=; b=hCaemX+f/jJKl2Sq4Hq6v+tmO
	OYxVQpRO7Gco+dL32pJK3ubZm4O2IfZzMNaC1QRtrJBW8/RjEyuNgEA5vvbIpLL+UjqjcFBYONWW8
	z6QVbHBst8Hl+Qe1m5BwywnLh9XowPbsIp3YKhX9LcNOKS7ewBRawl7cF3arov8OY5E+js4utl3S2
	IBG3fiQ6m5jg6gUoewsIuPcti/wHAbuOmTcIIT+9HWvQ6mbbulgK61Yy+SltA2ZRZFSFjXVQXIjGE
	PNTm6btWspgu3HTCx47uSYdY1SnmqALizglYi3ih5OjZ5D+9Z3xbOIM8bzURZrhauawvxNc9agHGn
	XAKFYjzBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk790-0000GA-Su; Thu, 17 Jan 2019 12:51:38 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk78x-0000FW-6Z
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 12:51:37 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 552798070E; Thu, 17 Jan 2019 13:51:23 +0100 (CET)
Date: Thu, 17 Jan 2019 13:51:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20190117125128.GA17453@amd>
References: <20181217004450.GW6707@atomide.com> <20181218124616.GA10758@amd>
 <20181218153650.GA6707@atomide.com> <20181218202242.GA30831@amd>
 <20181218215311.GD6707@atomide.com> <20190116134823.GA10145@amd>
 <20190117025436.GR5544@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20190117025436.GR5544@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_045135_394047_1DB811BC 
X-CRM114-Status: GOOD (  13.05  )
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
Content-Type: multipart/mixed; boundary="===============3391203011331587390=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3391203011331587390==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > "quite trivial" does not mix with ofono. I did parts and it is still
> > not finished. At the moment, I do not have enough working SIM cards to
> > test everything. Feel free to help :-).
>=20
> I gave it a try but could only see "ofonod[14012]: motmdm init"
> on start up. Running test/list-modems shows only /stktest
> and no motmdm..
>=20
> Do I need to configure something in /etc/ofono?

No, that should not be needed. But you need this:

user@devuan:~$ cat /etc/udev/rules.d/55-modem.rules
KERNEL=3D=3D"ttyUSB4", ENV{OFONO_DRIVER}=3D"g1"

KERNEL=3D=3D"motmdm1", ENV{OFONO_DRIVER}=3D"motmdm"

(different devices for different branches of ofono), and it is useful
to run ofono like this:

sudo OFONO_AT_DEBUG=3D1 src/ofonod -d -n -p motmdm,udevng,atmodem,motorolam=
odem

=2E..to get right kind of debugging.

You then want to run enable-modem . online-modem is NOP, afaict.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxAelAACgkQMOfwapXb+vKzGACfVDXYNw2SZYWs3WFOEFtj6u1m
VP0AnieRH3ZQ5tfZSbakAcJmg0pzNsgi
=Pu8R
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--


--===============3391203011331587390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3391203011331587390==--

