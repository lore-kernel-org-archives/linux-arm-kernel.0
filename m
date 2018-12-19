Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86609C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:41:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5475E2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PCBXZh44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5475E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=srX9LntphoznLimKWc9JaU0Mzyb8FF2I8Ru/O0l818g=; b=PCBXZh44C39fVnp0Z6oup3mPd
	BqioZaCubsUGsGk5l/nDlW4OdiF2HoLtSjxbMaJ8EF+d1Cr3P3xWDNhVDkiwVYrLFcKk1mFDqd+0s
	28RudwRy02UwLyHpF/hcrPs8CcbJoeXqCpeKZsWaWibo0nfNOhSTm3cSGyHVz0CfUst02fBEmrYhz
	7Sjr45/neyi6xUNYADKa1SvTJIxcggTRe3bXcavo66s/xnHpvSRQGRc5LHLsEvTWeB+SEWk1T8CFs
	MS3H/NnE+lxhQocp9GYHL404yO52khyey7xtVlfHQ4gnBZtDVlW0Hk6Zk0p2F8SAO6LzkfPcSrrfo
	4/U+0xwZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdyG-0006UV-Rx; Wed, 19 Dec 2018 15:41:16 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdyD-0006Ti-LJ
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:41:15 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4BE3920AB9; Wed, 19 Dec 2018 16:41:01 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id 975F4206A7;
 Wed, 19 Dec 2018 16:40:39 +0100 (CET)
Date: Wed, 19 Dec 2018 16:40:40 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: sakari.ailus@iki.fi
Subject: Re: [PATCH v3 03/10] phy: Add MIPI D-PHY configuration options
Message-ID: <20181219154040.k424xkzz3xap6462@flea>
References: <cover.ad7c4feb3905658f10b022df4756a5ade280011f.1544190837.git-series.maxime.ripard@bootlin.com>
 <96a74b72be8db491dea720fdd7394bcd09880c84.1544190837.git-series.maxime.ripard@bootlin.com>
 <20181213204928.34hwq63nj5ircvkf@valkosipuli.retiisi.org.uk>
 <20181217154921.c4ttksa6bg2yxxjp@flea>
 <20181217202039.zhsxozdw7dlc3xdj@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
In-Reply-To: <20181217202039.zhsxozdw7dlc3xdj@valkosipuli.retiisi.org.uk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_074113_837435_24FCD0F9 
X-CRM114-Status: GOOD (  17.63  )
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
Cc: Archit Taneja <architt@codeaurora.org>,
 Krzysztof Witos <kwitos@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>,
 Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============8085747928743803355=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8085747928743803355==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5iqyg7jbpm2uyidw"
Content-Disposition: inline


--5iqyg7jbpm2uyidw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:20:39PM +0200, sakari.ailus@iki.fi wrote:
> Hi Maxime,
>=20
> On Mon, Dec 17, 2018 at 04:49:21PM +0100, Maxime Ripard wrote:
> > Hi Sakari,
> >=20
> > Thanks for your feedback.
> >=20
> > On Thu, Dec 13, 2018 at 10:49:28PM +0200, sakari.ailus@iki.fi wrote:
> > > > +	/**
> > > > +	 * @lanes:
> > > > +	 *
> > > > +	 * Number of active data lanes used for the transmissions.
> > >=20
> > > Could you add that these are the first "lanes" number of lanes from w=
hat
> > > are available?
> >=20
> > I'm not quite sure I understood this part though, what did you mean?
>=20
> A number of lanes are routed between the two devices on hardware, and this
> field is specifying how many of them are in use. In order for the bus to
> function, both ends need to be in agreement on which of these lanes are
> actually being used. The current practice I've seen without exceptions is
> that these are the first n lanes.

Ah, right, I get it now, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5iqyg7jbpm2uyidw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBpmeAAKCRDj7w1vZxhR
xTnFAQCP+5QVwIA2UFCKHNRgxL3GIau3a9c+AWOb3EwOgHtSKQEA9BNznxa/TFI6
EtTZ9A7KaebGQBSMkfkKIaBrEGGaqQQ=
=PQh1
-----END PGP SIGNATURE-----

--5iqyg7jbpm2uyidw--


--===============8085747928743803355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8085747928743803355==--

