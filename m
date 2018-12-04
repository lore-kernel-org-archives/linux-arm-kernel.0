Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79DDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:18:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2892082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tjgI5t7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2892082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S54uIkQUxLSKYqh56QIePOCALe2ex5G/7T+QL40t3FA=; b=tjgI5t7YM6/UNzFyJ9d5V2KxK
	NyaXDRcFvak4IZBM7OZrSqn5uZVj2veyD0waX/CMjlUEEIsLvl5Y8jT1eaLSETvAm1jf8jZGoKrQ/
	TY6/OJLBEZuK1fuMARrU82Suxvb6tMk7IyAiKpulJCwqNySAUQfX9ybtkFF9Alvn0pHoAs8rvtWyq
	DXsfkjqpyEg14eoUkd7MYnvrlb3eiUD7ha9S8Q47M3gjt/h/4ND5OSCBkyXq+TiUJv4AtEtMmODvA
	4MQvaZ3I8NUGcJighn/n72X3jsCHr0h5Tq9QcGG4qdzEetCiq6yzBVPbE4pUe4C2BpUH8LDurdhAf
	Si0N51FmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6qY-0002jq-2s; Tue, 04 Dec 2018 09:18:26 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6qM-0002PT-5t
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:18:16 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id BB16B20757; Tue,  4 Dec 2018 10:18:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 71E5B207BF;
 Tue,  4 Dec 2018 10:17:23 +0100 (CET)
Date: Tue, 4 Dec 2018 10:17:23 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 04/14] dt-bindings: rtc: sun6i-rtc: Export internal RC
 oscillator
Message-ID: <20181204091723.p2cvqzmsnnogxxfc@flea>
References: <20181203145825.20511-1-wens@csie.org>
 <20181203145825.20511-5-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20181203145825.20511-5-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_011814_542502_4331E389 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
 Rob Herring <robh+dt@kernel.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============8013944081877889012=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8013944081877889012==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ui42vfi36ynka5nl"
Content-Disposition: inline


--ui42vfi36ynka5nl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 10:58:15PM +0800, Chen-Yu Tsai wrote:
> Experiments showed that on at least the H3/H5/A64 the RTC's internal
> oscillator also feeds the CPUS mux in the PRCM.
>=20
> Export this clock through the device tree, instead of having to use
> a dummy fixed-clock device node, for the PRCM to consume. This will
> properly describe the relationship between the clocks.
>=20
> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ui42vfi36ynka5nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAZGIwAKCRDj7w1vZxhR
xcFyAQDQuWp+4AZRf3U61cakgx80JWbzOy9Eyg/mXLvkSWwcMAEA5zH4GrhdQXjl
yXDZofIYjsReyGlYhmvQjFCUPJUkxA0=
=390t
-----END PGP SIGNATURE-----

--ui42vfi36ynka5nl--


--===============8013944081877889012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8013944081877889012==--

