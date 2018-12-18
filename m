Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339A2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:23:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E6B21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mZWwnCo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E6B21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0xqFaURgUsytsD2ncYG+pYQc7W1eWzdB5xlotLX/XVY=; b=mZWwnCo0KYpR0EBQiAz2AUtDF
	0IX0Ok0In5AUP6M70HXalioxksX0hC6rTYmV/LvnA4HAG1JAsz8Hd+mLixkQ02FjETdJV+vnggaPs
	FabFjE8qpT9+zxuTutvQpy/wdZiEgn1GnfMu4g2y4HndY/tfFzvkc2uZCaewLjdaDb3Lr+Z3It2ya
	c+t8plhUi+n5HVwMiEAo5axTYbb1iM3u2kYcayUKn6eI4siAnWXCPJ7Q1myraSlX6NKFkoo15WCn1
	qS9uJGr9rbF3ovuLTPuZGcaCGpTx2E3cWsXN/3RQTeS3ESqKsbv5Ip2z7028B1if6YYXbfXQXFA82
	/zZvJQGCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZLtO-00029U-Tw; Tue, 18 Dec 2018 20:23:02 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZLtK-000279-CR
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 20:23:00 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 010BE80A4E; Tue, 18 Dec 2018 21:22:38 +0100 (CET)
Date: Tue, 18 Dec 2018 21:22:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181218202242.GA30831@amd>
References: <20181217004450.GW6707@atomide.com> <20181218124616.GA10758@amd>
 <20181218153650.GA6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181218153650.GA6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_122258_577412_58102E60 
X-CRM114-Status: GOOD (  19.62  )
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
Content-Type: multipart/mixed; boundary="===============3238802727885911894=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3238802727885911894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > # commit	    0c1bc81ba976bcd480d6e3c3009a28589f8427c0 (patch)
> > # mfd: motmdm: Add Motorola TS 27.010 serdev driver for devices like dr=
oid4
> >=20
> > Oh, that is a lot of fun. Especially state machine for parsing modem
> > responses. I wonder how well it is going to work when modem is
> > accessed over USB...=20
> >=20
> > motmdm_read_state(... size_t len)
>=20
> That's a bit of a layering violation yeah :) But we still need to
> do that somewhere for notifiers. And the notifications are separate
> from the commands and start with a ~ character so from that point of
> view it should not be too bad.

Plus, you seem to assume that data will always come in suitably sized
chunks. Aha, and as it is not plain serial but packet protocol over
serial... I guess that is going to work?

> > I did a quick test in my config... and it did not break my old setup
> > -- voice calls still work when set up over USB and with manual mixer
> > setup. That was good surprise.
>=20
> OK good to hear. Using the n_gsm port instead of USB during idle
> has a major PM advantage as the SoC can hit retention during idle
> while still connected to the modem and getting notifications.
>=20
> So looks like during idle we can keep USB in autosuspend mode with
> something like the below shell script function.

Yes, I should really start using serials instead of USB. But... I have
working ofono there, and was using that phone and am little short on
time at the moment.

Thanks,
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwZVxIACgkQMOfwapXb+vKzsgCfe5SxXLIU0/XDhCS+NU2FI4PJ
hT4An2GGA1G+NWauOlEvtyR5MaZm7zTd
=oZIT
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--


--===============3238802727885911894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3238802727885911894==--

