Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE859C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 11:11:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9123121903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 11:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OmuNqjBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9123121903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=c7vlEscxE67gFJUJ5Oh+MnMv3xUvUAD40GhE4UbzKbY=; b=OmuNqjBcFea/N/tacJQ0LAh3r
	LeBmnVRv1Wva8aj53M3BFN0elD6wqDF7ZqITdUW6luQc/FrU0nMJHEYNjfP9wZ5K458yM5Csfax4r
	i7R7GUjW/NjugsuojclOB6SMNcS/WZ+kmNF0iBTpD0KcNNcOWVZTTh24QDEqzRyqf5bQQfrAQPIJD
	4WzhZkTmSloaZJYgAECpo4D6nQ17xh+ilcaVVrBf2V0YsVJSTeiEFBYEOXuAGOJDqp78vC8wecMzc
	VPcvTnTphg2fXuDQ7gRFd1ppE6WY2jWiwMqnc1OXUPP6ORS0xvYvZRPNyzsckWChaPxOzHC544HMi
	77UENkxRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb1f8-0005pY-N4; Sun, 23 Dec 2018 11:11:14 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb1f5-0005nj-83
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 11:11:12 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 8A4C3807AC; Sun, 23 Dec 2018 12:10:55 +0100 (CET)
Date: Sun, 23 Dec 2018 12:10:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181223111059.GB1936@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181223103315.GA1936@amd>
MIME-Version: 1.0
In-Reply-To: <20181223103315.GA1936@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_031111_440531_8F31B469 
X-CRM114-Status: GOOD (  22.20  )
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
Content-Type: multipart/mixed; boundary="===============8244101261737917370=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8244101261737917370==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > So the little elves have been slowly working to get voice calls
> > working on droid 4 with the mainline kernel. And just in time for the
> > upcoming holidays, it might be possible to call friends and relatives.
> >=20
> > I've pushed out an experimental branch containing serdev ts 27.010
> > UART multiplexing support. That contains a serdev core driver for the
> > mdm6600 modem (that also now idles the modem for PM), support for Alsa
> > ASoC voice codec and mixer, and a GNSS driver for the GPS.
> >=20
> > Where it does not make sense to do a kernel serdev driver, I've
> > exposed the rest of the available 27.010 channels as ten /dev/motmdm*
> > character devices. There's /dev/motmdm1 for AT commands to dial voice
> > calls, /dev/motmdm3 for SMS eventually, and I think there's also a SIM
> > card reader at /dev/motmdm10. Then /dev/motmdm7 seems to be just an
> > echo channel. The other channels are still a bit of a mystery.
>=20
> I suspected it does not work in non-modular case, so I tried with
> modules:
>=20
> root@devuan:/my/ko# insmod gnss.ko
> root@devuan:/my/ko# insmod gnss-motmdm.ko
> insmod: ERROR: could not insert module gnss-motmdm.ko: Unknown symbol
> in module
> root@devuan:/my/ko# insmod n_gsm.ko
> root@devuan:/my/ko# insmod snd-soc-motmdm.ko
> insmod: ERROR: could not insert module snd-soc-motmdm.ko: Unknown
> symbol in module
> root@devuan:/my/ko# insmod motorola-mdm.ko
> root@devuan:/my/ko# insmod snd-soc-motmdm.ko
> root@devuan:/my/ko# insmod gnss-motmdm.ko
> root@devuan:/my/ko#
=2E..
> ...do I need to make devices manually or some udev rules?
>=20
> user@devuan:~$ cat /proc/devices | grep motmdm
> user@devuan:~$ cat /proc/devices | grep gnss
> 242 gnss
> user@devuan:~$
>=20
> Hmm, I suspect the driver just did not recognize the hw.

I added some printks to motmdm_probe, and they don't appear to be
called. I wonder if I'm missing something else in the config? I do
have serial

root@devuan:/my/ko# ls -al /dev/ttyS0
crw-rw---- 1 root dialout 4, 64 Dec 23 11:52 /dev/ttyS0

but not gsm multiplex:

root@devuan:/my/ko# ls -al /dev/gsm*
ls: cannot access '/dev/gsm*': No such file or directory

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwfbUMACgkQMOfwapXb+vKZHQCeNefJ1BfW14OTPUPbUGyrEQLp
TiIAoMG6H8Rs+z5a5HC0j0/fkLwIp3Zc
=g5Nn
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--


--===============8244101261737917370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8244101261737917370==--

