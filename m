Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595A9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:18:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285CD2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ljp2gG/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285CD2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=szb60gFTZ+pKmv81jZ+/E2wcO5OYgIDom8ne5uEUG9M=; b=Ljp2gG/IcesuUmnBDBLN3kxss
	GJZAZMlnRd0lp8WZRzWdnqrMTJ1QcaL5VV1ICrklGB1WoRPf+n7APpmYpV/4dGJC/6qWjNBjCgjvf
	n1li0bavxRfxYBr8FIHq1w++SGZovMR7aQ3nR3ZszX64viuaNgL9yo7/2aVI6hivug+h4N7Rtm8MM
	960KFkQtLk3Ml5A8buS7tkYVw62sKYT71Ux3+IXcIIFXDu0VGcZqPNre7nC5/fNT7xPubWacprBRm
	Q+afrFyQxA6sTNLsNv3e49Lk5GkEu/R6uhIF/eqapQU/aHHtvD+WJbZnjGo+x1H5OYgg3+cPxTwOd
	AWm9Nd00A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grrze-0006fm-B5; Thu, 07 Feb 2019 22:18:02 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grrza-0006er-1M
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 22:18:00 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 1A4C980280; Thu,  7 Feb 2019 23:17:40 +0100 (CET)
Date: Thu, 7 Feb 2019 23:17:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4 modem support in kernel & ofono
Message-ID: <20190207221745.GA12219@amd>
References: <20190201203616.GA2087@amd>
 <20190201205032.GF5720@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20190201205032.GF5720@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_141758_233382_CC95B104 
X-CRM114-Status: GOOD (  20.68  )
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
Cc: mpartap@gmx.net, merlijn@wizzup.org, sre@kernel.org,
 kernel list <linux-kernel@vger.kernel.org>, nekit1000@gmail.com,
 ofono@ofono.org, linux-omap@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============6471929367365794515=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6471929367365794515==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Ok, so I got calls and smses somehow working in kernel&ofono ... which
> > is really all I need.
>=20
> Nice :)
>=20
> I think the SIM card reading and writing should be doable
> using dlci10 /dev/motmdm10 for AT+CRSM calls..

Might be. Sorry, this is outside of my area of interest, because LTE
would not be on usable frequencies, anyway.

> > I pushed the tree to git@github.com:pavelmachek/ofono.git , branch
> > d4... But I had to do some "rather interesting" hacks. D4 modem
> > expects packets and current kernel drivers rely on write() boundaries
> > and flush(). .. which is a bit of problem for in ofonod, as it expects
> > to work with bytestream with no explicit packet boundaries.
> >=20
> > However D4 still uses normal AT commands, so... it would be good to be
> > able to use AT parsing framework in ofono.
> >=20
> > I believe easiest solution would be to automatically do the packet
> > splitting in kernel, it should be as easy as splitting on \r and
> > ^Z. (Currently packets are only generated when \r or ^Z is seen on
> > write boundary, but that does not work well for ofono).
>=20
> OK yeah it's worth trying. I hit that issue too with the
> flush needed for droid4-sms-tools scripts. And the traffic
> we're seeing is minimal and AFAIK there's no network port
> for ts27010. And SMS messages are PDU encoded anyways.
>=20
> Hmm should we do it for \r\n and \r? Otherwise the \n
> will be left out of the packet :)

I guess splitting on \n makes sense, yes.=20

Ofono normally uses just \r. Translating it to \r\n in kernel (ttys
already do that) would be super nice, but I think this is easy enough
to handle in ofono.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxcrokACgkQMOfwapXb+vK4bwCfV/LVgMgAXt7Rt3r5EGz7Cq9V
vV8AoJcZpIFS/6ox5j6ZCvHU9VHo6GkG
=9OQ6
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--


--===============6471929367365794515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6471929367365794515==--

