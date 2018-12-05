Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B53DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50ED020892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M3u4jej7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50ED020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0guiJmHY0J5wrsZzsk4E/woUDxlXXSRVCrtHPpEend0=; b=M3u4jej7pt8YghoygL5e63HBH
	V3adtM3jlDTBwF+k/xyoJAncH4I/R9mxDpiWFJAhC7fS0YzA59eOKzPXvkpQFDm+hrki+Xs3mlLGL
	Iij2gUJWBntU6cUm0vrPSNx7C0gu7DtKRKKog58u/kqaxdkjIeJ1OiDj2kJNPCulIWxY3265LqR/V
	tvYJ86T3HBQTuz4E4qqTxYEy4P9VXBVzrkZJ5GuZlyuhbzDw8r0IIpQdtN4e/D6H7nQM0Q8Qu8uCN
	bfMuy7GdwM0RO6MinIDXvOFqoL4i2IcxIODcHXpB5+wJZIwDMExw3DvxhrloWcyb5dp2+HFhhTGHM
	pXGAANIOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZH7-0000EL-JB; Wed, 05 Dec 2018 15:39:45 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZH4-0000DN-JU
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:39:44 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 71F6420C36; Wed,  5 Dec 2018 16:39:31 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id E1BC920CE8;
 Wed,  5 Dec 2018 16:39:04 +0100 (CET)
Date: Wed, 5 Dec 2018 16:39:05 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v4 05/22] drm/sun4i: frontend: Determine input format
 based on colorspace
Message-ID: <20181205153905.gtsgto45omkocxrz@flea>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
 <20181205083703.21488-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181205083703.21488-6-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_073942_781052_ACC086D4 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 linux-sunxi@googlegroups.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4852242874565462254=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4852242874565462254==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nuvzpqcwpzwepf3q"
Content-Disposition: inline


--nuvzpqcwpzwepf3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 09:36:46AM +0100, Paul Kocialkowski wrote:
> Since all the RGB input formats have the same value for the DATA_FMT
> field of the INPUT_FMT register, we can group them when the format is
> known to be RGB. Here, we assume that a non-YUV format is RGB, because
> the hardware does not support any other colorspace than RGB and YUV.
>=20
> Use the DRM format info structure to check whether the format uses a
> YUV colorspace.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nuvzpqcwpzwepf3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAfxGAAKCRDj7w1vZxhR
xdyTAP9S9aXImznZ2+1K97zxpbBmZsSZW49FJhUMY7OqZMmEEQD+OOEh+isTecuq
jgXyGxCSgQzezqAAYBzmFNpDWXjz9Ag=
=2Kw6
-----END PGP SIGNATURE-----

--nuvzpqcwpzwepf3q--


--===============4852242874565462254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4852242874565462254==--

