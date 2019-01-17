Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40F1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:01:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CBC20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a2zLDg+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CBC20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eL8YoP6NzVZTDuXpbr0JPsW6oeWBYiQFei2A3doyXOc=; b=a2zLDg+8My2ZN1KaTFte94UOZ
	lb4DkIAb1oFvIO7WbBnys7h/T/MSSKe3iUUsetYGgcYQINsJIwden9Kjv0PplIe0QIvLhltmdVOtx
	BCsFrDjaYeBZ4o/5Pw9FPkMdAOu9YAnfGP2ezFNNyftG4taxo94shxF8wFMi6qnE4BOoXK3IhVHYx
	El0WUIHzqNzNeCcBXL/7dI8wuAMEv4qe/WfYEEs5A7K46i4tgCN7BYRoEV9dA2sgDwpAs9DG+0IMv
	MFgTOPK3i6zFibx2Q395fn0hWGjeyScuoVSu1fmNCwZel/E1h7gjXGuz8Rmf6YyPekhAD+d4OKAik
	GnXeT0AHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk9Aj-0005xt-KU; Thu, 17 Jan 2019 15:01:33 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk9Ad-0005uh-OH
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 15:01:31 +0000
Received: from localhost (p54B33243.dip0.t-ipconnect.de [84.179.50.67])
 by pokefinder.org (Postfix) with ESMTPSA id B1B2E2C3F83;
 Thu, 17 Jan 2019 16:01:26 +0100 (CET)
Date: Thu, 17 Jan 2019 16:01:26 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH repost] arm64: dts: renesas: r8a77990: ebisu: Enable
 HS400 of SDHI3
Message-ID: <20190117150126.gku7sr3dcujfx2rq@ninjato>
References: <20190117143829.6ubwnj5cyh74mjq3@verge.net.au>
MIME-Version: 1.0
In-Reply-To: <20190117143829.6ubwnj5cyh74mjq3@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_070128_110189_6AFA24FA 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1430802606510824841=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1430802606510824841==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="65nwrc44hpfugdxr"
Content-Disposition: inline


--65nwrc44hpfugdxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 03:38:29PM +0100, Simon Horman wrote:
> Add SDHI3 UHS pin control and use it when enabling HS200 support
> for SDHI3.

HS400

> # dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D1M count=3D512 iflag=3Ddirect
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 9.02486 s, 59.5 MB/s
> # dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D1M count=3D512 iflag=3Ddirect
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 7.36003 s, 72.9 MB/s
> # dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D1M count=3D512 iflag=3Ddirect
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 11.0156 s, 48.7 MB/s

Hmmmm, quite some fluctuation and far away from the performances of M3N.
Marek, do you have an idea why? Did you note any E3 differences when
coding support for U-Boot?

> diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/=
boot/dts/renesas/r8a77990-ebisu.dts
> index 89383aa35d65..f2846c9eb83f 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> @@ -535,6 +535,12 @@
>  		power-source =3D <1800>;
>  	};
> =20
> +	sdhi3_pins_uhs: sd3_uhs {
> +		groups =3D "sdhi3_data8", "sdhi3_ctrl", "sdhi3_ds";
> +		function =3D "sdhi3";
> +		power-source =3D <1800>;
> +	};
> +

This is exactly the same as sdhi3_pins, so no need.


--65nwrc44hpfugdxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxAmMIACgkQFA3kzBSg
KbY3xA/9ECx4ZBowhwEhkAx7HqMz6XqUHCVzfLNz7nVtHMLQ9FOnWmLYwPrR8Q28
l3j2yg7TxAf5SQ3oABlRrzEiwUnHzdHpM+gjA1vSdwy7lHSRO2gVtsLgrSpc4Yof
C0G86j6IdOWLsn4sU7vhgsS/mDcXY9Nbtcv+yGaZEgfwyk796pu9KpCSTicfLCDo
1mpRoOWTGNss0TDS38C9Bk2YX3St/gy1haElEAeTxhKruNhZ3aR2M9MDNJDDKZUB
+qoHF9dDmCjz9iHe7rZvP8IIMVE2fkeO242/L5QKkw42qtPVCBC5/glfWN0Mqf7n
jremIBkDgi6eV6fBFLVWF0xHOIBxJE899ecbBAW2/BERcyZi+BscIg9k8p0/HVoW
R4FjUL9hIhM7oHzNvntTjiHSyUc+YRza6Wc6GIod+W2SiBoCGG39P1ExLhu8qe0d
x/eZOIvUXIkjaz45COkrWpBMa76cxIJ9XmirD+nVSr3YUFr/zkqkItD7gp5BITY8
SLqAfldB8uW0J4rlSRsWmueJJt40AAMtuBMiNUAONfDpzoDG6ELWp8BFP88ex4qF
Pt1F6zlkI3X3bzDFGSJ/bgSBoyl3aUX69+eLY/J4wPommA88E4YoKhzU1TJHjcf3
Xx1yYJYB1q/MLzK5qSa/JQDmzDWOJArAbOV9+tAkx7RG8IzJryw=
=ErPV
-----END PGP SIGNATURE-----

--65nwrc44hpfugdxr--


--===============1430802606510824841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1430802606510824841==--

