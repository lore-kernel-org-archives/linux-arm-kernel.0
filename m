Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B9CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:59:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1AF20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SYwvDnLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1AF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PIgPzIzDQi2tuJOQWh14j9Zmch3iiFYFFKAgJzgbDt4=; b=SYwvDnLhnCFSOFHRuwa5hFyW0
	L58K2qyS+TUOj8G0ryLGoxpPdgwOdFvGtMFWG239yAeIg8uCX6mfymvYM4YDgoRL831ctB97xbiRy
	5ug/Mj1BDntOnLZJ873fJzrMovn72rdANy39k28MQSor8zOt5nrL5FtncNf//C8cqoPMiO62J+5Xc
	oEUDhRDavVyzPUMv/oRjQyoBkDaAuq8qGHYiL5cf7HdD+35SyZmv/Ecgk6yVn9wWFWPWzL/0eAN6w
	Nsk0sSRrt/ZHikjAQYWFKnHXEX6ma4HHbK07XqumvZ19FZ4DA1KLl0ut9DnJ2JQUqz448fgU11OkS
	RHPNXUCCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghUJb-0005sd-Cq; Thu, 10 Jan 2019 06:59:43 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghUJY-0005sF-Nm
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 06:59:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9B718209EF; Thu, 10 Jan 2019 07:59:39 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6637F20729;
 Thu, 10 Jan 2019 07:59:29 +0100 (CET)
Date: Thu, 10 Jan 2019 07:59:29 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] clocksource: sun5i: fail gracefully when clock rate is
 unavailable
Message-ID: <20190110065929.3vqqzdhrcdkfxpyv@flea>
References: <20190110062207.18787-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190110062207.18787-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_225940_909966_053EFA9F 
X-CRM114-Status: GOOD (  12.00  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5282728345150306135=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5282728345150306135==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xobxpkhdrt4q2yph"
Content-Disposition: inline


--xobxpkhdrt4q2yph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 02:22:07PM +0800, Chen-Yu Tsai wrote:
> If the clock tree is not fully populated when the timer-sun5i init code
> is called, attempts to get the clock rate for the timer would fail and
> return 0.
>=20
> Make the init code for both clock events and clocksource check the
> returned clock rate and fail gracefully if the result is 0, instead of
> causing a divide by 0 exception later on.
>=20
> Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current cod=
e")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xobxpkhdrt4q2yph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDbtUQAKCRDj7w1vZxhR
xeD8AP9YfZ3756cbdi2l58QMJAF5x2SC7Munn8CWmq/qUjQfSwEApSGayIf49Ho8
wNJa4RC+ZB/73zekhANEnOPOyJihsA4=
=3Zx/
-----END PGP SIGNATURE-----

--xobxpkhdrt4q2yph--


--===============5282728345150306135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5282728345150306135==--

