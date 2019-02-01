Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593ABC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:50:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AEE521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m9004ibS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEE521872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0yKYJOU+7P5lKQQw5MaA5fskLTRXdIKDKKLmryYp85A=; b=m9004ibSNjNTfxi9wZGA7qRT6
	a71TALvjwpVnmUqe1/MfcpTDXTIzBLrHSY2bOH11Ekpz8DOOsPXU8yZBk1J5D5ycf+3Rent4D4wcK
	CpWjJdj0gkohLnPTP/vhed2gOEuivRftfGglTcsJPMSr8k1OWhAWf/zr4x9pv83aBouNEJx7QjGfG
	/1SEKRH4YBSxyugjaMk6WPndCOq5Bk9BEv31xQHcPFCQkWEM7DAHB2h/Re4BuR/Ua2ZMDcxU66vFW
	yB/tCIfdgIrGaQ1I2CUO5klF5FK4cwrla/sNVAqxN5QCz5gh9pMqOxekYSuCwyXZqLkzgf7g7Z3S/
	QpxxCpSLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpYHK-0001q0-Aw; Fri, 01 Feb 2019 12:50:42 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpYHE-0001mK-13
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:50:40 +0000
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 46B5EFF809;
 Fri,  1 Feb 2019 12:50:23 +0000 (UTC)
Date: Fri, 1 Feb 2019 13:50:22 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2 2/2] arm64: defconfig: Enable SUN6I Camera sensor
 interface
Message-ID: <20190201125022.mw5yhbahq6afsal7@flea>
References: <20190131152035.7138-1-jagan@amarulasolutions.com>
 <20190131152035.7138-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20190131152035.7138-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_045036_333837_8E782F8F 
X-CRM114-Status: UNSURE (   8.83  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4081010073505525007=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4081010073505525007==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oqbxszzbap7bcgns"
Content-Disposition: inline


--oqbxszzbap7bcgns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 08:50:35PM +0530, Jagan Teki wrote:
> Enable Camera sensor interface for Allwinner SUN6I SoC's.
>=20
> This support enable V4L2 platform drivers static and
> VIDEO_SUN6I_CSI as module.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied both, thanks
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--oqbxszzbap7bcgns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFRAjgAKCRDj7w1vZxhR
xZp0APMFqFQfWjRqJ5G3MIO8D19D+wYzghofLq0fiXxXeXf8AP9HuN2jQF/XELbC
tn081/UB9lUC5K8Sd8bj6AwL4HaYBQ==
=yV1B
-----END PGP SIGNATURE-----

--oqbxszzbap7bcgns--


--===============4081010073505525007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4081010073505525007==--

