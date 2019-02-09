Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B66C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:25:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C8821919
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nrkY2ohN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C8821919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jd4wdbF3xWsVuFLCWtsU4LNBAGpSJ+M+PatG7ttr/XI=; b=nrkY2ohNV0M1owX/HZoG3cgra
	DLh3i3bXiyt1Rq00FO+YJLacZUf0dBzKT0zeqnQC4H1MajnJg8usJ+qY0N/nEHonlpbXd3N4HCivT
	gbaIaXqFGPyNeub0fL0AZ0Fv9qv7tGo0io+lnFYCU3dUi+P8PBVtXXJCEqUNWvHhVqdkIdovlWLAg
	zkd23rVimh145xzetUXIBqBfVnyAztjM6p7VYsvpXmlHUAeZ7iLcHzSR3zsXVBp3Z0CE0eTc0u6Bl
	YRpaH1UW0u4Pkwy8c5OvOZyr+WnbtO3o/e/0HBtVVkxatIFK+OhOYySQuUvyOBhZVM70QN1v8JGtH
	sMqHHz4Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsVRM-0000cm-Be; Sat, 09 Feb 2019 16:25:16 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsVRI-0000WK-MF
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 16:25:14 +0000
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MexaL-1gUUMk3a7l-00Oblv; Sat, 09
 Feb 2019 17:24:52 +0100
Date: Sat, 9 Feb 2019 17:24:49 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock
 is disabled
