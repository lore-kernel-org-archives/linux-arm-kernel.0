Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A92C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:15:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F10206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mKlpTSHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F10206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mm8WRiVNj8sGr3szp65/09T8wU5sfmbrSbaSH6Wv6ho=; b=mKlpTSHW43ob+C9a11H8XtKIS
	jAxLpfmI7uxG565YdHGpyEShh9ybjKfmYSnODiHqN/dpccD3s7v66lCIYkUd0dkGPh8gutgqayNcw
	zyNDp7VswbqBvd3U9KjiwVu/jYdU5G9vhQm7uFO7SxCxj5KDzt/a+n0dY7jKSH+ZENRSRNeiexEkb
	/e6GuV/y3KbI/TvdeBdSch46gqo6WRIEQTZJBDMCY/+oiVnepXezPZtbcZYfNxzNKGr1nM/vVG4QX
	Xd//6oZrnkv3D+2Sgk2AYsFj39d4C8S+Y7rYvoaMWBTLgAoP/Pv29uHpV6niMWedLwVw/4ZNo7Jsj
	dv4sHrOZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTbE-00032l-Du; Wed, 20 Feb 2019 15:15:52 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTbA-000320-Qj
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:15:50 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 9DD4760010;
 Wed, 20 Feb 2019 15:15:42 +0000 (UTC)
Date: Wed, 20 Feb 2019 16:15:42 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mans Rullgard <mans@mansr.com>
Subject: Re: [PATCH 3/3] ARM: dts: sun7i: add /omit-if-no-ref/ tags to pin
 group nodes
Message-ID: <20190220151542.dy2tdhw6cy5cn447@flea>
References: <20190220142536.21051-1-mans@mansr.com>
 <20190220142536.21051-3-mans@mansr.com>
MIME-Version: 1.0
In-Reply-To: <20190220142536.21051-3-mans@mansr.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_071549_014865_CC0BC90C 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5890087692014309175=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5890087692014309175==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ltjeimt6pxkykty5"
Content-Disposition: inline


--ltjeimt6pxkykty5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 02:25:36PM +0000, Mans Rullgard wrote:
> Since only one alternative at a time is used, and some functions may not
> be used at all, this cuts down the size of the board dtb files a bit.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied all three, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ltjeimt6pxkykty5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG1vHQAKCRDj7w1vZxhR
xfpiAP9iVGo/0QxZrPmzUGNSLgkjVMj9DM6NeQ7RbTYZwtQz4wEAr+RWmjKQyocX
s8L2GhyvS60EBT5vsQL7ON8h0fUJ6wU=
=pYmc
-----END PGP SIGNATURE-----

--ltjeimt6pxkykty5--


--===============5890087692014309175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5890087692014309175==--

