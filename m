Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69EEC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:11:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974AA21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZCmfeNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974AA21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T+0BtciSckA/ppJWBA4hnbyRr9XX66vvAsP9y3wwFTQ=; b=cZCmfeNHasi8E8wsHknFfKToZ
	zsCLCaV9hWwYELWczUTFH8MZuMac71cNWDX/lTHjJ886IPJjuPFMZHZqgkuilaIxRe/fIR+/OYdHN
	9FLVXz7KpsVUaNw7oJEQMNJyFc8FBaeGbAwu2cxXfGhl2Z5+OPx9ghH8F4FZ0QpszZPLCwlm1qq9w
	et6g9cEhH8xrpaE+bliFMre9iQp/Y5dL0rhNwrvugkBJxAUUmCzysZQeIJxzu5qMBC5DTkl5UGWI0
	0SaI5c0fqbPZ05tehZ802Qsc2UNQz2VS3KRUBbVTW7LpsomspYtv0nFLR6HbfpSrYDXfhsAPdNfJq
	HzOPJq5VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghApz-00079i-Q7; Wed, 09 Jan 2019 10:11:51 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghApw-000799-SA
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:11:50 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8C54020A2A; Wed,  9 Jan 2019 11:11:47 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr
 [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5366920A08;
 Wed,  9 Jan 2019 11:11:37 +0100 (CET)
Date: Wed, 9 Jan 2019 11:11:37 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] ARM: dts: sun6i: Add clock-output-names to osc24M clock
Message-ID: <20190109101137.sh6ioyvq5wm6ug23@flea>
References: <20190108072526.2621-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190108072526.2621-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_021149_040892_3AC7572B 
X-CRM114-Status: GOOD (  12.87  )
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
Content-Type: multipart/mixed; boundary="===============1711590287809271672=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1711590287809271672==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nrrmjmmauuftwoov"
Content-Disposition: inline


--nrrmjmmauuftwoov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 03:25:26PM +0800, Chen-Yu Tsai wrote:
> The osc24M clock does not have a "clock-output-names" property, which
> means that the clock name is derived from the node name in Linux. The
> node name was changed in commit acfd5bbe2641 ("ARM: dts: sun6i: Change
> clock node names to avoid warnings"). This breaks Linux as the sunxi-ng
> clock driver implicitly depends on the external clock being named
> "osc24M".
>=20
> Add a "clock-output-names" property to restore the previous behavior.
>=20
> Fixes: acfd5bbe2641 ("ARM: dts: sun6i: Change clock node names to avoid
> 		      warnings")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nrrmjmmauuftwoov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDXI2QAKCRDj7w1vZxhR
xZmoAQDm3bL9J9jdFm0jYD84rJW8RuzHZuBZQrjMhlByqYpQvQEAo9PkDmEnw3O+
FXvx0AK+HIKpG+Beknn8yqrrudy3+wI=
=rytg
-----END PGP SIGNATURE-----

--nrrmjmmauuftwoov--


--===============1711590287809271672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1711590287809271672==--

