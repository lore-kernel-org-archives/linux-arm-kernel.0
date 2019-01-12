Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164F0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:11:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B09206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CS1AQIis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B09206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xttFdx1jvwC9nm5C7imCdDQaFy0yd5s0jy2dpUcRY84=; b=CS1AQIiscjHRv1EuTvQWmLag8
	GB7f1jaE8Uo2YZEmAVoLnJfu62UttYGOsoKvAbpZnnVITJatEuhSEvkm/SaPV45ayOOcevrlPcvTu
	3RezMiONOptfGdFksQ7t0Ka4FaEYZ0H0xH80AWjAlm3lv0fjIXZJGkz4luD5GZqiZoqsiaYQeWVkv
	/mxSKwD38Y58EH5UE3P38RcHA3TWmKnkqhjEi6Q2ZeayH9MI/kv6ftbyQ3SrEYKp2t2P270YKZNx0
	B48d3lZu0JwD05ev0SDvLUkRNauLSSObILvBXJDC9COMHRR9kjOx/4VEwnyURGv81LiaB7t/LdZCo
	VDOID914w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giQYZ-000279-Ck; Sat, 12 Jan 2019 21:11:03 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giQYV-00026j-SQ
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 21:11:01 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 43cXTC4Yxzz1qtfD;
 Sat, 12 Jan 2019 22:10:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 43cXTC3Mphz1qr5L;
 Sat, 12 Jan 2019 22:10:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id TIFhNRoS2692; Sat, 12 Jan 2019 22:10:54 +0100 (CET)
X-Auth-Info: 7kRJqod/Kpam6efA+TQpF/fVNLezuQVofdkjx+pVvGs=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sat, 12 Jan 2019 22:10:54 +0100 (CET)
Date: Sat, 12 Jan 2019 22:10:40 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ARM: dts: vf610-bk4: fix incorrect #address-cells for
 dspi3
Message-ID: <20190112221040.5a5e85ee@jawa>
In-Reply-To: <20190112011514.8527-1-shawnguo@kernel.org>
References: <20190112011514.8527-1-shawnguo@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_131100_213536_BD5582AB 
X-CRM114-Status: GOOD (  17.39  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1919492495679358674=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============1919492495679358674==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7DEwXGI51mwPs19E5D8Tv7Z"; protocol="application/pgp-signature"

--Sig_/7DEwXGI51mwPs19E5D8Tv7Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> The dspi3 is used as slave controller on vf610-bk4, and the default
> '#address-cells =3D <1>;' setting in vfxxx.dtsi causes the following DTC
> warning.
>=20
>   DTC     arch/arm/boot/dts/vf610-bk4.dtb
> ../arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning
> (spi_bus_bridge): /soc/aips-bus@40080000/spi@400ad000: incorrect
> #address-cells for SPI bus also defined
> at ../arch/arm/boot/dts/vf610-bk4.dts:107.8-119.3
> arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
> prerequisite 'spi_bus_bridge'
>=20
> For spi device used as slave controller, '#address-cells' should be 0.
> Let's overwrite the property in vf610-bk4.dts to fix the warning.
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  arch/arm/boot/dts/vf610-bk4.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/vf610-bk4.dts
> b/arch/arm/boot/dts/vf610-bk4.dts index 689c8930dce3..b08d561d6748
> 100644 --- a/arch/arm/boot/dts/vf610-bk4.dts
> +++ b/arch/arm/boot/dts/vf610-bk4.dts
> @@ -110,11 +110,11 @@
>  	bus-num =3D <3>;
>  	status =3D "okay";
>  	spi-slave;
> +	#address-cells =3D <0>;
> =20
> -	slave@0 {
> +	slave {
>  		compatible =3D "lwn,bk4";
>  		spi-max-frequency =3D <30000000>;
> -		reg =3D <0>;
>  	};
>  };
> =20

Thanks for fixing this problem,

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/7DEwXGI51mwPs19E5D8Tv7Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlw6V9AACgkQAR8vZIA0
zr2t/Qf/YsmybKRa3QAFSpTV21UmPyhfPZM1SOpPNQb1ku+XdHj+rF9xtkqNIqlu
AHU9XBs4qa9fv4F3eJzFMJoxl8UkRqr5Y6pnO0EcPwcBRx+Gd1vppr/j6Kxw05bv
ZN0CyxC/n+u76GsxuAhystEanlBPGJ3Fq5Q4rx/p/1pvKa0pGGdP3UOgiF0eGb3p
WH7N1kfEUu74OyW6ostOwHhmPm3frJmutYpJKEW/pyCOVJpo3dC5pAM2uKj57CqK
RvmDks7kUsQjMaP/15/gKDtK8olCYoVhWYl8uiqsDNpK5M2rcrdBNL7/XhyKX8Ns
cHBpZXcQd6L/BQk1iXFZvNFzNpVWlQ==
=iqxb
-----END PGP SIGNATURE-----

--Sig_/7DEwXGI51mwPs19E5D8Tv7Z--


--===============1919492495679358674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1919492495679358674==--

