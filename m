Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B2C5AC81
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:48:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EA820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ri/wIfjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EA820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KulgxFddK/28XOhj5m8lDRbZQl7V6d3kn7cP3ARh/5o=; b=ri/wIfjwWp+eWIN6GP3mKUHVp
	KxcXC93/HCmRXYHbmUrW+ajoWaho6AhMRRUpVwRpS3L7+jd31OvwOjEPm3lRVJHXR6c7OsGf8XZuC
	R0ouuqKX/90xDZePS6VtW2sJwdKinT4SPt8qOk5kXix4GO9b6ONH2bky5XieJk7eT3s7YLzyuziGL
	CIqLP6wxaNJ83EEEalxRiwwkTXjiRC+5TTbooGdPmtQDOTFIkpeQkbphHTd/ewEmoshEhx8mpH0VR
	HdenwqJlwxCyJ53kFqronKz7xAWBwrrzsK1vgBKzGIcf3NpZKc7IvLvTJMUqZ129TKx1Xvp1B8ILc
	wHyKJ+eoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkZBL-0004G8-HS; Fri, 18 Jan 2019 18:47:55 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkZBI-0004Fl-3o
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 18:47:53 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 213A32074A; Fri, 18 Jan 2019 19:47:50 +0100 (CET)
Received: from localhost (unknown [212.81.177.10])
 by mail.bootlin.com (Postfix) with ESMTPSA id 22CA920BCD;
 Fri, 18 Jan 2019 19:46:58 +0100 (CET)
Date: Fri, 18 Jan 2019 19:46:58 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH 2/2] ARM: dts: sun4i-a10: Add Video Engine and reserved
 memory nodes
Message-ID: <20190118184658.dflpkqvdlg6zox7f@flea>
References: <20190118145730.22227-1-paul.kocialkowski@bootlin.com>
 <20190118145730.22227-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20190118145730.22227-2-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_104752_289555_911B5B2A 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6731644381193915902=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6731644381193915902==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k53ajjhsub4gzoqy"
Content-Disposition: inline


--k53ajjhsub4gzoqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 03:57:30PM +0100, Paul Kocialkowski wrote:
> This adds nodes for the Video Engine and the associated reserved memory
> for the A10. Up to 96 MiB of memory are dedicated to the CMA pool.
>=20
> The VPU can only map the first 256 MiB of DRAM, so the reserved memory
> pool has to be located in that area. Following Allwinner's decision in
> downstream software, the last 96 MiB of the first 256 MiB of RAM are
> reserved for this purpose.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied both, thanks

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--k53ajjhsub4gzoqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEIfIQAKCRDj7w1vZxhR
xa2vAP0T8Y8UwFhPOPemgWXrb3EgpiLE0JQdqXwtuwHk3Sx2TAD/b8ziV3+fFRLn
beosSkkvgx9oUr3JfDnOI+dLFVFgugU=
=EC96
-----END PGP SIGNATURE-----

--k53ajjhsub4gzoqy--


--===============6731644381193915902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6731644381193915902==--

