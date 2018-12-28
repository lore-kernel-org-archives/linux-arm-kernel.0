Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AE2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:46:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C96A20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KVbUAyFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C96A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BJLo1DjIy1YriHiqp05aME8uuswpqXWW/7W5mnY6Lf0=; b=KVbUAyFyV991aPtzE/kVU0rqf
	ao45NnJtyt3siTZ+AWWYIB4/Y2468qIko98748JbWbv7OAtrd16clnqfZ5CfKSpM4be2IvsJiTgSK
	KyUM0jdjZJKGzX32ifUrvyAI3szsW42omngFLnijCLHGhCVhJfvwEH1MTaD2TNlCUGrzj2VLyS7lS
	FSHm3mHX+iCqBC21d8Q3t2ydWtF9JDTCTwR8XoxHHT6s2GUyYePDJ33fOUQITF50gRqQstcgrRbLq
	4iQhDG70hs5+yjR/rPwf9TU9puZPoXz4Oqddq/kapyXhisoLbc3fJq4bUDYXjv99Wu7IF/QmBXUDy
	dcJKDpPiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcz1i-0007Dt-0W; Fri, 28 Dec 2018 20:46:38 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcz1d-0007D7-1I
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 20:46:35 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 42CFB80648; Fri, 28 Dec 2018 21:46:10 +0100 (CET)
Date: Fri, 28 Dec 2018 21:46:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181228204614.GA9431@amd>
References: <20181217004450.GW6707@atomide.com> <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181228193105.GW6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_124633_385777_A0688884 
X-CRM114-Status: GOOD (  22.48  )
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
Content-Type: multipart/mixed; boundary="===============0945645865316040384=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0945645865316040384==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Yeah so I found that Ruby pdu_tools module allows decoding PDUs
> properly while I did not have much luck with other tools.
>=20
> So I wrote a hasty script to read SMS, copy it to a Maildir and
> then ack it:
>=20
> https://github.com/tmlind/droid4-sms-tools

Aha, that was quick :-). Interesting, let me take a look.

> > Proper solution involves special support for ofonod...
>=20
> Yeah at least we're dealing with standard PDU format now for
> incoming SMS.
>=20
> Also looks like there is no status on the modem for these incoming
> messages as checked with mmcli. I guess the idea with raw PDU
> access is that the message is delivered directly to the client
> and then acked instead of being queued in the modem?

I'm not sure what "directly" and "client" is here, but yes, it seems
that motmdm9 just delivers messages, and if you don't ack them,
network will just keep retransmitting the message.

> > Fortunately ttyUSB4 still works, so I can still use my old code... and
> > I started logging motmdm1 and 9 to a file as a backup... that should
> > be better than my existing solution. (But I don't get power benefits
> > etc.)
>=20
> So what are you using to ack the received SMS over ttyUSB4?

I have ofone with direct AT access --
https://github.com/pavelmachek/unicsy_demo/blob/master/ofone/at.py .

And then better solution using ofone + ofonod.

https://github.com/maemo-leste/bugtracker/issues/150

Now, ttyUSB4 provides quite a rich interface, and you can actually
select what if you want messages in text and PDU format, and if you
want modem to auto-acknowledge messages for you.

(But I don't think all options work).

It may be even possible to select if you want the messages to be
queued or delivered directly.

> My logs show that Android uses two different commands for ack.
> Either AT+GCNMA=3D1 or AT+CNMA=3D0,0 gets used depending on something
> that I have no idea of.. Maybe the network connected?

Not sure what goes on there.

> Sending SMS via /dev/motmdm3 needs move investigation, but at
> least ModemManager mmcli can be used to create and send SMS.
>=20
> Hmm or what are you using to send SMS over ttyUSB4?
> I think you already replied with some of that info earlier
> but I can't find it..

Same as above -- in text mode sending messages is very easy (can be
done by hand in minicom, or at.py can do it), and ofonod can already
do PDU encoding etc.

> Oh one more thing, I noticed that on /dev/motmdm1, typing
> AT+SCRN=3D0 supresses notifications except for WAKEUP, and then
> 1 is used to enable them again. That allows the UART to idle
> instead of getting network status messages every few seconds :)

What kind of battery life do you get with all the optimalizations?
IIRC I was getting 7h with ttyUSB4 in use...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwmi5YACgkQMOfwapXb+vI2+wCgtsn0dqWzuSNmTJ3PVOBlu5aW
X7wAn1KV/kVHN+45c6CD9RStnD34mPyj
=5X3+
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--


--===============0945645865316040384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0945645865316040384==--

