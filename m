Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC62AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:50:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88522133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SG3K+2V4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88522133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jhgtf7uQ9yQdKllqMHd9dNyD5BQFjGFOnOWHGB3xNnA=; b=SG3K+2V40Euvlr6HYlEgq/+66
	5F1J+YxFpa8KezRo/1a2ZmhooSM2+QGaj2HXB3OX6aMZfknjsIztA+zLIX33fpp6/ULUVMbUl1cmd
	8Mu6PspwImc2LUa0f1hLbOwqhSkmvooL0tYul8a0sJQFAYbADhdof2Nw///zXlZxWYUaMnCL4BRaF
	xj4352NzUJmXDipE1K/QXuv2cqJ+6fJBO7Aum9cmpYtLMaqsg0PLaVm2BFSBTrB/xIxVzqeENLjGB
	sTeDqubUlfMvuUwm2bUoHcrgUCQXztnPYGQLdA/RCAwd8X6hpA19fS2Gxq9BTvpoCWDHDidSnQJ98
	oh57IFs9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYv9l-0004ry-80; Mon, 17 Dec 2018 15:50:09 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYv9M-00043W-IS
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:49:57 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 23E1F207B8; Mon, 17 Dec 2018 16:49:33 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2072C20858;
 Mon, 17 Dec 2018 16:49:21 +0100 (CET)
Date: Mon, 17 Dec 2018 16:49:21 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: sakari.ailus@iki.fi
Subject: Re: [PATCH v3 03/10] phy: Add MIPI D-PHY configuration options
Message-ID: <20181217154921.c4ttksa6bg2yxxjp@flea>
References: <cover.ad7c4feb3905658f10b022df4756a5ade280011f.1544190837.git-series.maxime.ripard@bootlin.com>
 <96a74b72be8db491dea720fdd7394bcd09880c84.1544190837.git-series.maxime.ripard@bootlin.com>
 <20181213204928.34hwq63nj5ircvkf@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
In-Reply-To: <20181213204928.34hwq63nj5ircvkf@valkosipuli.retiisi.org.uk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_074944_965686_9C3806B2 
X-CRM114-Status: GOOD (  11.92  )
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
Content-Type: multipart/mixed; boundary="===============1405032419390805505=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1405032419390805505==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kvr2vsrtqxz7hlll"
Content-Disposition: inline


--kvr2vsrtqxz7hlll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

Thanks for your feedback.

On Thu, Dec 13, 2018 at 10:49:28PM +0200, sakari.ailus@iki.fi wrote:
> > +	/**
> > +	 * @lanes:
> > +	 *
> > +	 * Number of active data lanes used for the transmissions.
>=20
> Could you add that these are the first "lanes" number of lanes from what
> are available?

I'm not quite sure I understood this part though, what did you mean?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kvr2vsrtqxz7hlll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBfFgQAKCRDj7w1vZxhR
xZZhAPwKCDQDW4bVEg3hzR1GYNwuPON5DLL3r3Zi5HNQcek09AD/YBnHdAdFW/zH
KvQ9ywl7y2WWIOusvw/3N4wDQa2/TwU=
=bDVi
-----END PGP SIGNATURE-----

--kvr2vsrtqxz7hlll--


--===============1405032419390805505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1405032419390805505==--

