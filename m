Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB6DC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:12:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401F620863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UdW1SEIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401F620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o/F5Sdfh5O9Z48UqQNsiJEjD+qezHxKmPBx5KCe3rFA=; b=UdW1SEIu+/EeIyRS1V62N1IuK
	xIQijQXssNAD76U8zpDCNp9IuvW0c9eXTYed8THIpr70ibwHzMoiajXUo0JDYMr5lS0CHtijL3SG8
	84vPjYk+sj5ae505pyhMjUffz9tLGtiVVI9zbpbmH/ozQ7s0jKp0ussTWTqDoXzVCGanNmgUJvrOa
	zwZDZ5L+NCs76xWS0ubuQkNbN4a8/b4i4+8+IX+cPfRxzxmMpu6UUkEEfG7dF4PnyZ59TxaQhzNj2
	9C/1J90wVPM+trdbgZ3PODYl8YcD2AQldTDylNItY2z5m8D/5zYKUeLUorgTvQGi9MS0yPIQiUUzq
	uBAeqnCQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpYcj-0004BI-He; Fri, 01 Feb 2019 13:12:49 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpYcP-0003ul-08
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 13:12:47 +0000
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 87834E0007;
 Fri,  1 Feb 2019 13:12:18 +0000 (UTC)
Date: Fri, 1 Feb 2019 14:12:18 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] drm/sun4i: tcon: Prepare and enable TCON channel 0 clock
 at init
Message-ID: <20190201131218.633gv3npsekliezj@flea>
References: <20190131132550.26355-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20190131132550.26355-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_051230_312859_EA63CDE9 
X-CRM114-Status: GOOD (  11.77  )
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
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3812780672718118684=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3812780672718118684==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mw7tj6i6edxi3mtm"
Content-Disposition: inline


--mw7tj6i6edxi3mtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 02:25:50PM +0100, Paul Kocialkowski wrote:
> When initializing clocks, a reference to the TCON channel 0 clock is
> obtained. However, the clock is never prepared and enabled later.
> Switching from simplefb to DRM actually disables the clock (that was
> usually configured by U-Boot) because of that.
>=20
> On the V3s, this results in a hang when writing to some mixer registers
> when switching over to DRM from simplefb.
>=20
> Fix this by preparing and enabling the clock when initializing other
> clocks. Waiting for sun4i_tcon_channel_enable to enable the clock is
> apparently too late and results in the same mixer register access hang.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mw7tj6i6edxi3mtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFRFsgAKCRDj7w1vZxhR
xWwCAP9nOM5TEB8sq5A3dUGCZ7iQqjy0qQCGIFOMG2kI5sFgNgD8D0dRKAXCf1j5
TIxNDj5ErrqgTSJqEagzyWos9NDO5QA=
=PWKT
-----END PGP SIGNATURE-----

--mw7tj6i6edxi3mtm--


--===============3812780672718118684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3812780672718118684==--

