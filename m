Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8CC2F3BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:39:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1361520861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aP3of2lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1361520861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A0ojYoRiyYxDG0qW7GMcnjT912m2JiIasfg/eQZEREc=; b=aP3of2lzUfskcuzed81lO63DN
	M6OXgVjbvX+Qdxn4ZtT2od6E3Ojn6fSFbM1euR5w90LlWYZ1Z2XcBQFbBOz54dEmIzuNchCUuGOvH
	+2nVlzZpCRm3DyD6O9c1MGlDAFNMUavTYsqWOXQ/fQweAQMV4aZAlqLVMGJ6n+noqUqKzDtwoSqmb
	EZ2X99qNBtFEG1gp3MFUgSo/eVh+Z8glllstRDGY4Syhuv8RxB8UWm50Td0Ya7J4syYlxHxhLOW4V
	Tve7JMrl+b7IJxwZfPFO2A8bn0JqgS+I5WrWOqQjCKlslP9h8Ww4E3sLEMutvGVgLnR01vnyDQJzn
	cx4O0kSxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZnh-0004qV-4J; Mon, 21 Jan 2019 13:39:41 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZnd-0004q6-EL
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:39:39 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id BECDC207B2; Mon, 21 Jan 2019 14:39:34 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 848C5206A7;
 Mon, 21 Jan 2019 14:39:34 +0100 (CET)
Date: Mon, 21 Jan 2019 14:39:34 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v4 8/9] phy: Add Cadence D-PHY support
Message-ID: <20190121133934.5e3uwk5x6vzno36w@flea>
References: <cover.5d91ef683e3f432342f536e0f2fe239dbcebcb3e.1547026369.git-series.maxime.ripard@bootlin.com>
 <a089ce6aaefe6d2ddf6b17f5558ec7eb0ebf3774.1547026369.git-series.maxime.ripard@bootlin.com>
 <20190117135322.GB114153@art_vandelay>
MIME-Version: 1.0
In-Reply-To: <20190117135322.GB114153@art_vandelay>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_053937_619155_68AE7C30 
X-CRM114-Status: GOOD (  11.45  )
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
Cc: Rafal Ciepiela <rafalc@cadence.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Krzysztof Witos <kwitos@cadence.com>, Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============7274268328884066551=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7274268328884066551==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hzi2fvtnjykoiksc"
Content-Disposition: inline


--hzi2fvtnjykoiksc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Thu, Jan 17, 2019 at 08:53:22AM -0500, Sean Paul wrote:
> On Wed, Jan 09, 2019 at 10:33:25AM +0100, Maxime Ripard wrote:
> > +	opts->wakeup =3D cdns_dphy_get_wakeup_time_ns(dphy) * 1000;
>=20
> This should be "/ 1000" since the units of wakeup is us now (thanks to pa=
tch 2).
> You've made this change in patch 9, so I think it's just a misplaced fixu=
p.

Good catch, this was fixed in patch 9, but it definitely belongs there.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hzi2fvtnjykoiksc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEXLlgAKCRDj7w1vZxhR
xW+LAP4zEe1z/qdpFjO7LKfIjMbOAWFDH1HPxrfSrGKjD/8GtwEAztE37tEckDJq
RYu3qFgjy6BMgbB4/6tjGMfKoB2b0AI=
=rG2u
-----END PGP SIGNATURE-----

--hzi2fvtnjykoiksc--


--===============7274268328884066551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7274268328884066551==--

