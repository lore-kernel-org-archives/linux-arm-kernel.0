Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B663C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:34:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42C32184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ww5MWglV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42C32184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/o3nBZz6281XnRzzZDbhTYZg/aa3urV7vJP8kUSyuBI=; b=Ww5MWglVoKWWg6/Vlg1FAi1nv
	pkM9tpKv/hyaS/hPTJwqXdx9yG1i3YwaoYU0Nubhyq5XFZXWdmzNiEGQuRT2MBd50oo4wfUJtUGXf
	3emF+7KUlc2l04lkhk4+F7xuAwXzxCQOfiDUodMiYcUh2NLh3N6uAJwAYzgxugGlXGsOV4N1h3N29
	SrvlkXZfThD+i26F08iiJw/LXCEQFaEBC7XsBgucMgifg7H+R3B+mlzRyG677+dHllo8GlAKhf9iN
	dZf97dwa3daAJNuHbgHEQwr6/wU6tfobISz1P9WPkc7ddy6CtWX16Hxqp9C3qe44ZvUMUY5EGpmjW
	asZhcJqjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZOsK-0000t6-RM; Tue, 18 Dec 2018 23:34:08 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZOsI-0000s5-5s
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 23:34:07 +0000
Received: from localhost (p54B3362C.dip0.t-ipconnect.de [84.179.54.44])
 by pokefinder.org (Postfix) with ESMTPSA id 240122E3542;
 Wed, 19 Dec 2018 00:33:55 +0100 (CET)
Date: Wed, 19 Dec 2018 00:33:54 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Message-ID: <20181218233354.pie5i3lvrrhq5q2c@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
 <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
MIME-Version: 1.0
In-Reply-To: <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_153406_366993_AA196E30 
X-CRM114-Status: UNSURE (   9.61  )
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
Cc: Hans de Goede <hdegoede@redhat.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============3336900623493839452=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3336900623493839452==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kkoegvsoxj4nbwmq"
Content-Disposition: inline


--kkoegvsoxj4nbwmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	unsigned int is_suspended:1;	/* owned by the I2C core */
>=20
> When more stuff is added to this bit field (which always happens at
> some point) updates to all members of the bit field will have to use
> the same root-adapter-locking, or we will suffer from RMW-races. So
> this feels like an invitation for future disaster. Maybe a comment
> about that to remind our future selves? Or perhaps the bit field
> should be avoided altogether?

Changed to bool. Thanks!


--kkoegvsoxj4nbwmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZg+EACgkQFA3kzBSg
KbZljQ/9FWhnSg2KAf/UssubqDJ1lmNWr9tNZYeZy56inKDT504CHLS7psgOekeS
ktdvqMny8x08MmKEeeKRUiAyc/G7RH2fqzYDehX7/fTp9JurpkAzUU3R3ojKKTUk
LttUvwiH3sox6DTtxNwVX5L+QlrJYj7MdGYLh4C7wC5GEmaqdK0Gev5wyksiqu8b
CpY5l6Mux+3ZIm1s3gQaa1mC6wVGvodvtpJ569ttR2XaaX4uhlg9OGDAGTT5Xck8
4rUiXKYBIvv3pGoq8KSNVunayb8zo82vsspr3QzCW010Tn9HKAbAJkvj85qBVcrq
f7ibMz8yI0cSyewn9rxQJlO7XPrkigRTyNScUhansbHOygY0lRa2VT7yh1at3uCg
FeGV6K3DSOYh43W+iy+qL+pUmiVzuTBiQ+Si+Ko3FcoGqx2OMg9dUk7Jm3ReWo5E
gRF0i1i5EmpP6qtzpd4miyVlrMupj4VL5huRV1vT67UgHHyrirMnXwuvLm7Lejwb
NTPAJSVCDC7lgiqnw9zfVqART0ZLm0iWGQGYOoMAVl1XCowvkB4GmSAztviWOyui
m+1pEjjwNMKntfoQqSi00B4dPBwxNsYTesAoBSNJuDYwkoDcsigM42sqKykKydDa
rcb4ZgX+UA8hP7VGZFnjouQWkU6KsoJNr9SxJuvqGlaOjwNvC1k=
=fCGw
-----END PGP SIGNATURE-----

--kkoegvsoxj4nbwmq--


--===============3336900623493839452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3336900623493839452==--

