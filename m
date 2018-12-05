Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABDBC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:18:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6E2208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zw2oj+Vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6E2208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SmrAUADJXaQ3Ap8U3HLKDiQrmuL60BgSQlwzKOM0EjY=; b=Zw2oj+Vgqn8vqy8ahUxmXBRFa
	wFy80eNiOOfsykARTqRmIGgzDNRfFDqtDqsrCjagUAwCUdgz0VwfzByrvzjIu9cUmAaR6KFZ0gj6Z
	o7RzvvG/6fTaNrS3Kydi9Tv1OsRNF9fVmuBSHWACjhvf12ue+GI38jRdYXvuwdtrpRUM/b93b1lzt
	albRrje3rF9W5Lx02Snl2zh7X20HUO5RFms2xuy3yiStX/sXSnT9X9wiT8QIUOU0MXnKtDdy2DWsc
	v/Ua8k6VxM2dwihVtXrcM8dsEK1HjKWckpHPgaFeQDd23YIP+HdUybDXJRid8ylBkgYVUrvI1nwQR
	jrYEM+ZJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUdci-0004sX-7U; Wed, 05 Dec 2018 20:18:20 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUdcd-0004rL-UR
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 20:18:17 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 6592F8094D; Wed,  5 Dec 2018 21:17:56 +0100 (CET)
Date: Wed, 5 Dec 2018 21:17:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 10/10] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
Message-ID: <20181205201759.GA28800@amd>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <b1a7aa06389ccd46f60db3e63bdf1e9ce9781d49.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154403090130.88331.18352581261422337586@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <154403090130.88331.18352581261422337586@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_121816_139389_265F5584 
X-CRM114-Status: GOOD (  15.13  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, mazziesaccount@gmail.com,
 matti.vaittinen@fi.rohmeurope.com, linux@armlinux.org.uk, krzk@kernel.org,
 akshu.agrawal@amd.com, cw00.choi@samsung.com, djkurtz@chromium.org,
 pombredanne@nexb.com, andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2399912087625625202=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2399912087625625202==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-12-05 09:28:21, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-12-04 03:39:38)
> > diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
> > new file mode 100644
> > index 000000000000..d486859526ed
> > --- /dev/null
> > +++ b/drivers/clk/clk-bd718x7.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 ROHM Semiconductors
> > +// bd71837.c  -- ROHM BD71837MWV clock driver
>=20
> This isn't even the name of the file. Please remove. Also, only the SPDX
> tag is supposed to have // on it and the other things should be normal
> /* */ comment style.

Actually whole block commented by // is now considered ok.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwIMncACgkQMOfwapXb+vKOZwCfZFh8cByPz16glJKlruCOyrXW
f8cAoKTS7UTpBAr8tywOzM2pi7YqIf39
=+GXS
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--


--===============2399912087625625202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2399912087625625202==--

