Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED3FC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:10:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D690207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fPFo/J0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D690207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B1teKK6ta5e2drq9+aFKlqQd87H21Dda7bmTJ5B3KdQ=; b=fPFo/J0YHLq5v/5oImQhmuyfA
	79bjRIYOsKE7gJkyy/eFIlyJLgCD+KdP5V4Db9BswcAfDyUjcwJwmYychhmsB2aMV+T/Xsc2FIHJi
	0/iAUOc9NODvwdymsatQGfint01G51k1fLLcQYaxZkwoOq/gd/WB7HuT9GetHVenyY1smX/OTbO3H
	UTTWNINUrFUwAJp0mCvJQwFsHesn4TY5EIrYyrXny+K7ey0caiEIjUKnA7JTqycWP5EmLDcNR8X2V
	GDOMFjrU5PkaGkJLSsYGmnGoBpwtVMS7mKFRFmnljJLCw7dRgOEZmQV5RI3KYPTUZZnqF2qy3MJYY
	rhQxoikQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0Uf-0000LP-4i; Tue, 05 Feb 2019 13:10:29 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0UX-0000Kg-Gi; Tue, 05 Feb 2019 13:10:26 +0000
Received: from localhost (unknown [46.183.103.8])
 by pokefinder.org (Postfix) with ESMTPSA id 7322A2C0509;
 Tue,  5 Feb 2019 14:10:20 +0100 (CET)
Date: Tue, 5 Feb 2019 14:10:19 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: qii wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
Message-ID: <20190205131019.GC12401@kunai>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-2-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1548057574-8061-2-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_051021_702186_804D3991 
X-CRM114-Status: UNSURE (   5.90  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com,
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8849092445711794997=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8849092445711794997==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 03:59:29PM +0800, qii wang wrote:
> Add MT7629 i2c binding to binding file.
>=20
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to for-next, thanks!


--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZizsACgkQFA3kzBSg
KbaOBhAAn5gQBSiH1zVHGMVVEsoQ/iM3aRvgJzIe+Kw2ewEd7DgSUl2MfFHDeKO/
GAnml9dH6/28H68FMncaHXzgCasUBM2Kuigbdbhhrhe3pbojdmH4+bkWCYvg5wU8
yC1S85m8C2T4xuvYm7ZvM4A+ieo98xyki7rRIkAwdDRppGo7AUQav1ZH5GhWj33o
DeFJD9gKK9AYNN/5qOnYIpA8AmpFSRJ7t2cTNZ6Ykyo1nSwHs/DebJ46U10uoOwI
SKReqsDzPj3b938asqh8EPVgcaRZTjQhY/BnL0I8kHL4jvBZLICNNsoJOneRnuMO
mYOjOdI9rps9vv54HddOji5BtLmqEiB8Dj/4bmo7SPvdJyJJoCOCA3DOaS0VPK/N
bS72M3axP3nGa1g8WxlQqv4qGBBf1Xx4tmzpMQ0tQqDPx33Vpmvfr0Ka+ZHqYfte
FF1fiO79hKG48G1itlJE3iXV8AwPlD4YiBBOYxk0gQu/alWDaF4bVKeKI8hFDkFt
w2V3/a+5/EOMWHHzGePqiZdzifw1ugK6cTK4Q2Q6obFfkSayp9kfUjTYal08OM6Z
cyFdtGEuhefi774hr3QfR2oFcBKUQiz1TSk2zn0wE3g16UdOi3XiBEecQCIOPrsb
XLB80WMrseoVQiCUCqDqKqU4zyEeynKHHqXPO5OACATXNpHIiAM=
=LkO+
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--


--===============8849092445711794997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8849092445711794997==--

