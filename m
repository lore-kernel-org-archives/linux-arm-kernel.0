Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D40C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:16:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D25821721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UAdcX56p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D25821721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=hSqyx8PkebCp4oPY7E5gsboqMec4ToNuleh9vaEDb0w=; b=UAd
	cX56p297CINceUywK2nuBppap7txVH/NCB1x8EN5R7Ed9E2yBzHa4NOhWRGU3zNvtiYyV8azyPupK
	ytnwQOwAcDAZLT/YrqQc2PifPwU1hwsZJ/UugUYVS3Vh3nWnIFVNfC3J7R5NOLPZUSE1N21204X5/
	nN0ZvFQ00HHpu3XAcOY2ybPVvYk4k+nAIsYnrH/+Ex6Ot2grHHPlTjdUJpLw0tUVW9M0UqPieonOU
	tT3qgbGkNuPZ98jXYRQRmmCWI1omZnDwsBSL2WuWIluc5Kr82R/y5dz3y4hidkFS8b+mDDVPoyf/R
	OLksgsYo4nTJcJ3vC/VUJie7RsO++bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnwTd-0006Mr-2L; Mon, 28 Jan 2019 02:16:45 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnwTZ-0006MW-UF
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 02:16:43 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id BC95F5FCDF; Mon, 28 Jan 2019 10:16:35 +0800 (CST)
Date: Mon, 28 Jan 2019 10:16:35 +0800
From: Chen-Yu Tsai <wens@csie.org>
To: arm@kernel.org
Subject: [GIT PULL 0/3] Allwinner Changes - Round 1
Message-ID: <20190128021635.GA30661@wens.csie.org>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_181642_109452_724C532D 
X-CRM114-Status: UNSURE (   5.83  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2450200475025969516=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2450200475025969516==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd, Olof,

This is the first round of pull requests, including fixes for 5.0,
and DT / DT64 changes for 5.1. We're holding off on the H3/H5 changes
that we normally send, as there might be some changes to them. So
expect a second round of pull requests.


Regards
ChenYu

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nN1m/hhnkhOWjtHOJpUIZwPJDAFAlxOZgEACgkQOJpUIZwP
JDDusQ//bFIlMoby0szme6ZymabgpTolm9Ha79J4UMsXd0HQdHxeu6vGr8UfJ3Iw
XJFGFO/pFov01fZYRIsChlIc7AYw1KZ53c33+GXch0ePkh5R28Qjr2MqcHv9/ear
RdBwstgvKmVoHwm4XsBmJsMF/SbEGER+qO5/APdBz8fYwISlea2SPLZ4GhHYOI1s
gJHGMhqZhwVBCJZ5aumtiL9K9i6KE+AW/NrHSebtlIhsNgcCpzr8Z5J/6VBAU88b
ne+r6uhgYJFbuNwqbLh9vojK33OEPbDjrT9JiXVhuZDX0tnlqSSybLGSIwoZLbSW
HNkyYd2eLdO/2S40oXwlVeA9PndlhUuS28RKcWY+UUJ1HiOKs0gRGdu5xecDrctG
r49RD8FmqO4ndSfxsC4QRD5WDW3ybKSz1ntQ/rxbADaMybNyQo+d12stoH5OOfsU
KPCbSD25fxP1HXZ2tYTXzlvuKG4LUih2xBgxXAxrEH8B7j96m7KKVrpemsueS2TM
nbG2uKKd+Vpw0aoYOiGD/WNH+YumYciNad8bY8PNeC8zdhYvYfGTZeqA9wzVJAGL
KtAB1+3RmQ2SKdQufrwvBWdCJOjWsk4a1NGVAuzH6VJiHxUVNrzsJHwjreCVOEZr
nyLqtylEsiuLa0h097ED/y4EwUWpE1dU1bcqVHTK7vLLCelq/6o=
=wxHp
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--


--===============2450200475025969516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2450200475025969516==--

