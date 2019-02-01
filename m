Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54322C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:36:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252CF21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jffaMgWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252CF21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=lYVoOfYUQ1QSu7niIbfV6pYSFtN1j7rrln+R2m/iqbE=; b=jff
	aMgWdGhrJuGtpxp5QmzgVpPp7HfVDLveg16mpDddt+cVcOkH/lY3ctEK4M/G0mz/0vgOeBOH2xF/7
	26FNup7/TFti9ukB2ajh3cT7Hdaj65zNblcsjhU9x4SZxmkG5L6EdYahWQ5g5Eujs+GfPnSrQ7+Qd
	FG5EYoPn967eXyDHy4YiDQIbtVMRm7TQ0dlHhJJgue4u0NKu523Q1DCmu3Rli5xw7vXJeyXFmzf4u
	s4qenMX/ugJoGt+IWhryYVdedDqtUSXa5QcOr+x/K6Bo9xYhdyGt3cSkfXPeOC27ywLHOu8/a4Ean
	N2oq4eNYA+7Z16e0foTKYsT7Dn6Vk+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpfY4-0003eU-WB; Fri, 01 Feb 2019 20:36:29 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpfY1-0003df-Jx
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 20:36:27 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 303BD8025E; Fri,  1 Feb 2019 21:36:10 +0100 (CET)
Date: Fri, 1 Feb 2019 21:36:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ofono@ofono.org, kernel list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
 nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Droid 4 modem support in kernel & ofono
Message-ID: <20190201203616.GA2087@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_123625_812951_A65EB573 
X-CRM114-Status: GOOD (  11.06  )
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
Content-Type: multipart/mixed; boundary="===============2147323571931451979=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2147323571931451979==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Ok, so I got calls and smses somehow working in kernel&ofono ... which
is really all I need.

I pushed the tree to git@github.com:pavelmachek/ofono.git , branch
d4... But I had to do some "rather interesting" hacks. D4 modem
expects packets and current kernel drivers rely on write() boundaries
and flush(). .. which is a bit of problem for in ofonod, as it expects
to work with bytestream with no explicit packet boundaries.

However D4 still uses normal AT commands, so... it would be good to be
able to use AT parsing framework in ofono.

I believe easiest solution would be to automatically do the packet
splitting in kernel, it should be as easy as splitting on \r and
^Z. (Currently packets are only generated when \r or ^Z is seen on
write boundary, but that does not work well for ofono).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxUrb8ACgkQMOfwapXb+vL9DQCgr4uvxr+ygZ6U/zYLogeQqdV3
6AIAn0lWzuae8f5IrQQWfPp2WFP3He0p
=CqWQ
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


--===============2147323571931451979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2147323571931451979==--

