Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A6C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:43:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB5A218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i7e+kPJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB5A218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=La9BTwqz/W2b8ipImlSQ/8rv6ps425wU2sFdKvpLA6Y=; b=i7e+kPJvuu5sh241fCE9LIxWp
	TOYDAdQfgGjZJohbrYNW++vJq9zvmzHnMRYCxJgWCooQQF48ssok8uyQpuAeURRqxJSHE+SaepaJW
	qVEetu+ZZM4OYym8EFNfu99Tjhlr5tz6mlLZgCQN8t6OQfF8WCo8yYATgx8O51qMkhJIAvhrr+dSq
	QuDZ2yP/sKz6m6zEw2q5Ko2OaIMXd1JD753C/5AR93z6v2XIIu5HSkeLTgIPV8Lu4aW0+zlNeWtDb
	eDySUOVzDxqy8BKeA+DRVOlK8usJlNl/VmtgSO9S0dCHn+I4jkCWvBCr/aCKw/IJ49RYLqvTiBp/Q
	97ndiOKqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn3dE-0000YF-3k; Fri, 25 Jan 2019 15:43:00 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn3dA-0000Xw-8x
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 15:42:58 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DDC4F20748; Fri, 25 Jan 2019 16:42:54 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id A4AF6206A6;
 Fri, 25 Jan 2019 16:42:44 +0100 (CET)
Date: Fri, 25 Jan 2019 16:42:45 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v7 2/5] media: sun6i: Add A64 CSI block support
Message-ID: <20190125154245.5wx2mwhzsjeaahi3@flea>
References: <20190124180736.28408-1-jagan@amarulasolutions.com>
 <20190124180736.28408-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20190124180736.28408-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_074256_631299_56F6EEA2 
X-CRM114-Status: GOOD (  19.06  )
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
 Michael Trimarchi <michael@amarulasolutions.com>, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============6376850304137156573=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6376850304137156573==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tnklj4wmwb3jn6kf"
Content-Disposition: inline


--tnklj4wmwb3jn6kf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 11:37:33PM +0530, Jagan Teki wrote:
> CSI block in Allwinner A64 has similar features as like in H3,
> but the default CSI_SCLK rate cannot work properly to drive the
> connected sensor interface.
>=20
> The tested mod cock rate is 300 MHz and BSP vfe media driver is also
> using the same rate. Unfortunately there is no valid information about
> clock rate in manual or any other sources except the BSP driver. so more
> faith on BSP code, because same has tested in mainline.
>=20
> So, add support for A64 CSI block by setting updated mod clock rate.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers=
/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index ee882b66a5ea..cd2d33242c17 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -15,6 +15,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> @@ -154,6 +155,7 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi *=
csi,
>  int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
>  {
>  	struct sun6i_csi_dev *sdev =3D sun6i_csi_to_dev(csi);
> +	struct device *dev =3D sdev->dev;
>  	struct regmap *regmap =3D sdev->regmap;
>  	int ret;
> =20
> @@ -161,15 +163,20 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool=
 enable)
>  		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
> =20
>  		clk_disable_unprepare(sdev->clk_ram);
> +		if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> +			clk_rate_exclusive_put(sdev->clk_mod);
>  		clk_disable_unprepare(sdev->clk_mod);
>  		reset_control_assert(sdev->rstc_bus);
>  		return 0;
>  	}
> =20
> +	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> +		clk_set_rate_exclusive(sdev->clk_mod, 300000000);
> +
>  	ret =3D clk_prepare_enable(sdev->clk_mod);
>  	if (ret) {
>  		dev_err(sdev->dev, "Enable csi clk err %d\n", ret);
> -		return ret;
> +		goto clk_mod_put;
>  	}
> =20
>  	ret =3D clk_prepare_enable(sdev->clk_ram);
> @@ -192,6 +199,9 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool e=
nable)
>  	clk_disable_unprepare(sdev->clk_ram);
>  clk_mod_disable:
>  	clk_disable_unprepare(sdev->clk_mod);
> +clk_mod_put:
> +	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> +		clk_rate_exclusive_put(sdev->clk_mod);
>  	return ret;

The sequence in the error path and in the disable path aren't the same, why?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tnklj4wmwb3jn6kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEsudAAKCRDj7w1vZxhR
xUtlAP9qmjr0n5lWso9gLYkmcmovw/38qCAPlv40kaBhVOuxEAEA72tWIsL9UcqJ
eD/tfORhcsC8Rk/qa/Gu4h4ecmwE5Q8=
=Om9h
-----END PGP SIGNATURE-----

--tnklj4wmwb3jn6kf--


--===============6376850304137156573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6376850304137156573==--

