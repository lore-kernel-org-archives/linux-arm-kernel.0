Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E5FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:06:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D3B20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ulb6wQyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D3B20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mKY7hHirVhxdgjJK3mZ68HQrFJ5V1jkfJZaH/7ZqteI=; b=Ulb6wQyOlNkMfYLEqwf9STDoi
	YY2JL6n2wLfBg7joNHtyouF6B4zM3bLl4LezZT/Q4qQTAUw83WvritpG6WDnbq27ZxzxQM+dLtPVW
	RmGooJ61YPMWnnZoKhYk6aBrLs2+lBmM3ET9TTwZ/MquwR2LRuyZ3qWCm4u9pe52vJjGRqTALl41q
	ZhJ9c9p7HBWZazPuNvEbK6IqaVE6HewiI6T3D7OSJ0bN5MMhmf9crpdCHD9+o03H5MUJ8q2hsP1g7
	+l6+S9CtZFVE3MKtSZdL90JaHNprNzQQT7ywqH95yw828I6iG35NTUZQylodQvwavGtfPhk2a0uLG
	IdzNO9wEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjuGA-00031Q-Q5; Wed, 16 Jan 2019 23:06:10 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjuG7-00030l-5N
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 23:06:09 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 59011801E9; Thu, 17 Jan 2019 00:05:57 +0100 (CET)
Date: Thu, 17 Jan 2019 00:06:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20190116230602.GA3131@amd>
References: <20181217004450.GW6707@atomide.com> <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com> <20190116135829.GA10426@amd>
 <20190116145904.GM5544@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20190116145904.GM5544@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_150607_357962_558969A0 
X-CRM114-Status: GOOD (  15.24  )
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
Content-Type: multipart/mixed; boundary="===============0078825468041568714=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0078825468041568714==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Yeah the scripts in droid4-sms-tools git repo work for me for sending
> and receiving. They do not work with cdma currently as the format is
> different.
>=20
> Maybe you've managed to change the mode of the modem to queue the
> messages with the at commands to the usb port?

I did not have ttyUSB open during that boot. I hope this kind of
settings does not survive across reboots.

> You are reading and writing to /dev/motmdm9 for incoming sms right?

Yes, I think so. Same one where hex-coded PDU comes.

> > > My logs show that Android uses two different commands for ack.
> > > Either AT+GCNMA=3D1 or AT+CNMA=3D0,0 gets used depending on something
> > > that I have no idea of.. Maybe the network connected?
>=20
> I think AT+GCNMA=3D1 works 3g and AT+CNMA=3D0,0 with cdma. Or it could be
> that one of them is just a delayed ack, I don't know.

Strange. It does not seem to be recognized at all.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw/uNoACgkQMOfwapXb+vJkJgCgtVXOjauuirufh27+aE7wL1wK
srwAoKKn3ZrHosTe5XBvcVSlcKcXrF59
=UwGO
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--


--===============0078825468041568714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0078825468041568714==--

