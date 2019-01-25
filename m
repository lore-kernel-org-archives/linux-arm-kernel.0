Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833C3C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:53:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503AA218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OTCRZagd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503AA218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p1WFbAU+zW4dC3SERDgCMxTxJxb4BGg3YckdwSvpR+Y=; b=OTCRZagdR3TIuGJYw8DWkreXS
	LawFh7Wv/LG/ZBP5UcnjZIW1Vx2OgmSGn2UJ2Yhyo7EqtmmKKUrU0JsgqQn+U9s0zfQOhOVKIlr0d
	GBQgq2J2UQnw9dxJAo0AhLkjcSYweVOvwmPZo3Lm3B364YL5r4UNsttUkOA/lwZ9wHx4YMVtxWvMZ
	EVBfWf90YUgAxAeToVfPx+2UgZDbAKV4u2U3r0vajcPmrOTDZ13EsEYev/8XmkYkv/GyiD9Sye1qw
	Gp7o38hCspWgTs4zwn0yn0eDNJKHBpSNJdrXu3So4ShUWRa5TUbJosmDsBZT63x97dEf4JJurnNvP
	PrlpnIX6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn3mt-0005VN-Ft; Fri, 25 Jan 2019 15:52:59 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn3mo-0005So-AY
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 15:52:56 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E7F69207B6; Fri, 25 Jan 2019 16:52:52 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id BB08E207AD;
 Fri, 25 Jan 2019 16:52:52 +0100 (CET)
Date: Fri, 25 Jan 2019 16:52:53 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v6 15/22] dt-bindings: sun6i-dsi: Add A64 DPHY compatible
 (w/ A31 fallback)
Message-ID: <20190125155253.v33vk3rfpdgv6537@flea>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-16-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20190124195900.22620-16-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_075254_520839_7AA378A7 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1291214536780631565=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1291214536780631565==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ykfgu7c2rq7ykthf"
Content-Disposition: inline


--ykfgu7c2rq7ykthf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 01:28:53AM +0530, Jagan Teki wrote:
> The MIPI DSI PHY controller on Allwinner A64 is similar
> on the one on A31.
>=20
> Add A64 compatible and append A31 compatible as fallback.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.tx=
t b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> index dbda2e567760..9c553637c72b 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> @@ -40,6 +40,7 @@ D-PHY
>  Required properties:
>    - compatible: value must be one of:
>      * allwinner,sun6i-a31-mipi-dphy
> +    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dphy"

Same remark than patch 14

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ykfgu7c2rq7ykthf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEsw1QAKCRDj7w1vZxhR
xTi8AQDz3tkCaFBlGhOZG03SKppIfmHwuOSJbl3fNs5PW6BAKwEAuk0HYmnWsXo8
fkTCcHkKV1uTbLP+Woq7p1BlVjuvMg4=
=DoXw
-----END PGP SIGNATURE-----

--ykfgu7c2rq7ykthf--


--===============1291214536780631565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1291214536780631565==--

