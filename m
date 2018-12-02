Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17274C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:29:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D362081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mF7Hs0AD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D362081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sxi7p37cpiRtM71K9LS13Za9cF/Bl6nHQJIB8mAzMGk=; b=mF7Hs0AD+Mi++AO+5Nnee+Ub+
	VN01PHMBw0WQ+E4WZvUAObtN6g6Zq6gdroEotDZJkgFBrEvU7eGGjrP87wGwhl2+zVLHCcQOZb4o5
	3GDMV3LNSccF5fmPa4LWfPM+NMfGdEVv9Y/Ni/1IvceKEsXug5PW+xcfq/3+Ff1k+JBiMiwNBKMZU
	JPXldwv/eeC8/nskWaBhESlXH4T1CdW9Rm1tS52Z7L60fziLmEFYn989uKLXVrl7qTJKO/VzP/mtb
	0u/mrjaVwtpocUATKQ3BfXbG6hELWx4uPCGtjilHv96/p/+wSRB7jsafCOGsCXwABR2/s8XTZdW75
	BTxNxDT0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTaFJ-0005Pj-AN; Sun, 02 Dec 2018 22:29:49 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTaFF-0005Ox-6a
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 22:29:47 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id B022480A37; Sun,  2 Dec 2018 23:29:27 +0100 (CET)
Date: Sun, 2 Dec 2018 23:29:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 0/20] MMP platform fixes
Message-ID: <20181202222930.GB29467@amd>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
 <20181130234424.vx5y46wqvziywbk2@localhost>
MIME-Version: 1.0
In-Reply-To: <20181130234424.vx5y46wqvziywbk2@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_142945_389516_41BD22FA 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, quozl@laptop.org,
 Arnd Bergmann <arnd@arndb.de>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lkundrak@v3.sk,
 arm-soc <arm@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============6995403446385475959=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6995403446385475959==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The patch set has been tested on an OLPC XO-1.75 laptop.
> >=20
> > Excellent!
>=20
> OOooh, I have one of those... somewhere.

Time to find it :-). It is still pretty great machine, can last 8?
hours on battery, sunlight readable screen, and if you meet a tiger
you can hit him on the head with it ... and it is still likely to work
afterwards :-).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwEXMoACgkQMOfwapXb+vJSpQCeKebrZ/+Vbx7ea0pcpey6t2yw
KuwAnR/ZWplg03vCd9ASNFl/fuR/3cDb
=FGWe
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--


--===============6995403446385475959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6995403446385475959==--

