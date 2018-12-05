Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F462C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:53:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210E0208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fsb/38vL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210E0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qWpalyY2pS+u6gst1WDbPwLpkfFupL8lAnfTt3Fdv2g=; b=Fsb/38vLwQaPijP6ZaD/gcjH/
	TjnU2AsQuGSWggxQHo7s72B9eWqTVRUJygvZiojE5YVquipBFtIen22/d7Vz9SUUryXqgOmWE96vc
	DyQlGO2M2NnwsGARreQbq9bRCXpB3O1wputzC21EMbTP/ZwSKU9CNi00wVkdp7fU/EE0evQQTdPyJ
	eHtP03QbKORpdfVdO9SszTGJZG6QaAZ9LO7fKqK9Ls2hWQGXqKPkD6VQB/0V266Hh1gn6+NAlEZP8
	qDobAqRQbOwtTICMa213lvHQscNUAW7QQXO4FFORPCqLOlFU2REuczOem8FoUk7l49iEZMCdl4hM3
	vPv++dv7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUeAc-0000rg-D0; Wed, 05 Dec 2018 20:53:22 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUeAY-0000oj-My
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 20:53:20 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 1E16A263BF7
Received: by earth.universe (Postfix, from userid 1000)
 id A5E8A3C08D6; Wed,  5 Dec 2018 21:53:03 +0100 (CET)
Date: Wed, 5 Dec 2018 21:53:03 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 11/17] dt-bindings: olpc_battery: Add XO-1.5 battery
Message-ID: <20181205205303.3zx3ap7jfkah7ruw@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-12-lkundrak@v3.sk>
MIME-Version: 1.0
In-Reply-To: <20181116162403.49854-12-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_125318_881415_5BD23734 
X-CRM114-Status: GOOD (  15.88  )
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
 devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>,
 James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org,
 Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5701296604291439412=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5701296604291439412==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rmx6qoxsqzvhfohm"
Content-Disposition: inline


--rmx6qoxsqzvhfohm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 05:23:57PM +0100, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes since v1:
> - Collected Reviewed-by and Acked-by tags
>=20
>  Documentation/devicetree/bindings/power/supply/olpc_battery.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/olpc_battery.=
txt b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> index c8901b3992d9..8d87d6b35a98 100644
> --- a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> @@ -2,4 +2,4 @@ OLPC battery
>  ~~~~~~~~~~~~
> =20
>  Required properties:
> -  - compatible : "olpc,xo1-battery"
> +  - compatible : "olpc,xo1-battery" or "olpc,xo1.5-battery"
> --=20
> 2.19.1
>=20

--rmx6qoxsqzvhfohm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIOqwACgkQ2O7X88g7
+ppsMhAAqjiRTWfR/LVjMsfkcZ5JT7Tcsebbmp6IX5H2SJpq1hrvsdgvmNY6zU7x
jo39BY06Oi36yy1kUTdFy5uuQUZNNGK2lIr7PX7eL1pT9BAcevho3EepyYB3XRTV
oz8jyGSXSAVLvyRQDFDlIIyR9JGxJMFEo01rxiT3r1BgD62wAFFdpG3K3FQcCapK
ylw96V9Uo4RdWKkv6dfN9MkHItrIKWNzIAN22AxGDSHkCjY0E7vYNjyZlK1TE/q4
cBz+HOaPqpHJ2S1II0aD/U1bxFE/rBPmmqBWE/HEyQTi4m1Qvt3hHPxvuZpWw2ZD
98fWeaPtu7a9BLy7MPRV6Tj3w2bjSFmhInfCWnfkfWgzrDl/oCExWtNPPezaO6Dl
mdpaROkN6Kuhj0mcbwTgeJAchxto6kqblZQQO6LnE6dmbKp728+ZLgks1EMM/8WS
cXf2s/hPfvrqmltcgWk5Fe6bp+ZNw7fPMHOzfCRjRp0HmQyOGF28TagWfZ94HsVH
tB9oL8adIELEs+lVdjjsYAqeE38TKu8Qhd6VquCj+6S1fHT5gjIcfKH+0z/iEHom
2PHa6VjiCglckFaSsLzyh8ehjPUSYjWZbPOWkPYBhNPivNM54YajuTxSnm3nYvCa
+hF1KixgZ3ZTK4KhYWKQgKHP14GxpCT98OAV2VFKYk4LgM515/g=
=AmUH
-----END PGP SIGNATURE-----

--rmx6qoxsqzvhfohm--


--===============5701296604291439412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5701296604291439412==--

