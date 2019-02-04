Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C1CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:01:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9CB217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tt/h9pB3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WTdmYaDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9CB217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oZmxseKGk6mis61Z7tdbODPG4z/GyyP7VYUJBIuvn2M=; b=tt/h9pB30dieiXCYGym6XhcYv
	Gw0LKgsqL8W1mnrRNQqkEgHst1+8AAPlDYd9QnsRqK/chgKir9ZQrnDgDONscKMzRh/1Hqp5iSd7e
	M8H9groCNyu9fNrB1s2OvwBVfodC1phYLSV5xwhsGu+4hMz5P7WWabJuTjkBeuiv9U66yrhWkcASb
	fasLo6DCt9bqVsC7I/yrMkVBzYrvakEShCtUgJ70h+FFsOFAh+a7322VfmnrUa7W1aZeVPZQq1Lwx
	S7tgjHBWF/kXXq+6yDgowdUsthMQcC9o6U3QLCy/VPt70XN/idKJpFa0gjRZVBaCggkxwQHSR8RNR
	sD7Wh+sTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqZCU-0004qe-Nt; Mon, 04 Feb 2019 08:01:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqZCS-0004qQ-DY
 for linux-arm-kernel@bombadil.infradead.org; Mon, 04 Feb 2019 08:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KcnJYMVmcnF+wgN7xx1jd6S5nixDGPw1KtExqvC41pg=; b=WTdmYaDnGFgBXcrvuruoTOuFJ
 LBBhjUyIt1O9eA8306hDBzwvdEWrYI+j9Wxljd7RMll/GHNNGkoZEQgUs8Q3AO7eSotIXvUhtbMCj
 D6ro0ke7rJ8BaqQgXBs/LHOxKuvTIxLAEHyzudGeaAGtOEMvPo5k5un6pnHGp+A0xU6tNZhUU94lI
 E0ZFRr+lIOSIAwBiK6C57yPGo4qJD6JChYhw3yIwMrNfro1z+b9+qb2pl6+aLoedRJk/Dd7dvYmft
 /PcBx14BiPqGTpFxwd83jve/v8XI+4qiAWWNimZ7As6ulSqAHAXwp6nqLRDEuQZ5vr5Tt02mKO/m/
 klo8XlRMA==;
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqZCM-0001W8-Es
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 08:01:49 +0000
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 68C7F40013;
 Mon,  4 Feb 2019 08:01:13 +0000 (UTC)
Date: Mon, 4 Feb 2019 09:01:13 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/3] media: sun6i: Fix CSI regmap's max_register
Message-ID: <20190204080113.77qxun2rhx6qnnzi@flea>
References: <20190203160358.21050-1-wens@csie.org>
 <20190203160358.21050-2-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190203160358.21050-2-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_080146_513701_55103334 
X-CRM114-Status: GOOD (  15.23  )
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
Cc: Yong Deng <yong.deng@magewell.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============3624497818171584823=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3624497818171584823==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ou2ebljt6hd6aqku"
Content-Disposition: inline


--ou2ebljt6hd6aqku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 12:03:56AM +0800, Chen-Yu Tsai wrote:
> max_register is currently set to 0x1000. This is beyond the mapped
> address range of the hardware, so attempts to dump the regmap from
> debugfs would trigger a kernel exception.
>=20
> Furthermore, the useful registers only occupy a small section at the
> beginning of the full range. Change the value to 0x9c, the last known
> register on the V3s and H3.
>=20
> On the A31, the register range is extended to support additional
> capture channels. Since this is not yet supported, ignore it for now.
>=20
> Fixes: 5cc7522d8965 ("media: sun6i: Add support for Allwinner CSI V3s")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ou2ebljt6hd6aqku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFfxNwAKCRDj7w1vZxhR
xTHSAQCkh2SviUW9URUVI4sWGCc2D1O80N9rKqkileBHg8OStgEAlQWQdQ3QI6TY
k5ICq4fv6va4eBEzdV9qTsp8C/zuigQ=
=NRUp
-----END PGP SIGNATURE-----

--ou2ebljt6hd6aqku--


--===============3624497818171584823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3624497818171584823==--

