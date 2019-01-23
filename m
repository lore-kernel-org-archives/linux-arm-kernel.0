Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00588C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:44:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AB021873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ApLAXx9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AB021873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qGx2cKFvbyEddhG0PRE/PeIn7R7HbCIlcgtW2XuYiJg=; b=ApLAXx9BCJjVTZwNjArGkMNIh
	ufEos/VQfurtoVsulFtoi+N8tc2OZOrpPHZ97P4SM3a2bddWmUsQfq82eEKsCr4HsJ7MVgPszR0t3
	GExt1o6GnoIYhmkNoBFY8tKLgmS1BIR8dgogToM0ISkK4snMl/o/QdoABnGTfBUc3JXB+CKvnergg
	KtnA8X88fo2sAaS/hij3oGXFsMHOpHtgC3Wz97VKnoF6AplS08fSrT+jJfE8fjzpNKJ+/7sWfB2Bg
	keYlFQAcoWEI7Jb6gjYoHEmcQLTVuFfBRxLV/MSCAvvmbZixiOAnsPvbGE9Akh/0uFWdgQ7LvVCpr
	zzQXeJ6VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKhr-0001ch-8a; Wed, 23 Jan 2019 15:44:47 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKhn-0001c3-F9
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:44:45 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 65FC2207AC; Wed, 23 Jan 2019 16:44:37 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 28D672077B;
 Wed, 23 Jan 2019 16:44:37 +0100 (CET)
Date: Wed, 23 Jan 2019 16:44:37 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v6 2/6] media: sun6i: Add mod_rate quirk
Message-ID: <20190123154437.zjrpzzsenoioi43e@flea>
References: <20190118163158.21418-1-jagan@amarulasolutions.com>
 <20190118163158.21418-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20190118163158.21418-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_074443_636751_0785BD23 
X-CRM114-Status: GOOD (  10.16  )
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
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============2186402540845276425=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2186402540845276425==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yz2zv5rwxvomehn4"
Content-Disposition: inline


--yz2zv5rwxvomehn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 10:01:54PM +0530, Jagan Teki wrote:
> Unfortunately default CSI_SCLK rate cannot work properly to
> drive the connected sensor interface, particularly on few
> Allwinner SoC's like A64.
>=20
> So, add mod_rate quirk via driver data so-that the respective
> SoC's which require to alter the default mod clock rate can assign
> the operating clock rate.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

You still don't need the variant stuff. If the sole difference is that
we need that clock rate to be fixed, then the following patch is enough.

http://code.bulix.org/9au998-562745?raw

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--yz2zv5rwxvomehn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEiL5QAKCRDj7w1vZxhR
xW+OAP9I14o2aqaDvi2Zkm7tBUQNgMKU5/cRvH0+/vPUZBw7tQEAi4AHCxrJMB7W
dAeL9m2LXQ6M4nDrZE51/vBKoTOpQgM=
=UHSo
-----END PGP SIGNATURE-----

--yz2zv5rwxvomehn4--


--===============2186402540845276425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2186402540845276425==--

