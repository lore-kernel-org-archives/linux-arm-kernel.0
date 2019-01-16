Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FD4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:00:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C145A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SIbft4kx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y84jtU5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C145A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QalOxvXUgwWFNr7bQ73IyAIlXh+TCzm5s8XWKt9obK8=; b=SIbft4kxP8SfuoMGJCJKYMtgM
	KDT/XvTqv9/Ap90D2q9mpseQD8X8FZkY3S8vVYHDWxPe1pdsUl6/+C3KHEgCGIpd1MaD9dJD2nnfB
	82FszXY2coW0h1J1nlv3rs/4VAFOIy5D6wG1haIaoPlm9N9xqoq1BTd+Kzpw/C4YNmnxVaIQ1YiIr
	TI0sggSku8B37cRxvi2YhZwHT3nPnFsQCkhebXsYrv98ZLwh0XBKG+gXNxBPYn5OyrN7owgT6YJyO
	vre8S+9T1LWFA9pP2zG311DTUnw8Cm3CCgvwUiGc7MwDWLGZiz3K97hQIK5eNc9Mrob/Wd86jWnRZ
	Ty98kTyHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlkV-0003eg-FV; Wed, 16 Jan 2019 14:00:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlkT-0003NJ-KB
 for linux-arm-kernel@bombadil.infradead.org; Wed, 16 Jan 2019 14:00:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iP0o8YdVtJPU9R1/+NLK9VNp9brh78KwcuP3GiT7Dps=; b=Y84jtU5SBY2U8IRVSfelRpSkN
 mkmpsV7XUI37aI1Mqgjsybo2UBVvv+hLn5ozjKhTkodwOx/EcZjFqYelOOUHzP832CoIVuHqPdi3Z
 CrypRQGSj35YzBkWcEOynWSaUfl51heDnq3qGugQ8teZIPCQYSJkDePgiFx3Nb2aOdWi8N2XBJlCM
 S2r51Sbs7myuuSEXBjQa5VAj9Fht6lK2BLTBVNec1+OnOV/6wH0kMTJrQZz7XgJf4IEkWb3U6sYVN
 pWpZ4hZXGuOoU3Feji84dPUOY8hAycOLmcGmtkcFqyDPT/HKEvtekPBbuP3Yu/aoxNcmUuEu5ci/6
 F+0LovXjA==;
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlYT-0006hN-Q1
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:48:31 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 0D61C80852; Wed, 16 Jan 2019 14:48:17 +0100 (CET)
Date: Wed, 16 Jan 2019 14:48:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20190116134823.GA10145@amd>
References: <20181217004450.GW6707@atomide.com> <20181218124616.GA10758@amd>
 <20181218153650.GA6707@atomide.com> <20181218202242.GA30831@amd>
 <20181218215311.GD6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181218215311.GD6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_134829_887566_2BE764DF 
X-CRM114-Status: GOOD (  21.86  )
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
Content-Type: multipart/mixed; boundary="===============4225559850139338241=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4225559850139338241==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > I did a quick test in my config... and it did not break my old setup
> > > > -- voice calls still work when set up over USB and with manual mixer
> > > > setup. That was good surprise.
> > >=20
> > > OK good to hear. Using the n_gsm port instead of USB during idle
> > > has a major PM advantage as the SoC can hit retention during idle
> > > while still connected to the modem and getting notifications.
> > >=20
> > > So looks like during idle we can keep USB in autosuspend mode with
> > > something like the below shell script function.
> >=20
> > Yes, I should really start using serials instead of USB. But... I have
> > working ofono there, and was using that phone and am little short on
> > time at the moment.
>=20
> Hopefully adding support to ofono and modemmanager to use use
> /dev/motmdm1 for calls should be quite trivial now.

git@github.com:pavelmachek/ofono.git

"quite trivial" does not mix with ofono. I did parts and it is still
not finished. At the moment, I do not have enough working SIM cards to
test everything. Feel free to help :-).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw/NicACgkQMOfwapXb+vJy2wCfYD/PszNYMbY/v/ahB9ybQFoX
u8MAn1+hKDArcUkhatVDZQqiL/oOtWhK
=wfWW
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


--===============4225559850139338241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4225559850139338241==--