Message-ID: <20190209162449.GB2061@latitude>
References: <20190207225211.GA17552@latitude>
 <CAOMZO5BH1Su=tKD8vV8+-i_0a_4fNDQKbk0q6DX5TZWYezeH9Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BH1Su=tKD8vV8+-i_0a_4fNDQKbk0q6DX5TZWYezeH9Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:L4kPKEpMuxN8aBEbU5KwSiUdaaxSB6OC8L2m0BNA8rng1b30JcH
 8QfFXQfuY9+TDj3FmEZ2o05lN88mr8qZpsxfWIeo6qydiZ54+yQb1v04rwvpHeocLl7ca7a
 /oCSe7OQpUynukPNAg0dAFnhMtW/d/Hfc0I7Tut2EsXmFSUjTSsF3rJ4oeK2SjcHsZwea5Z
 qqJs2eiOYifys/PeDftQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dpiui8vaG0A=:Kc4n5gwv8Y8eFSHgWwqwmv
 lDWTHlMsbLqQwwcZ6CUM2sBlAbF8PK0p74KGl2EGj3SHXrhneO6ivzUEFAykpdKC0sgxv6fbZ
 nnf35kr9Q0Deqg7YVEjU6UVwAglz4Dxfim0kWVW9rlJaDBmu+klndoY40pJK5P+o2UgrQIm9t
 hPGGoMKHTuJmEKQXsRj6tslnBXYPXHiBc+NrROl0ELEotJMsDSIY7//OEkwRu33WCKfOd7JFM
 qJ0hkBF4BgOaxQ+hg4szQChjqDQxzg/8w4fjzwxoyqVeWRMA4WWZrHCwmA0GFqtnLekKaA+CG
 zwxnN3NRbwUSIj51G5T3REJWyzH/X+ygkzdv/dk2Q9hPQXF4NaPDq3aJDV7LSzcexSmBWAsY7
 LapBJNLXCz38Okx+RlYZjVGAKsDlZIb9R8gLhCqd9n0phuWKbfxbkFuZjCnbkix4Wdshi41/I
 WE9ygV+4tiX7+DzoEHWsAHTHheDZpmPhP3n6Y0bYwrhkAKlY1rpDaQH6PcmqkfoexyH27h7VW
 DrJg/oRJGE5vMoMe+KZ3nTUlHG0yd1vcQ+WulaZ45+ofo2a0i9GB+iNJ1mliw1gfI3tcwhyjC
 aHJxSBbOt5jHvYLVh/9vLO1gglw8m7DS3puOcmhm8i7ljmpca37n/LTmzA9Gn6Mny0tKH3Wxt
 6LeWRkWB2i9AtwcfS/+PSKxSJWVx513g7eXuflo1DxWmfSYD/rwi0G4IHnjqBUEt8NOwlNWad
 4XaTYi4wOhLjSvNYPXjde1T4/vu1+hoLBZmW7wSfKCWbINPePojG2mbmh6j0hBuCScZhGoYRv
 1wQrEnG/cyReFEa5t4LqwtYP5Xk+UkCoh1Dn4yxQIH+LXX2cTJOIpCYQXNNO+T7o7DsFIlHai
 0yNqa/PQFs2Z+RdegzWrNgZrL6WOhTj3ZFFKPwv9YN1vXtb595ROIqMD35bb2l
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_082513_047621_612333CD 
X-CRM114-Status: GOOD (  13.18  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Michael Turquette <mturquette@baylibre.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============2217695590600289084=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2217695590600289084==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 10:50:28PM -0200, Fabio Estevam wrote:
> On Thu, Feb 7, 2019 at 8:52 PM Jonathan Neusch=C3=A4fer
[...]
> > I tried to compare the CCM's clocks between i.MX50 and i.MX53, but
> > unfortunately, the i.MX50 reference manual doesn't have the table called
> > "Output clocks from CCM".
>=20
> Please check Table 5-10. CCM_CCGR3 Gated Clock Mapping to Target
> Module from the MX50 Referene Manual.

Ok, the tables show:

For i.MX50:
[1:0] 0 ipg_clk_root    eSDHCv2_1
[3:2] 1 esdhc1_clk_root eSDHCv2_1

For i.MX53:
1=E2=80=930 CG0 esdhc1_ipg_hclk: affects ipg_clk and hclk inputs of ESDEHC-=
1 (esdhc1_clk_enable)
3=E2=80=932 CG1 esdhc1_perclk:   affects ipg_clk_perclk   input  of ESDEHC-=
1 (esdhc1_serial_clk_enable)

Table 18-3 (Output clocks from CCM) in the iMX53RM shows that
ESDHCv2-1's ipg_clk_perclk is esdhc1_clk_root, so the clock structure
does seem to be the same here, between i.MX50 and i.MX53=E2=80=A6

(The reason why I looked at i.MX53 is that there are several i.MX53
boards in tree, so it appears to be well tested under mainline Linux)


> Does the change below help?
>=20
> --- a/arch/arm/boot/dts/imx50.dtsi
> +++ b/arch/arm/boot/dts/imx50.dtsi
> @@ -102,7 +102,7 @@
>                                         reg =3D <0x50004000 0x4000>;
>                                         interrupts =3D <1>;
>                                         clocks =3D <&clks IMX5_CLK_ESDHC1=
_IPG_GATE>,
> -                                                <&clks IMX5_CLK_DUMMY>,
> +                                                <&clks IMX5_CLK_ESDHC1_I=
PG_GATE>,
>                                                  <&clks IMX5_CLK_ESDHC1_P=
ER_GATE>;
>                                         clock-names =3D "ipg", "ahb", "pe=
r";

Unfortunately, this doesn't help.


Thanks,
Jonathan Neusch=C3=A4fer

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxe/skACgkQCDBEmo7z
X9u2ohAAvLuVCy5ZxTQDN0CXlBDu1D7PpvjueQHOOrySP3dRUCnU+ClFXGmp7PSH
ijXwP///CybSSTos9kfOKMqkyMauddznp13b+Gn0G0dankm8eAptjAoMV2puW6HY
XbF3T+2ISbUWZDZCzaJxw29VsKjxLDcP6x1DDTIeNqVMwta9Bi3tIUIhwRDvxrAw
UFsHmM2kyLqiAbjtMTHXKMtcK/QydZ1fZnv/tHZTZeeomAowNc5vxgnjINETb/PD
mVRr9ZALblq+Z4vgLwIIAomcQyEU+kdJv3ebpR1q4J0oxkIceWl12+W9k1EUlLEN
T4BUdxHEQ2kplvYFw1eoTLYK0P+HNoAdLlPUpzBxWo/Srxc8hnS61vs5IGIGzFAm
qt1ZbVm95N5j6tgzmVefCClYdl389ReYyfKl6R0g/YKYhh9nSZvPfEFY5vWZB0pq
msPMq95W7ivkMM43hydHqT2IHdl+CGeAcP8ldEBFoQUX8FHmbYnepHbL0ZgvgLTN
dtFhHj6xvzfa8CxFMX8QUYen1bSYWc+/9Nxfrq8S9BZJs9mw7yHqKrdu1YYssKok
f414MXSOjUIKV0Wjqhyn+CsAp/vD7/efrwl7+aayIfCjVGP+NYvgJ0a4vxvM0J5o
dRLQL/r5Wn4l+IE73KjjNb+BtsKBnn2KvSOLdMT1lX4KNDp7Ti8=
=hKLs
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--


--===============2217695590600289084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2217695590600289084==--

