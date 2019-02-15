Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F0AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:19:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9DE21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CNxLAX9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9DE21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SJR5AIOZhGVLotsBYT0LRTW5JsftSxwjupZvclTXHaQ=; b=CNxLAX9TpHmWqROOU4tWCQVnL
	2Dlqd4OcDW6GocWMLhJ3tHrNzH3Cy4xuR9ZvdIBM5jkZFUcqvBcGTBYd6KDCcd1KBlOegiLEgLEyA
	cQB1enQVNvQynnT2s6U8tFKSOCcCc5eS+F82NkhTT2gZ4nZV6Qv9YL2ttpcyyFM0h0dYdxNlaluHi
	SaDDr7nIpTh/GKtxhBTjAi8UoWNKFEUE1dtkCmXJIeMI47gKlHcBKXLx3rB6dxPiXfBOZLrLTGLoh
	1h3Dyo8C2JtfazNuRgu5XB3EikBuQ6KQv3NtEm0VnqpaOdIOrY6gU8fqpisutalqEpPCSEy43pxw6
	Ob6GfoMvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZdz-0001V9-OL; Fri, 15 Feb 2019 09:18:51 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZdw-0001Uj-Pu
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 09:18:50 +0000
Received: from localhost (unknown [83.221.228.209])
 by pokefinder.org (Postfix) with ESMTPSA id EE8B42E3551;
 Fri, 15 Feb 2019 10:18:47 +0100 (CET)
Date: Fri, 15 Feb 2019 10:18:47 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Message-ID: <20190215091847.pkagndsndjzumzwd@ninjato>
References: <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <201901050345.JaEWLmjh%fengguang.wu@intel.com>
 <20190115224351.rtbqaqro5pl3dvov@ninjato>
MIME-Version: 1.0
In-Reply-To: <20190115224351.rtbqaqro5pl3dvov@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_011848_985977_7BE8904E 
X-CRM114-Status: UNSURE (   9.07  )
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
Cc: alexandre.belloni@bootlin.com, me@jue.yt, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>, kbuild-all@01.org,
 andriy.shevchenko@linux.intel.com, Juergen Fitschen <jfi@ssv-embedded.de>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============1684280162935976668=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1684280162935976668==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qchyiiv27q5ypmam"
Content-Disposition: inline


--qchyiiv27q5ypmam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:43:51PM +0100, Wolfram Sang wrote:
>=20
> > All errors (new ones prefixed by >>):
> >=20
> > >> ERROR: "at91_init_twi_bus_slave" [drivers/i2c/busses/i2c-at91.ko] un=
defined!
> > >> ERROR: "at91_twi_probe_slave" [drivers/i2c/busses/i2c-at91.ko] undef=
ined!
>=20
> That needs to be fixed. Rest looks good to me!

Ludovic, do you have time to fix it? I would really like to apply this
series for the next merge window.


--qchyiiv27q5ypmam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmg/MACgkQFA3kzBSg
Kbaxtg/9EujPwpdjaYtxYjWa2I4ETfR0dHWnklKyaTbLIDlAi1HZnfhQ656dWaat
h+FpC6m9SubOr3DeJxG7XVBsygDvn8AnWS0UJPxzYlBSuOl+XAPoDdpiBwMugpEL
mKBOyBiLUQ8M7L1LzGHvgnm5Bm3r4xBirPVBYckHc5S2kMGqgarQYopILiwrC62D
6b+eyKYWbcmpESEIwPz7Sl6KbcOb1WzEJbdmxNCFDmzQhV4K15fMl/BsrRSb0OLa
9qwhzQ+suUHXk6plDkXg49qvzxEZmPEPg0fDLFAdDHKUVNnLitgj+2DzSdAxSv5c
PpQaWv82b4CxxAyMi4Zm35CsfwiLb4fhMnfflZh0AaCoRBQit9/R/ROPCFmMVkSG
2LJ3ap6eENveUXifYjqNV4aoucOtvcQrn0u2Dt2WhaVrlImVoq7hW7+JirzTZxUd
VpPdsB9Zx7yU/6EgeuzvXaeH780vuWkGezw7GgnQMA9as1KQXOyAsw9KwKEgHnBI
MlHxZrpv0uYAKKVXV/5gvYmQF5TpkhhWfe4iSkMXGuHKqXFBZ095XAagt6roP58I
hOQ4eGbKyE9kiIbR2Ie8fQwSK/PpBTDxxcF2ZUk/F2DbPRyh9j1yHLnqWPs11TTo
fftCDKNQAV44g5TveOVZ7eQUWM9lL/UoSyrrjS8yGZs7LIXKvPI=
=PYSp
-----END PGP SIGNATURE-----

--qchyiiv27q5ypmam--


--===============1684280162935976668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1684280162935976668==--

