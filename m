Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BCEC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:51:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439182148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IR2eCf4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439182148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xDw6xD1SnjMZ1XaLu/dzMsayllXVZ2ga4qf4dATG1Ow=; b=IR2eCf4KjD2lz9pFXG7faqE+I
	dE4XtaAmm9ilV1kqC6gB+8mSrPyQ2xChiBMxsGpSk9+PrqkO8SscVmUqwvMKf2XPhtLwyS0H4pW3f
	JCglcBGQR1YPAlOVzT8jnPlknufJnNrqlR97syVfLv5c7Ei66jSRGRitVvEGhT6YFaNmq+1lVPubR
	YaGEKuMo+1ewCBaNCiUIlMA6yLxt4yQy1wRQ6zKPfCtuClj4a5zvy6uFGxy8rBbbharibB2SQZMjB
	PyHvEWCu2iAXnhkuEODH5ZmYz3GTGtvRJ2HxYj0ndCbQRN9n4lbeaiG3u3cfaboY7I5rhIyxPSvy+
	RZPKmipYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4Vg-00076N-N3; Mon, 28 Jan 2019 10:51:24 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4Vd-00075b-NC
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:51:23 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 98C5020746; Mon, 28 Jan 2019 11:51:18 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6693320654;
 Mon, 28 Jan 2019 11:51:08 +0100 (CET)
Date: Mon, 28 Jan 2019 11:51:09 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Move GIC device node fix base
 address ordering
Message-ID: <20190128105109.xijxn7wndund3ric@flea>
References: <20190127163930.985-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190127163930.985-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_025121_886511_05B9041D 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5090670768522406241=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5090670768522406241==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tixpi6cs6e2fc5of"
Content-Disposition: inline


--tixpi6cs6e2fc5of
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 12:39:30AM +0800, Chen-Yu Tsai wrote:
> The GIC device node was placed out of order in the initial device tree
> submission. Move it so the nodes are correctly sorted by base address
> again.
>=20
> Fixes: e54be32d0273 ("arm64: allwinner: h6: add the basical Allwinner H6 =
DTSI file")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tixpi6cs6e2fc5of
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7enAAKCRDj7w1vZxhR
xUEhAPsFv64cA9oqagr7M+btWbx1dy+BrVWq0CZlEBlcM9I5FAD/fiYfjkCqeqoi
tdqrZhJGV4pDJJKRpVHL1qNcjBk06Qo=
=iVZa
-----END PGP SIGNATURE-----

--tixpi6cs6e2fc5of--


--===============5090670768522406241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5090670768522406241==--

