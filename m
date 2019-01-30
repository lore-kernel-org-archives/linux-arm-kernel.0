Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA6FC4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA7820882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VV5GBjnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA7820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qufIEU5dijvM4f9159HhjUdIiA2wF9KV/vAISx2hNW4=; b=VV5GBjnw6iXCt1jqKSqyIxmqO
	Pln7/58NU78jGhww8INk2d7c4yN+51agwbPnUHy/Y3nn9Li1OUfiO8bKl1whipzb5mfRlpdJLTWbS
	rBUN5K+T7S+f6NFQUNYD4tCVop8Jt2stkEE9vxnbW396aynGsL3KZDWqwucyJ1yPXj4l/G8RIjdZy
	W/LekKKYaRF3tE+Vi0CC4e5WB9hWRmoI3oc84+7hskQRzPyvmYB1EYpweLVE/KuWhuHk5TlZMpEcZ
	H1Vp4Hh5mnhTEhgEdEnToAPE3thoCFcXaCA7VzjDvks3761RPygj+mxsjJE2HvCu5dvmH6NrXEImv
	kkakpOQQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomBk-0005Iz-RR; Wed, 30 Jan 2019 09:29:44 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomBh-0005IN-3q
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:29:43 +0000
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id C75B1200010;
 Wed, 30 Jan 2019 09:29:27 +0000 (UTC)
Date: Wed, 30 Jan 2019 10:29:27 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 10/10] arm64: dts: allwinner: h5: Add CPU Operating
 Performance Points table
Message-ID: <20190130092927.x65ihy3je5n6324w@flea>
References: <20190130084203.25053-1-wens@csie.org>
 <20190130084203.25053-11-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190130084203.25053-11-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_012941_452782_C7E2569C 
X-CRM114-Status: GOOD (  10.66  )
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
Cc: devicetree@vger.kernel.org, Sergey Matyukevich <geomatsi@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, linux-kernel@vger.kernel.org,
 Emmanuel Vadot <manu@freebsd.org>, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============1949722415091774980=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1949722415091774980==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fkao57vkiawei5pc"
Content-Disposition: inline


--fkao57vkiawei5pc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 04:42:03PM +0800, Chen-Yu Tsai wrote:
>  			enable-method =3D "psci";
>  			clocks =3D <&ccu CLK_CPUX>;
>  			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			operating-points-v2 =3D <&cpu_opp_table>;
> +			#cooling-cells =3D <2>;
> +		};
> +	};
> +
> +	cpu_opp_table: opp_table {
> +		compatible =3D "operating-points-v2";
> +		opp-shared;
> +
> +		opp@408000000 {
> +			opp-hz =3D /bits/ 64 <408000000>;
> +			opp-microvolt =3D <1000000 1000000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@648000000 {
> +			opp-hz =3D /bits/ 64 <648000000>;
> +			opp-microvolt =3D <1040000 1040000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@816000000 {
> +			opp-hz =3D /bits/ 64 <816000000>;
> +			opp-microvolt =3D <1080000 1080000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@912000000 {
> +			opp-hz =3D /bits/ 64 <912000000>;
> +			opp-microvolt =3D <1120000 1120000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@960000000 {
> +			opp-hz =3D /bits/ 64 <960000000>;
> +			opp-microvolt =3D <1160000 1160000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@1008000000 {
> +			opp-hz =3D /bits/ 64 <1008000000>;
> +			opp-microvolt =3D <1200000 1200000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@1056000000 {
> +			opp-hz =3D /bits/ 64 <1056000000>;
> +			opp-microvolt =3D <1240000 1240000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@1104000000 {
> +			opp-hz =3D /bits/ 64 <1104000000>;
> +			opp-microvolt =3D <1260000 1260000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@1152000000 {
> +			opp-hz =3D /bits/ 64 <1152000000>;
> +			opp-microvolt =3D <1300000 1300000 1310000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */

What is the frequency and voltage that U-Boot sets up?

We've had the issue with the A33 that it's started at 1008MHz, with
the matching voltage, and ramping up the frequency to 1.2GHz on boards
without PMIC support would increase the frequency but not the voltage,
resulting in a brownout.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fkao57vkiawei5pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFFudgAKCRDj7w1vZxhR
xdeCAQDoubN0q581tiwZf/MzwZJNZ0WbAH/O2srVCbUsx9c9AQEAtB7i30h+fWwp
nA69KJX4vmzX1+aSqHYC43rH6+0KYAY=
=lYRw
-----END PGP SIGNATURE-----

--fkao57vkiawei5pc--


--===============1949722415091774980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1949722415091774980==--

