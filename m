Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93947C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:16:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C964206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gGn10lEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C964206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6wfrUWWw49eDnNmeYqtmfdQ59uyernXTZCUtSCC2pjA=; b=gGn10lEEw4oYfPdX4C2G+sh3T
	yaVj6Pyoe+N0VGiBAnZl5dqm0xGOB3e/5fNvLLmUBRjCjEMIAoQ2XhgoZKgj7KYUnEcL/LPvNmeqY
	57VGOyxYo6f+eEQbS8XtgK+Fw+kIlabqcVT0lewISJ8RnkLdE4p37LNAc45p3mFDdP+s8P27JIuTz
	UEMH58ixO+bNuQz1e/OOiekB2n5ZCqZwTMdsTitM4kOSsWtpd8Mhp21uaPCJYFi26drfAcaIJPIuA
	8wFxTL/iAYTK+T/yynOBh6rPdwV7xhvHyeKFP8552MLo0HTCayw6EAtlrwwX2RnaQ0oS9oYgKYa5Y
	gdqsVffJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0aj-0002ur-Jb; Tue, 05 Feb 2019 13:16:45 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0ag-0002uT-P9; Tue, 05 Feb 2019 13:16:44 +0000
Received: from localhost (unknown [46.183.103.8])
 by pokefinder.org (Postfix) with ESMTPSA id CD58C2C0509;
 Tue,  5 Feb 2019 14:16:41 +0100 (CET)
Date: Tue, 5 Feb 2019 14:16:41 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: qii wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190205131641.GF12401@kunai>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_051642_958209_FCCB7684 
X-CRM114-Status: UNSURE (   7.08  )
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
Content-Type: multipart/mixed; boundary="===============8531345156626643504=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8531345156626643504==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +  - mediatek,share-i3c: i3c controller can share i2c function.

I am not happy with this binding. There must be a better way of using
the I3C controller in I2C mode. I think it would be easier to tell if we
had an I3C driver to see how it implements I2C fallback there. Is the
I3C driver on the way?


--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZjLUACgkQFA3kzBSg
KbZ3kw/+MPQnVnSHx074f3k4k9AbHCPpsJjFvArfPHwjRjIzGcf8jm/qxMrSppV5
Jjhbjy4VBTdXWt27pyjEhZyc/cypfl+PgCypWi51nvXor7AVu+Cn0oKPeSvQM6QF
6LnUyxnQ+g2gLPM0iZR4QyiY34YVGY3XL6hYcsNFYsX5ezVgFmlH1Rc7m2K1b5KT
CdKaULa8YvRaBfEdCJr3vxszVr8dJXocollbbbWFxTM7O6mIeSKhJ2nG8PiZVhYc
gA6wKFyS+RQrIwRZSAUXvuP6haDpWMzzUCJ6WvHiByGwnuXKq1lk9d4IBe7qjqx4
M8o0gX+uyCV28q6EeUn4s7hWMVp8YL/bjyaVlwmtphNypRRBs9iqeIhSsJ1LdvWD
8m5eTFDdRE2cWfbAM4XfKQ2KPOYVQlVsCo5NFFN28xzfGzFrp1ilIaw1rbM+8nYH
pf942Oxyk2cjoxJJv/O2xoJckESWcNfX7snlYiyFJcGhSQITn/FcFQQSc2uKNX8Q
1hByqi4GD2B2U9lwSWGaiu5yuz3kgwYpcqc0hED7dkOS9dk7vDIGuV88dZS5jo09
rIcU1UwVtCSWLtoIMLVc+PYZEsjtmmlx7293W3BWZjBAoLVUQpPVrdUAl1vM93Lp
NQi1oxly7GIeo2AvFM83rdiI1bcmndZv5yZwgCpbPl0Bf5XgdHY=
=/6Dp
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--


--===============8531345156626643504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8531345156626643504==--

