Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F43CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:45:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F85621917
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gwc0VrjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F85621917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NZeZ6sBbZ77V9APHLgma3A5IoTd0NeWpi8H6A+njJB4=; b=gwc0VrjNFE4CYwQd8yBHnEdfT
	hb7yYXN3XTiPtqBf/fzA41LyfgM75eTHPNaFgFjpLq8MOUNFoq5c/9ItEAl4xpnmi9t0fxaoIMtUT
	iMzrNUM8yfmfooi0QheVWh+k7z1wx3C0OpiFhJ2G8kveZmEXFTgGHw5mv1y0u/jX90Etm02/pVs6K
	CUqzWMyaPDNKLGYybZu0TTrpz4X2K4qa6gV6i3kiizH+YZXMryHQY91QlPXV8MyrQnk8In+69m/Eb
	qDe+4uf6RZo4RHn8Tvhp87ct+m+lc9yNhG7bGDK1x2x3qj+T1e6/iu57f1dCbrrpUTlcsLLFLt/E7
	3UoVAzDVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs0qX-0007uN-Bs; Fri, 08 Feb 2019 07:45:13 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs0qT-00073u-Je
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 07:45:11 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id ADD6F60008;
 Fri,  8 Feb 2019 07:44:58 +0000 (UTC)
Date: Fri, 8 Feb 2019 08:44:58 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Yizhuo <yzhai003@ucr.edu>
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
Message-ID: <20190208074458.edgvwfgytlio62yn@flea>
References: <20190207174623.16712-1-yzhai003@ucr.edu>
MIME-Version: 1.0
In-Reply-To: <20190207174623.16712-1-yzhai003@ucr.edu>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_234509_800458_FAA21094 
X-CRM114-Status: UNSURE (   8.76  )
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
Cc: csong@cs.ucr.edu, Alexandre Torgue <alexandre.torgue@st.com>,
 netdev@vger.kernel.org, zhiyunq@cs.ucr.edu, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5521231981004968236=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5521231981004968236==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ktram64yqnag7qmy"
Content-Disposition: inline


--ktram64yqnag7qmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 09:46:23AM -0800, Yizhuo wrote:
> In function sun8i_dwmac_set_syscon(), local variable "val" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used directly in the if statement, which
> is potentially unsafe.
>=20
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ktram64yqnag7qmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXF0zegAKCRDj7w1vZxhR
xZAIAP9XLy4fhsazFjOCIM5YOqI9osHgxZAwOYd7hAoxUrBM3gD+J7BlsTyqYo6K
uvUY4PmJLZN6G5k/6Fi7qkvbqMIHEQs=
=I1dd
-----END PGP SIGNATURE-----

--ktram64yqnag7qmy--


--===============5521231981004968236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5521231981004968236==--

