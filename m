Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C171C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:47:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020DE20449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f8ALMF2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020DE20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/MONgIgqlSCAEDt02ZIMMirjoWnQG61Cazgw7lgqU1g=; b=f8ALMF2fAH6NznGR+V36dLRwL
	VqC8gcRBMg/L2ACoo8QRyu++jkeJ66GawVz9U1rwDcraEzaKDxt/Ih5+HgbugrM7eXZr8SYuv26Yr
	eEM0veBZBVhLk7NYZl/Hcne+QaOFQABoD7gOwvLI9YqxjKgWaXHSFi3I0WtE0nhFkxkwdHc6zdg+M
	8XwgdhZ+yRcAHSP9qD3ZHc7/uHaCDrj0ZnIkUkpmerU0Wf2/+QDPA8oueFR8SIBl2zrRm7S4niD4h
	Do0kNgGGRBM5E5OPOp1lh10zzad7y5HHX6R219FR8tQO2r4y8rNexOGC+Uqyt+scgFbw8UdS6PcZq
	7b2eA86BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZe4b-0000XT-On; Wed, 19 Dec 2018 15:47:49 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZe4X-0000Wp-Ql
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:47:47 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6FCA320A66; Wed, 19 Dec 2018 16:47:34 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4019720775;
 Wed, 19 Dec 2018 16:47:24 +0100 (CET)
Date: Wed, 19 Dec 2018 16:47:24 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add PMU node
Message-ID: <20181219154724.5vgnchh4q6e37rek@flea>
References: <20181219154017.6104-1-harald@ccbib.org>
MIME-Version: 1.0
In-Reply-To: <20181219154017.6104-1-harald@ccbib.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_074746_001925_913266C0 
X-CRM114-Status: GOOD (  10.88  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>
Content-Type: multipart/mixed; boundary="===============7028820018772895156=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7028820018772895156==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mxebwxi4mpovw2u2"
Content-Disposition: inline


--mxebwxi4mpovw2u2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 03:40:17PM +0000, Harald Geyer wrote:
> This is necessary to use 'perf' for cache profiling etc.
> Tested on Teres I Laptop.
>=20
> Signed-off-by: Harald Geyer <harald@ccbib.org>

QUeued for 4.22, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mxebwxi4mpovw2u2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBpoDAAKCRDj7w1vZxhR
xT8OAP4hKj9yhCNIH9y0VtKzlsBc0JcJjZ9B/2bkdJjxMb/4GgEApvCEQ4zZmIMd
aTplaa6WSM7W3XzvimeNVRSbswW5kg4=
=36KO
-----END PGP SIGNATURE-----

--mxebwxi4mpovw2u2--


--===============7028820018772895156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7028820018772895156==--

