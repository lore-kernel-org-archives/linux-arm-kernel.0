Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FD9C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:00:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A052020834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W7g168xE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A052020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AW1/IuxKoEG7TXgM0fdDEA6cSuNiVkTnrF/3zG/Jby4=; b=W7g168xEuVyXDHON/yEHtR8K5
	G9nXsmz3yqHaQ8BXzOxX15lFgy2mPprol69yZxvchBfufSojvP8BUEejddhvyTuYQlgoifc2i2ZXs
	bSnE6SD04xFhP7y7yP7B7p4UJLDk2hWqm6t5PHj6KIazTMtZbUKmvqaZ73XqxXTqnEsEVq0id1pBI
	7CdtcbO9cha/QZPoeC0Ne7CCgTdpzHwruimOeT3pEWwuG76HAquw0XruVXbKwhh2VPKQgBfnZQ1If
	DDm7E79b6uzO8VCf1dgP3ifLnyL6a5LTjG1NIgNyyD6/9cXiz0JxnpqEkJx13AC3ybIqzqBjVM8BM
	34P1U4/ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT4sr-0002Kv-Mq; Sat, 01 Dec 2018 13:00:33 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT4sM-0000lU-LX
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 13:00:05 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id F0FB680A44; Sat,  1 Dec 2018 13:59:41 +0100 (CET)
Date: Sat, 1 Dec 2018 13:59:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 12/20] irqchip/mmp: do not use
 of_address_to_resource() to get mux regs
Message-ID: <20181201125944.GA31631@amd>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-13-lkundrak@v3.sk>
MIME-Version: 1.0
In-Reply-To: <20181128175324.163202-13-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_050002_979619_9F436528 
X-CRM114-Status: GOOD (  13.28  )
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
 arm@kernel.org, Olof Johansson <olof@lixom.net>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4732756857723357855=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4732756857723357855==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-11-28 18:53:16, Lubomir Rintel wrote:
> The "regs" property of the "mrvl,mmp2-mux-intc" devices are silly. They
> are offsets from intc's base, not addresses on the parent bus. At this
> point it probably can't be fixed.
>=20
> On an OLPC XO-1.75 machine, the muxes are children of the intc, not the
> axi bus, and thus of_address_to_resource() won't work. We should treat
> the values as mere integers as opposed to bus addresses.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Comment in the code and big warning in the dts description would be
nice.

Otherwise...

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwChcAACgkQMOfwapXb+vIGRwCgkt68puXV/4p6zD7n8y890wZg
8wAAmgKzZcVWDKewWnNEyBCLolJhBNC4
=QRyg
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--


--===============4732756857723357855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4732756857723357855==--

