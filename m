Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC3EC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:09:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5662081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ya9797yY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pBtpXAuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5662081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bCv38oA3ueSCLJ3FeYJAnsA2xmvitp+Ie2dyIhwGLrA=; b=Ya9797yYgaUgG/GK+zIJPrIBJ
	UfHFfTlEHx0dTiWBXPAijaLZOacqnLptwK5+4U0RuPycrQLO4QGke/FkCIjvkHaAJW+hqyhNbNzmU
	sZ5W9N77awohQMRkUplN8cx29pT7mSSONDFpxBZxsK0ddT35SpcofFe5Xg0gZendsnAR8vK2p8HeI
	A+WeAYKGrjzv/1HV/xfIvtq8I2TjBJQbCbJVjOl9OdVv5cI93nWZz6Mk9WOdRVG0In4q78yD6h1c8
	4JC2YVFMx/RGbu6D2cy/S6sBpuipb9w8q1PK80Q0blpycWoyGAEBgm7rjV7rDS92uKmtGV+8al9Ov
	baUQf+SOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiic-0003eK-VA; Tue, 11 Dec 2018 14:09:02 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiiW-0003R9-D3
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:09:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k9+lkKG8yN0yLdK+Cr7Ps0U5iepdHWVE+KWdMwMCRWM=; b=pBtpXAuON8rh9S+HsN0vzqU6T
 nUw3a+uzWA7dkwdBo5MhLrxuwV+CxrFJffmGYytwsEj3qZf/KQeLMqqV0hHOloPVdJqdFXaVtLOGC
 NWxLLmR6Uz4dXT9mZmwKfUtD/PaN8AWtJzoCAXuJBbkcIbX9+DIIP2qLLzroqyTGpoGk8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gWiiH-00015y-RI; Tue, 11 Dec 2018 14:08:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 844F5112540E; Tue, 11 Dec 2018 14:08:41 +0000 (GMT)
Date: Tue, 11 Dec 2018 14:08:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 0/5] add PM functionality for act8945a PMIC
Message-ID: <20181211140841.GE6686@sirena.org.uk>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_060857_465918_694C5814 
X-CRM114-Status: UNSURE (   7.79  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6227886848967637925=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6227886848967637925==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 11:57:06AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> This series implements PM functionality for act8945a PMIC and use that su=
pport
> on SAMA5D2 Xplained board.

This doesn't apply against current code, please check and resend.

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPxOgACgkQJNaLcl1U
h9AZaggAg505D8Xn+NVX6TOio7dzQKgtGEcOGq1ELTca1YDIqxRkcrZXN20OkbOu
FGbA3VzRfqQgzyQN/giexD32gQE3IOsN6/IX46z9mgJKVnWLyPf7DXp1Pd+mjdzM
aRQSgTQF6+/2iZfqLQU4kXZKMcgwwfURZCWqQgKlZfmtOV7ZYdMYBcjhskej1Avg
LWytAL54VzJtKhgBGFXHQZb45D3cKczTHfU87NJyvSl+75/BbZ57kesTfkvapZgb
oiYtmMaXeHJeDneHiQYy66G9MrAN9R1H/9donQaUI1R6i+hvchHF0jcbT62rVH43
o8gUvui0EsTbuO9AcdPlaUFcDXcNyQ==
=J34S
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--


--===============6227886848967637925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6227886848967637925==--

