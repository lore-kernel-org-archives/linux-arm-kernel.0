Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCE7C61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:22:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989A62087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YqlHOK80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989A62087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QooapyLb361hvXiEjRcIXiekjC9L+lVgEwom+zicc/U=; b=YqlHOK80gGoekqmCXyJyXSGU5
	DH43npApv+XJp/tHjZ+IWgh5G3LLbPYG7I8QLd17lrpccULmzXq4QBTHdUqBJDGwCRLTC5vB04aNK
	UHdlvCbZZpRbx83h9FwcDu+RpwyAFFB6TZ5lKmGxDktksO0RE4P44IVH/qtc3l7V55nEwedF6Lg+x
	cXYVscL9VGvKFR5ygDrWnCQZxZPYfsAt3TUCvg2SYzEDvQ4aAm20Q19tPKLyIDTkBWMVOg+L7NfnF
	HKB4U7HsYzJ43XZqLabXptgO9S7ZeUAIEvaIW2wIiocee8BC6JcL1lJAjBjzwzmKMzAbsLjeH+gpe
	xPeZUBBmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkz0Y-0003Th-0t; Sat, 19 Jan 2019 22:22:30 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkz0U-0003TP-Sn
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 22:22:29 +0000
Received: from localhost (p54B33180.dip0.t-ipconnect.de [84.179.49.128])
 by pokefinder.org (Postfix) with ESMTPSA id EE0A02D1FE5;
 Sat, 19 Jan 2019 23:22:21 +0100 (CET)
Date: Sat, 19 Jan 2019 23:22:20 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of
 SDHI3
Message-ID: <20190119222220.GA7266@kunai>
References: <20190118122536.20000-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
In-Reply-To: <20190118122536.20000-1-horms+renesas@verge.net.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_142227_080654_265C9DA5 
X-CRM114-Status: UNSURE (   9.36  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3280701516197353875=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3280701516197353875==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 01:25:36PM +0100, Simon Horman wrote:
> Enable HS400 of SDHI3 using the corresponding DT property.
> No further changes are required.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

We might need to find an explanation for the performance numbers,
nontheless this patch is correct.


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxDoxgACgkQFA3kzBSg
KbbFWA//T0Puj8hckN5w+zqBJH5lX5Dx4jiNvPxEghTOPIVnV8KWgVujeippdr+e
SurEU8ZotvQjN1+JoK2UkVe8Wh8kR4sRaq6LOOf2uQjeardDkChaliW7KIMDnTJe
89oboU6sc4UZ3zIM1EZ4kJZxJI2bmuSle0qNPIE0RC6ccsmTD/QHtIhi/l2jWuK8
U3s0X1QZbCzy6p8HxJtyk0/VSxiSKW1hzvQbafLeIoSFovn1wXyXmIPg9x4+G+G0
L1nD2GKwpsd96Pt1r28o1hrIhIwGF4uIlkoifwLkyZlZdDMEkx/cxAhwj7OSxcoX
EFfdfHNiLAq/TJyzQP3svI1qNn/5IzF/HuuzRLfHIa4tNxF2L+VHQkQqfMpreRoI
NDFIpbAXR2FcCZ5rW7LG59cBEBOda99UjO3v15MPR5+FBJpIZ1DmJtLJi+C+iKZj
QvsNkTUdsHdo4V/G0E2HyTYKOVSpg4w5lmQHRRKRdHr4ffnfnNt7eDa2x5UuaAdH
mKsNG9EUvF5MsP5n9ZgPQQUhKVKSMQZU3X1jpfjY/DflgqVeTEuqd1AwkQSL6Wan
ohNF3DSM69XP9MxFZidPiQ71ftwQoTFDfnHKmYtUBp8yDeQ53cJO/BTh7HskB9yE
xf7GM6AJqHXHz/KJO84OrEKYmJ0H3rwDn7b2UgqiHaX41BkH9/k=
=nYFY
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--


--===============3280701516197353875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3280701516197353875==--

