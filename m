Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD7AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:43:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0A520837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6+ytbZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0A520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IpiLAwJK/GgQuG+39ZD+OSljmBzakpjT21f4bApH+Yg=; b=O6+ytbZAWGIUHdJ67JElk3YiV
	Be80TvHQPYXU3e955xOZamc6UbhY1UH+7uHCKbIJx6Sxobyy9gIx/jky+vlhlTKqltCadNClLgBRV
	NXwQRVQcMXk2YeW8iskI3RIC2n7au4OWl5f4ahjey6kXGZlkIuxgNOsUuheY962d2twmKxpqdmpZ+
	862WkIwiPe6i7doyquvTLDcFo1oLEjUR/UG7/NLsJ102M9STr8BzSblxbWDYjHyFedn5+noieoVBF
	fFpmSTmNfoDFNAzyMFA4010qMLzJks2nkofPlfF9M6n2AvAIutdIDXfIGd0QhkAZYEw99Az3FAzQF
	4nRiqHXzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW36b-0005hE-SI; Sun, 09 Dec 2018 17:43:01 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW36Y-0005g7-P8
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 17:43:00 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id C3F498076F; Sun,  9 Dec 2018 18:42:41 +0100 (CET)
Date: Sun, 9 Dec 2018 18:42:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4: poweroff does not work? calls
Message-ID: <20181209174244.GA28617@amd>
References: <20181209121318.GA24478@amd>
 <20181209164650.GX6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181209164650.GX6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_094258_968980_883A5220 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: mpartap@gmx.net, merlijn@wizzup.org,
 kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org,
 nekit1000@gmail.com, linux-omap@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============4096525051650791625=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4096525051650791625==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-09 08:46:50, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181209 12:13]:
> > Hi!
> >=20
> > Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
> > seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
> > affected. It is bad, because when your battery is low, you get into
> > reboot loop and discharge it furher, which batteries do not like.
> >=20
> > Any ideas, or at least idea how to debug this?
>=20
> Hmm can you check if this is happening with usb unloaded or
> unbind? I suspect ohci or musb..

I tried disabling USB in the config, with v4.20-rc, and same
behaviour. sudo poweroff causes reboot.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwNVBQACgkQMOfwapXb+vIhxACfU+qMvE2H576SW5FXcUNHpjFg
6IQAn3YkX5S6nEQyJb8mUqTXTM3GRXr+
=eZVg
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--


--===============4096525051650791625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4096525051650791625==--

