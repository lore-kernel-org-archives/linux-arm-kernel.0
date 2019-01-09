Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:34:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F70206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NFtLc7Ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F70206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8rV+c3/DVlg+Syf0o2XW03SoiQsDfQAkYLUj1SqbXLQ=; b=NFtLc7EfEB96YNAmo7Ijwd3Va
	cNPVMsEHwb/d60Wigb9o8bbM28Kw+7QL5dUnJuOxJwMFjKp+eLJbxnqwyoBaH7uICdMLvs7iUyC+J
	e/c11qFEz+GuS9ZTAIubiKphknmSNQMWEZvhemMf+bSAJ5cQHXOeJ/PIXZpFEomvncupwJnt+44wQ
	lXzOqGzQIs//v94mwTAOQQyGFdLiUO2Ip41sIhYn3bH1YsoumONEUrWFkOGYYo+OrrIcgube5qh7L
	sus5Z5vZNWcM7XeUbfAOsEqDojEu5Deq+c4bF+7bJ8ifHpkziiDGPFhvb758Fdn7A/Y0UTC0NnmX1
	Cl30YtGxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghFs5-0005xW-4N; Wed, 09 Jan 2019 15:34:21 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghFrh-0005bM-KJ
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 15:34:18 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0D937209C2; Wed,  9 Jan 2019 16:33:56 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr
 [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id D1AF520750;
 Wed,  9 Jan 2019 16:33:45 +0100 (CET)
Date: Wed, 9 Jan 2019 16:33:46 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 0/5] ARM: dts: sunxi: Enable Broadcom-based Bluetooth w/
 serdev
Message-ID: <20190109153346.j5pdwiemr2hm5zwp@flea>
References: <20190109150257.12602-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190109150257.12602-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_073358_324920_4E71460C 
X-CRM114-Status: GOOD (  11.09  )
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6179252692498040159=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6179252692498040159==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7isc5e2z7w7wkzjn"
Content-Disposition: inline


--7isc5e2z7w7wkzjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 11:02:52PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This is the second batch of patches enabling Bluetooth for Broadcom
> (AMPAK) modules using the new serdev bindings.
>=20
> The patches are self-explanatory, so I won't go into the details here.
>=20
> This pretty much covers all the boards I have that have AMPAK modules.
> The only ones missing are the A80-based boards, which I haven't gotten
> working yet.

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7isc5e2z7w7wkzjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDYUWQAKCRDj7w1vZxhR
xVihAQClCnG8x0raI5CQ7dKaKeoWKQwGo8H+6WpIn0b+8O4bdwD+LnwurzsULmms
zM+Mk2jGqBp3tj1ZPgsayaA7rV3oBAI=
=/Icm
-----END PGP SIGNATURE-----

--7isc5e2z7w7wkzjn--


--===============6179252692498040159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6179252692498040159==--

