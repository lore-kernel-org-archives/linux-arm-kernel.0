Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2700C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:05:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1129218E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ElGIPZcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1129218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vOLlayYfb9ehqXRU61kk6iwTW/f0hvqLl0mmAA8Jcbo=; b=ElGIPZcbNPf6mphjb0UsGxFaf
	rFmhTflw8tejRTj17uD+4oLIEXVWG/vY6pLLJQ88qNPwpLBMvOtElEDyi3LUwxGwTiqUvhxvxNwOM
	k/dm6XW2MlQ8l7RZ+7k37O2Ezw+TLD8nWZUe5ed9nkZtiWJJxWnZxV5fl0AN6AoZqaCbd6YRxJQHm
	Ugk/fBjqDF+tPnLUxr1BENlliCIsEjqukMgP6tx5OuqO8cadNjKy6+rpkQl2u43xiVmuy4ZA59isz
	cRs80BKWFu1wY5WuHnKd3DxE9R4H+q9h9zeKomu/ci3EI4ELn0HdhjVa6F4dcynfijvBMuW4QsnIg
	EdIWRqWUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaqKl-0002wn-Rd; Sat, 22 Dec 2018 23:05:27 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaqKh-0002vi-RB
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 23:05:25 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 3395A80B55; Sun, 23 Dec 2018 00:05:02 +0100 (CET)
Date: Sun, 23 Dec 2018 00:05:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181222230505.GD15237@amd>
References: <20181217004450.GW6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181217004450.GW6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_150524_033826_6C209DCE 
X-CRM114-Status: GOOD (  17.71  )
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
Content-Type: multipart/mixed; boundary="===============5301913415404969450=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5301913415404969450==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, little elves!

> So the little elves have been slowly working to get voice calls
> working on droid 4 with the mainline kernel. And just in time for the
> upcoming holidays, it might be possible to call friends and relatives.
>=20
> I've pushed out an experimental branch containing serdev ts 27.010
> UART multiplexing support. That contains a serdev core driver for the
> mdm6600 modem (that also now idles the modem for PM), support for Alsa
> ASoC voice codec and mixer, and a GNSS driver for the GPS.
>=20
> Where it does not make sense to do a kernel serdev driver, I've
> exposed the rest of the available 27.010 channels as ten /dev/motmdm*
> character devices. There's /dev/motmdm1 for AT commands to dial voice
> calls, /dev/motmdm3 for SMS eventually, and I think there's also a SIM
> card reader at /dev/motmdm10. Then /dev/motmdm7 seems to be just an
> echo channel. The other channels are still a bit of a mystery.

I tried to get access at motmdm, but no:

root@devuan:/home/user# minicom -D /dev/motmdm1
minicom: cannot open /dev/motmdm1: No such file or directory
root@devuan:/home/user# ls -al /dev/motmdm1
ls: cannot access '/dev/motmdm1': No such file or directory
root@devuan:/home/user# dmesg | grep motmd
root@devuan:/home/user# zcat /proc/config.gz | grep MDM
CONFIG_MFD_MOTMDM=3Dy
CONFIG_SND_SOC_MOTMDM=3Dy
CONFIG_PHY_MAPPHONE_MDM6600=3Dy
root@devuan:/home/user# uname -a
Linux devuan 4.20.0-rc7-00304-gde109fe #19 SMP Sat Dec 22 20:16:19 CET
2018 armv7l GNU/Linux
root@devuan:/home/user#

Let me try to enable CONFIG_GNSS_MOTMDM. N_GSM also seems enabled.
=20
Is there anything else I need to enable in .config?

Scary Solstice!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwewyEACgkQMOfwapXb+vLs/wCffXaPd1U9e09MvHGaTdLG/HKQ
t6oAoLCrYIULHPSTQJqejo6Vw1A2FQs7
=Yu1V
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--


--===============5301913415404969450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5301913415404969450==--

