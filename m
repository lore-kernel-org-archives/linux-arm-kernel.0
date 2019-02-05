Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BE9C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:11:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C46C207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bUoJSnLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C46C207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oda51eS26A1f2nBjNGY2nqhO1q7i5qEcwckGTIZ5xGM=; b=bUoJSnLOoKazmWFv2fNp4Vm4O
	aKRymMx+kD3ReJy25JCHAxP+vH+H2tW78DZ7U58s43Gb5SijZL7Vmd6mlbFC/HLbNSpFFNtC9epgb
	M1yiZVAeiV72g3a2o4mKSZ/rteb/EmcB850OZYLfqJJI+onFwxDUypjY7iM9h/p/uXNj/mef4IL4J
	ydHnOU3LKGsWE9UhezS6a6aOIjd1JYSf/jSpHgl9WVBLiQBIUwhzvhdsizzXrSXZkI8X837c2h7vX
	WgXNH4R4dSAsfpIRIG6ru6QcvLxXJLuQIhaksqjyeU8uWvnZ8X4q24aQ37wtC2KFa4mxeIxKIFPiD
	EPc0lSz1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0VZ-0000fy-VY; Tue, 05 Feb 2019 13:11:25 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0VV-0000fd-L4; Tue, 05 Feb 2019 13:11:24 +0000
Received: from localhost (unknown [46.183.103.8])
 by pokefinder.org (Postfix) with ESMTPSA id F07822C0509;
 Tue,  5 Feb 2019 14:11:20 +0100 (CET)
Date: Tue, 5 Feb 2019 14:11:20 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: qii wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v3 2/6] i2c: mediatek: speeds is replaced by macros
 definitions
Message-ID: <20190205131120.GD12401@kunai>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-3-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1548057574-8061-3-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_051122_842623_632E35D5 
X-CRM114-Status: UNSURE (   6.04  )
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
Content-Type: multipart/mixed; boundary="===============5247066589622250579=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5247066589622250579==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 03:59:30PM +0800, qii wang wrote:
> Different speeds have been defined by macros,
> so we use macros definitions.
>=20
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

Applied to for-next, thanks!


--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZi3gACgkQFA3kzBSg
KbbeYg//ZD5cth5gtax9A5yxAmHxRFYNjzjqpu6PFhKbUl50V+JFr/m0p4olHjJ7
0JMgRqdbfdsU+UWiqCw41N4T97aL/yQZ0GZCFEBfCS1vz30pzqzx9+inufmfjF8z
dAZV/SB9wRcAjfNaAA/k094Mkrkjo3mBgCMnmKDt7BtVUlFW3GeimXBfpOCiBnY8
Ldzd96pSeHhDTgnyeTmi/OEcF278UVg6MmJ+NPlycVCBjhMOYACMcXgYkMxWBpSh
uEnsyuv2+oH3+IvLBJfYQRUL6Su1g3LVIY3o/HGE+2OYX/YAfnLYI8RTzVcGOxuE
HwEKqGMcpn0O6zZmo56BtSBzg2DdQ4pwx7OMLCg/5v7Npqwf56fbjDsoIrYAlM3K
jEcCm95V96C43l0Bad8cem2gYvZclvISEoZccqg4xNe0dAPeYmj4mkqpjNTTQE72
NLYj+dxVjNowwgJDQNqkjFg65opQo38eCtoAACwR2wmiJM0D9Ixa2FkoyGODynwY
LPFlkUHu/UrM42P2gJRSbjx687lyK5baIRDIeVj/p5dyutIES5/nTpqMUqyWqbmX
0LHmxyVb7yecF8SQrlEYswn1Ge6K3hWaGBozdL+UxGhXAoVoo+OmYs+RYYFra5vN
wvWQ2GU1mumGMLSaJHAF/+j5VDkpRpvx3hEu2Ws46rfjRnkprwo=
=ch0i
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--


--===============5247066589622250579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5247066589622250579==--

