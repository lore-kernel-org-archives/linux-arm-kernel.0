Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FD8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:19:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6797E20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HOrtTsRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6797E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4Y1+EKbvTXeC1y8EMMAtyuPtOxheoYPG8mw3HaVnPEQ=; b=HOrtTsREF/1nsQ/OAnEHbOzlx
	OcbdL14ogBcU5i85hm2o6eOn9onhWBTDHRyU32YU+k1M5EsgYe5OUohwsfUy+iKjJyacrGFHj9muR
	OFJUu4Dk1MPmdjXNEATC7gjxmxoiEEbeCn2mnTu6Dn+NwTS1Wljw2auydfWaEQtjyo/2b9yM9QtQW
	yWUFHkIV83kg43gChmrflcaHE6/s/G52K41TtJLipb2JU3pjxfPqTsYSruPHxg+b0GI8Ii+XfgW+f
	HkIPrj7u12pXFNVn5waPTqMq3lGfHRags59EG7GX4aJhEYfvN1KRsdopvS+GXH02EtEBrANSZpdCc
	KKyyw9EYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjqib-0005pM-2w; Wed, 16 Jan 2019 19:19:17 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjqhY-00051F-Ec
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 19:18:19 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2B5D1209EF; Wed, 16 Jan 2019 20:18:07 +0100 (CET)
Received: from localhost (unknown [212.81.177.10])
 by mail.bootlin.com (Postfix) with ESMTPSA id C9C10206A6;
 Wed, 16 Jan 2019 20:17:56 +0100 (CET)
Date: Wed, 16 Jan 2019 09:59:13 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [PATCH 4/4] drm/sun4i: backend: add missing of_node_puts
Message-ID: <20190116085913.j2ju3mj75x5bqppm@flea>
References: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
 <1547369264-24831-5-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
In-Reply-To: <1547369264-24831-5-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_111813_520300_FC08EA44 
X-CRM114-Status: GOOD (  14.62  )
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1494106364741273959=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1494106364741273959==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dunppgcxmo5qgg5l"
Content-Disposition: inline


--dunppgcxmo5qgg5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 13, 2019 at 09:47:44AM +0100, Julia Lawall wrote:
> The device node iterators perform an of_node_get on each
> iteration, so a jump out of the loop requires an of_node_put.
>=20
> Remote and port also have augmented reference counts, so drop them
> on each iteration and at the end of the function, respectively.
> Remote is only used for the address it contains, not for the
> contents of that address, so the reference count can be dropped
> immediately.
>=20
> The semantic patch that fixes the first part of this problem is
> as follows (http://coccinelle.lip6.fr):
>=20
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> iterator name for_each_child_of_node;
> @@
>=20
>  for_each_available_child_of_node(root, child) {
>    ... when !=3D of_node_put(child)
>        when !=3D e =3D child
> +  of_node_put(child);
> ?  break;
>    ...
> }
> ... when !=3D child
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dunppgcxmo5qgg5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXD7yYQAKCRDj7w1vZxhR
xYlyAQDwvaT1Fd85U90xXfnNEaXT0VONYRQBfzXkZ5deO8x8igEA+PXurQWESJMf
cVGPanmyDaAWOtjRbYLKr4Tkn8cthAk=
=7q2T
-----END PGP SIGNATURE-----

--dunppgcxmo5qgg5l--


--===============1494106364741273959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1494106364741273959==--

