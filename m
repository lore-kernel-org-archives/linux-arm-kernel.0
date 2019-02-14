Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50363C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F30F2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EchT/m+5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FHIkvfMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F30F2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ApfMtHka53ZeF9fADBuXL0Q3JqQqrBuq2AIbvjdWB6c=; b=EchT/m+5HDn2sgkaFOJ3qru9O
	jZkakOL2iD0F+bVe8PC3byRmMAgvCr++k3EJHosuR0vW49WhG5iPYbn+mHXtVpZ4bK13LD5WR3kBt
	vhuJRM65EtbrNAFlf/WIWH8Aq3lhZ7ymxY/QsSYX8AbzbqsDztkf5TLNfXeu3qFxPHqUpn7r0+uYx
	JUI1g0ebCfY1rP6UtgmizyPQLCZPsuDipLLSmOO29DHv3hHXVCK+iDkwIhK770n/SbJ0QZnALsi+B
	F/v07SJS98wIMjI3IGiAZIVETKrMcCVDABTsLkSQT039DCv6hw2ts9rRp7fktYNCNqtdS1krAlLjv
	waZZHwcPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guDFA-0007lw-C6; Thu, 14 Feb 2019 09:23:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDF7-0007lh-MT
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 09:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QuBsJfoVKqxKfRXonapsyYqBlgdbjjKx8y6moRvGhdI=; b=FHIkvfMFeDAgQWTG7dXhohUZp
 sO71Q2NlktbS8dk3Fgn2y9RN6OdDSmZmSNsTbSQf7AM80gVb1sGwhRsJ1dq7TfMwJvmZ2WIZp03Aa
 Kzvz4/EupWMJFgQmaD6AmWVQcAZWfOzRZxyfXeonV9Mt3nKON0JVq+G5XraP+kiRSOvaAbQGyny51
 ZY0HkTy+9sHEoHTmQ3JaZTbuj8D/YY/4M9BsVzgzufe/sg+9sT/fEbHOWFoTF0bo8o9C04Jx4NQoH
 4jx95wWtj1mhMa4hzP0iRaeDC50ErAXJezxKa+Wy0ZD+JgB/Czk1G4KjcmOnJ0DUhppx3cidJdxhX
 KIwD/mbFw==;
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDF4-0002c9-AL
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:23:40 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8162D40004;
 Thu, 14 Feb 2019 09:23:00 +0000 (UTC)
Date: Thu, 14 Feb 2019 10:23:00 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 5/8] drm/sun4i: dsi: Fix DRQ calculation
Message-ID: <20190214092300.nb7cj7cr6rzyvjlo@flea>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <e858ff6509e0d3f657fd9229b28f4ac177a04a76.1549896081.git-series.maxime.ripard@bootlin.com>
 <a170e16bed016b0ba79b4f0a1181639598c7b205.camel@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <a170e16bed016b0ba79b4f0a1181639598c7b205.camel@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_092338_402190_73029E7B 
X-CRM114-Status: GOOD (  17.55  )
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
Cc: bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8598925807192026891=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8598925807192026891==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r3umqet5qhxxxeta"
Content-Disposition: inline


--r3umqet5qhxxxeta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 03:33:38PM +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Mon, 2019-02-11 at 15:41 +0100, Maxime Ripard wrote:
> > The DRQ calculation code in the Allwinner BSP uses the vertical front
> > porch value as the condition, but we're using the video back porch.
> >=20
> > Since I always confuse the two, and I'm the original author of that cod=
e, I
> > guess I deserved a brown paper bag.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> Assuming that the BSP's hbp is referring to the back porch only, then
> calculating ht - x - hbp does give us the front porch + hsync length.
>=20
> Well, let's guess that this about the front porch only until we know
> better. It's certainly better than using the back porch anyway :)

After discussing it with Paul, we decided to drop that patch since it
would make the backporch definition inconsistent in the driver.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--r3umqet5qhxxxeta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGUzdAAKCRDj7w1vZxhR
xa0fAP4jJ+lUOlun17orkb3xW8mVTcX8yPsY/A9kle5oElJgxwEAjEplHMI8orL4
e9LGoTF0IZeKNRdY7N9YpzJsjTORlAU=
=xldS
-----END PGP SIGNATURE-----

--r3umqet5qhxxxeta--


--===============8598925807192026891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8598925807192026891==--

