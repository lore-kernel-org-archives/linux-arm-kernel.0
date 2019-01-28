Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1610C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:52:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C7A2173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VQE0pmCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C7A2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=m0a9Q/vHYV9zwBvIWxzAdn5BBYMFGAzO7001BBvoIes=; b=VQE0pmCA5E0wBGSCa0Min5A2l
	MotdXOEi1gM9oIHjzeI8azf4cEJEtgzrtbDBFXNJlXnr0odl1tZCQAqNorXU18h0RJcmX0nmh+2PX
	clFteodBWlAuXMpOiWwk2DBWyrcFB3oD8ueb6EssoGTiNhOIx6PvNZ81XL7f7z1bwQqlWRgnQNJDG
	QmS0qo/tYkziTjOCur3F9rwVeJ5o90nl+YtDsGMtZvheDGOTkEAjHQB8j7Hpnru2Jv7Nicr+X8dJz
	Zvll0AZzkCCr5h3WngCMdG/8p5emUCMhKjsXMQWVq4IF2affjA8+UAxAZ0aVCSLv1IX5rco3bt53R
	LbmNaMzvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4Wn-0007dp-AY; Mon, 28 Jan 2019 10:52:33 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4Wk-0007dP-AN
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:52:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 95C23209BE; Mon, 28 Jan 2019 11:52:28 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6805320746;
 Mon, 28 Jan 2019 11:52:18 +0100 (CET)
Date: Mon, 28 Jan 2019 11:52:19 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/5] ARM: dts: sun5i: q8-tablet: Move panel properties to
 correct node level
Message-ID: <20190128105219.wcqbvhwx7jol6xru@flea>
References: <20190127144838.3578-1-wens@csie.org>
 <20190127144838.3578-3-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190127144838.3578-3-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_025230_491899_EEB8D3C2 
X-CRM114-Status: GOOD (  10.92  )
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
Content-Type: multipart/mixed; boundary="===============3008989013944376873=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3008989013944376873==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6yewbv6ulml6pqsg"
Content-Disposition: inline


--6yewbv6ulml6pqsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 10:48:35PM +0800, Chen-Yu Tsai wrote:
> The panel backlight and enable GPIO comments were incorrectly placed
> in the input port, while it should have been in the panel node itself.
>=20
> Move them to the correct position.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6yewbv6ulml6pqsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7e4gAKCRDj7w1vZxhR
xfueAQCjCmHYrA3dtRPvjiEa025rCGRZz+ocfCBr1Hiv45CA6AEAix/jzeKZsxQ0
VFWfkwqFeDEf6n3kTXp9u82cb38QmQA=
=l5GA
-----END PGP SIGNATURE-----

--6yewbv6ulml6pqsg--


--===============3008989013944376873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3008989013944376873==--

