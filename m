Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5489AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2139320645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QYP7SGeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2139320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+8hhDQG2ghI7UO623oMapKMj+UcaE5geokK5rnPMeDI=; b=QYP7SGeLsizyTw5tY86nc7u1G
	gPiheUdyK6suhcuC7aoTK4QjxLQjtnTtKl9zEH/HERmiz4JwIvOAJaNUs4rlZU1kzE9AYpSmOvvGs
	Qh0QJcfXCVA4Xn3kauiY7p3oanX+5uFDz8n7dziK3HfXC5FzDZbbdqkRU9QGiikRUTKYPRatVa/8t
	SFeVq4tnMLzMXg2vquKAnJ6TfYTI2EfrKEgQNMdLbKz3/lfIi0yJNITIVG7bVFchspyEO9E8dlPfo
	KsNblCWqVS5PRRrKfsBKJIHIvaLsf8FtvNrmhPSSap7uc/r1FbYP1lnTWMBjNwa76+L2I/Kj8ONHC
	MSoPl0U3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjR5x-0005mJ-7s; Tue, 15 Jan 2019 15:57:41 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjR5L-0005EJ-Gu
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 15:57:05 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0D61A20A2E; Tue, 15 Jan 2019 16:57:01 +0100 (CET)
Received: from localhost (build.bootlin.com [163.172.53.213])
 by mail.bootlin.com (Postfix) with ESMTPSA id DAD9B20A32;
 Tue, 15 Jan 2019 16:56:50 +0100 (CET)
Date: Tue, 15 Jan 2019 10:52:28 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Fix a typo
Message-ID: <20190115095228.kwhgtumqcechpr5j@flea>
References: <20190113161413.14654-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
In-Reply-To: <20190113161413.14654-1-j.neuschaefer@gmx.net>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_075703_689612_35193242 
X-CRM114-Status: GOOD (  10.30  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8573006462231734068=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8573006462231734068==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mochvrg5c7cnhkly"
Content-Disposition: inline


--mochvrg5c7cnhkly
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 13, 2019 at 05:14:13PM +0100, Jonathan Neusch=E4fer wrote:
> This typo inverted the meaning of the comment, but the rest of the
> comment and the code reveal that the regulator in question needs to be
> on at all times.
>=20
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mochvrg5c7cnhkly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXD2tXAAKCRDj7w1vZxhR
xfD7AP4qywnKHNgiMVKQgQm9Unl856D2G5YayGFo46hzFw/4MQEA23fYuGlEoHwa
xCIReP3XHYr04DGgK/uAsJW/1WkT9Qg=
=kEiC
-----END PGP SIGNATURE-----

--mochvrg5c7cnhkly--


--===============8573006462231734068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8573006462231734068==--

