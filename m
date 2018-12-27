Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6700C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:17:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB51C218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cHBZQmf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB51C218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C62zpDiNAWKsaEmDzD+vgPxhC/i/xp1Lu+8ejxnEmbs=; b=cHBZQmf57sLpdsjzlr2jm95ia
	5y3lORfcAvSiy+T5sugRdC12n1IE/nsCTSdZ+InWGSscOdf6UUuiTTg0JpR4CgWcmTPYTOi2KXA7W
	blaf4O/demzklzMXZ3FBcnrb1Qv7sxFHMbCLPiOlLY5nXvgzqbhaa7kSPBTT+dRt+Vc9DLt6iXku9
	i3OFZieDlbH7G0niJMfwQH95aSXptx+Y3U6j91cqUxs8HmCi+LZe4Q1FL9kcvMZGaG9a/pLCelrjh
	pSrIv2DmgvovV6TCMIZzyMIykfafdEJsWuqyYRAiukfby0Et+X9FutAuVnw78tFON1ZopHqcB2DCU
	Odc2evwNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcSj1-0005qc-RV; Thu, 27 Dec 2018 10:17:11 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcSiw-0005pd-Cj
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 10:17:09 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id D722E806B4; Thu, 27 Dec 2018 11:16:43 +0100 (CET)
Date: Thu, 27 Dec 2018 11:16:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181227101647.GA32260@amd>
References: <20181217004450.GW6707@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181217004450.GW6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_021706_582972_72BF5069 
X-CRM114-Status: GOOD (  14.08  )
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
Content-Type: multipart/mixed; boundary="===============7891286794576280863=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7891286794576280863==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> So the little elves have been slowly working to get voice calls
> working on droid 4 with the mainline kernel. And just in time for the
> upcoming holidays, it might be possible to call friends and
> relatives.

Thanks a lot for the Christmas present :-).

> 2. Test a voice call
>=20
> $ minicom -D /dev/motmdm1	# Then Ctrl-a-e to enable local echo
> AT				# Case sensitive AT commands..
> :OK				# Response uses : as separator..
> AT+CFUN=3D1			# Enable radio
> +CFUN:OK
> ~+RSSI=3D1,9,108,99,0,0,0
> ...
> ATD1234567890			# Dial some phone number
> D:OK
> ...
> ATH				# Hang up
> H:OK

Ok, I really need SMS messages, too.

Fortunately, they are on /dev/motmdm9, in PDU format. Quite
logical. And you probably need to acknowledge them, using PDU,
too... (because otherwise you'll just get the same SMS over and over
and over). Which is also logical, but hard to do from shell/python.

Proper solution involves special support for ofonod...


Fortunately ttyUSB4 still works, so I can still use my old code... and
I started logging motmdm1 and 9 to a file as a backup... that should
be better than my existing solution. (But I don't get power benefits
etc.)

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwkpo8ACgkQMOfwapXb+vIwRQCeKWaJOmwziTu0UuqdIxXS0zM4
TckAn1AG9W8Gd8OVMedZPaQqhF2wrxRb
=eDKP
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--


--===============7891286794576280863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7891286794576280863==--

