Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BADEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:16:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC87520850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iXY0GgVI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cw4TLuDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC87520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1AmjmGNx2Ne6ruhYZLn9tdY5zV1UoEcqO6oJDcNlobA=; b=iXY0GgVIHL8Ta4w5/g4UlPr8r
	kyIh4gSnRtCDoHV1/CPaqU30DkAIALbIdFz08nFg6LtvsLTbWpxR0ZQW8Nr2wUzA/kx94Q6PZbigK
	WQgK+lsr4YsnFeiI+cyVmS8bcWIkU4eHYCiZ8PuOfQPEznj52G/Ssoz9hXG3RiAALSnuJxaBcohD2
	oFgxyd85kzIEnjvKsQipwKKrcNj5Whuzw93tXIDb7mqU36R2or7GH+laSGf49NbAe1QArQHDMsjTw
	Hc4BKajFsyoDnwOUx1NpvC1IjPiyWfysIt5QNCi3ybxUxS7++CdnxtE70Y3cNWvrN3wz0ehUYLuZK
	EEMY5hRvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUV9l-0005no-JM; Wed, 05 Dec 2018 11:15:53 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUV9j-0005jU-TX
 for linux-arm-kernel@bombadil.infradead.org; Wed, 05 Dec 2018 11:15:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mi3xgCjAjLRUwegbon2LjyKMT8ZPqmAII6YqG663FIA=; b=cw4TLuDLUWeH4Vh1eWXvpN2d+
 1exYmE0d6YAz01gFeZ62V4M4HnU/T2OnBm3wYbPCHR8ucb6H/qKEtcJwEvXSCUbApwkP40k8+qqmF
 FBlvsa6ObYHndVodHkYBBTV/2LGoNwPNcxSZarWVapxHcMeTGczSQ+FvWozCq+SFbdP6Zvj/ywMny
 X4UTdP1GTtgzqwcHO++9xtcGPHM8Jz/tadbHEbgs2O46c28Qni/MfUPqO/GwDzw6G8w7CPJ0JvhFO
 /FWnjT9hPIi/NIH2FdPMvPKzKGjE9DFohOy2aIphentmTGmwWorlO8sutAgdOXBtuXDFHYo+utwP3
 aM8QotXQA==;
Received: from mail.bootlin.com ([62.4.15.54])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUv0-0002K3-Bq
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:00:40 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id C8F4A20C18; Wed,  5 Dec 2018 12:00:26 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2595B20CC9;
 Wed,  5 Dec 2018 12:00:09 +0100 (CET)
Date: Wed, 5 Dec 2018 12:00:09 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 11/15] dt-bindings: media: cedrus: Add compatibles for
 the A64 and H5
Message-ID: <20181205110009.f4st7fspaxiphnmn@flea>
References: <20181205092444.29497-1-paul.kocialkowski@bootlin.com>
 <20181205092444.29497-12-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181205092444.29497-12-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_110038_427628_D09201DF 
X-CRM114-Status: GOOD (  14.66  )
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
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============2908129746157032194=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2908129746157032194==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lzx3jafuwqktgjoq"
Content-Disposition: inline


--lzx3jafuwqktgjoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 10:24:40AM +0100, Paul Kocialkowski wrote:
> This introduces two new compatibles for the cedrus driver, for the
> A64 and H5 platforms.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lzx3jafuwqktgjoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAevuQAKCRDj7w1vZxhR
xftIAP9U8aHjcpqk2dL0l0oLpZZiJ6ZMEbXUCrgStsWNlU9QvgEAvrnA6bduvOGH
8X8BVPhBM60c42rwTEoR3v7eqRifswQ=
=6tph
-----END PGP SIGNATURE-----

--lzx3jafuwqktgjoq--


--===============2908129746157032194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2908129746157032194==--

