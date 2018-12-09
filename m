Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914A2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:13:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B6A20831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="asxd2YKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B6A20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=nrIdIv561yA4OotLen4DnPfHxiYXEQJgyCR+ka8I5oU=; b=asx
	d2YKsZXENLYLnMhbsD17FfXiyyJj5vmurjpwY2eiW9bpNjaIcm1LZ8XiEEi3/2ZHQptDzWdXhpcnF
	ehJ4QPu0ztuHzzmlLbyw7ZaGF1QAh6e8diIwiL+UAPcF2AWZBBrCa9tdAFo481IoW+JnOTto6GoTt
	eXpR+3K3y3DY5BMHMXTc7sUmtHf4cBJMea8Wb2yMtv+2c77xjk9xeTW5thUYa2/B2l8gDTtXDQVMG
	Gev5CdtVKgL0SfHoEsYHRKkQn7Vg+QsYpboxF4QM7rTEz37ya9pcfciCqWFPPxQPBcWO+6w+7u6IT
	Xp5DceMqN/kplNPfPuWvenwPI9V1tJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVxxq-00071p-70; Sun, 09 Dec 2018 12:13:38 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVxxm-00070v-9m
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 12:13:36 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 520228075F; Sun,  9 Dec 2018 13:13:15 +0100 (CET)
Date: Sun, 9 Dec 2018 13:13:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
 nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Droid 4: poweroff does not work? calls
Message-ID: <20181209121318.GA24478@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_041334_495941_8C3292C0 
X-CRM114-Status: UNSURE (   8.83  )
X-CRM114-Notice: Please train this message.
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
Content-Type: multipart/mixed; boundary="===============2069897744110695292=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2069897744110695292==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
affected. It is bad, because when your battery is low, you get into
reboot loop and discharge it furher, which batteries do not like.

Any ideas, or at least idea how to debug this?

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwNBt4ACgkQMOfwapXb+vLUqgCgpNoWs1ZF9EPprWwWF0RemEED
xFEAoJBxpNOAr8LoKxNRLnEQb/j1bA7D
=Mhar
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


--===============2069897744110695292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2069897744110695292==--

