Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B07C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:10:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFF72146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QOvB6aMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFF72146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7fYyPAZy/oT+o4bYDumZt6jsMxJo9tLNGq8I1uODf+w=; b=QOvB6aMHx/nhahNbPuX4ou3mA
	9BDEmTO/l9kTlyuo6bH6Kh6B+9gpUbJpdDjBqkWI3FX54bUCSNBQo8CJVuFu5aUGQutir4/fTNMmu
	vwX5j3xXMkODpnkZrxQmxt8T3mlXNZ1/guPx60Ho9uRPcfqbwck7jljLmQaV0Zc1D6aZUmtoPNa9Z
	Pi74L6t4rl6DKHIh1ReHCZAk/tbIsgl8VdbTdo19wZgXJMBm+sKfhj6hpke9VYLNSiuA3I4jQADO4
	tASyfOkZia002V1F86dm+2WN6kr+n14JBvBx9F8QWGyYEMW2P67faoE3fxTSOLtHh1c2BmmMNkkuu
	Bh4r4LK0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT52r-0004uq-EH; Sat, 01 Dec 2018 13:10:53 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT52n-0004uN-5N
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 13:10:50 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 9B87F80A3E; Sat,  1 Dec 2018 14:10:33 +0100 (CET)
Date: Sat, 1 Dec 2018 14:10:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olof Johansson <olof@lixom.net>, Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v4 19/20] USB: phy-mv-usb: use phy-pxa-usb
Message-ID: <20181201131036.GB31631@amd>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-20-lkundrak@v3.sk>
 <20181130234205.nejqtrsvwtocpq2t@localhost>
MIME-Version: 1.0
In-Reply-To: <20181130234205.nejqtrsvwtocpq2t@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_051049_350099_F3170E0F 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, arm@kernel.org,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5211507762206401590=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5211507762206401590==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-30 15:42:05, Olof Johansson wrote:
> On Wed, Nov 28, 2018 at 06:53:23PM +0100, Lubomir Rintel wrote:
> > Use a proper PHY driver, instead of hooks to a board support package.
> >=20
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Tested-by: Pavel Machek <pavel@ucw.cz>
>=20
> These should have an ack from the USB PHY maintainer before we apply them.
> I don't see him cc:d on these patches though (Felipe)?

I put him into cc now.

USB PHY LAYER
M:      Felipe Balbi <balbi@kernel.org>
L:      linux-usb@vger.kernel.org
T:      git
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
S:      Maintained
F:      drivers/usb/phy/

I guess linux-usb list should be cc-ed, too...
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwCiEwACgkQMOfwapXb+vJo9QCdHREFW+AjF1wKGFileqnwWQJx
PDYAoITADyOFXavZYNPtesk80BVKrAKN
=fKd0
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--


--===============5211507762206401590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5211507762206401590==--

