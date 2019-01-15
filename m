Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BB1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:11:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A6A20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W8q9rxpR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iHdQVil3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A6A20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HeUNygPgSdxb4oSyJ4kTPyhmy0qbo6t1uNCb41J1b1Y=; b=W8q9rxpRxutvU5BgM1FYWj8C1
	rW4Zep+tMUqM3xLefoo1q6JNmOdtJj4q3D7+dePrhcZFbm0jlWervcbrL1cbYskfxksoR0Vjm6FYD
	vZmZvr9/vRPmgGgB21n0P7lMHW972JgU04LeWKihyXRbn6vNb0OLug8rVfl05FRkRGu6lqbT3FJdT
	Ce3d0tlYUPeeK9VYtTR+82RVvyNi/TC9aeMC0CGWq7+g+em0fNanHyGDLMbjAgJaAHSKpVvT0zzKS
	Il/15hpp4DeoJMAB5tahQRmasIIGDZR0WA17V1oyqoov3pHobI2TMIZl8173Szlg5jF6H+TozK5ZQ
	LaT/iaEAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjOUw-0003Gz-BC; Tue, 15 Jan 2019 13:11:18 +0000
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjOUU-0002kB-HQ
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 13:10:55 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43f9gn1TRPz9s3q;
 Wed, 16 Jan 2019 00:10:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1547557845;
 bh=GYdM6qXJEjqmXX2Iu8J53tSAEoQ34aZJKMfupYoO7uI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iHdQVil3RcJSAzc1C2R1QCbWbG23LNlYBD8BkeJBlqEN2gDog26fYyAq6W1hFqgPE
 8K2lvGvvlfWJiFgiETjcX9ei+5AtlnZpPbZjkgCfiy+9WSAtA+LwEPhBUw4mdyQWZ4
 dHAhYDN0gkod1/pZR6WSuI7N2x7gr9fK3YAmhsjSJl1m/z6RQ5LtkBLUyIUjJicWcW
 ZerFQxLpYwqBq0qV1ea/Ic0AqVcxhkZ8naW8wRAa5O6dnIpINkJITLOA/m+iQ/wtwb
 Calanjxv+H2dlSIAvZQokgTlDeEH/EK0flqV1sEHfsV/f8eK3Xa2a7PpHxEAmdFXsS
 3hdeHjmQy1Pwg==
Date: Wed, 16 Jan 2019 00:10:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Message-ID: <20190116001043.69529b90@canb.auug.org.au>
In-Reply-To: <e892304bde543b86a9d0ad4409d0c6a1f509a312.camel@nxp.com>
References: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
 <20190114005600.GN11426@dragon>
 <e892304bde543b86a9d0ad4409d0c6a1f509a312.camel@nxp.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_051051_950379_CD0F0202 
X-CRM114-Status: GOOD (  14.03  )
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
Cc: Anson Huang <anson.huang@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============2669195965695224140=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============2669195965695224140==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/t.tgKeD2y1yX06Oh8kdGcV0"; protocol="application/pgp-signature"

--Sig_/t.tgKeD2y1yX06Oh8kdGcV0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leonard,

On Tue, 15 Jan 2019 12:30:23 +0000 Leonard Crestez <leonard.crestez@nxp.com=
> wrote:
>
> On 1/14/19 2:56 AM, Shawn Guo wrote:
> > On Fri, Jan 11, 2019 at 05:57:30AM +0000, Anson Huang wrote: =20
> > > This patch adds cpuidle support for i.MX7ULP, 3 cpuidle
> > > states supported as below:
> > >=20
> > > 1. WFI, just ARM wfi;
> > > 2. WAIT mode, mapped to SoC's partial stop mode #3;
> > > 3. STOP mode, mapped to SoC's partial stop mode #1.
> > >=20
> > > In WAIT mode, system clock and bus clock will be enabled;
> > > In STOP mode, system clock and bus clock will be disabled.
> > >=20
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com> =20
> >=20
> > Applied, thanks.
> >  =20
>=20
> Hello,
>=20
> I'm not sure if anyone else already noticed but it seems the
> arch/arm/mach-imx/cpuidle-imx7ulp.c file was dropped?
>=20
> It's not in your tree:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit=
/?h=3Dimx/soc&id=3Dcf2d2d392906f5603cf0d0f3630f6386babf7e4b
>=20
> This causes build failures in next-20190115 with imx_v6_v7_defconfig.

That file does not exist in Linus' tree either.  And there are no
commits in linux-next that add it.


--=20
Cheers,
Stephen Rothwell

--Sig_/t.tgKeD2y1yX06Oh8kdGcV0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw929MACgkQAVBC80lX
0GyDEwgAmGv+Q6po4XzsOJ+7bVXlMggp3rkzl4n6ZYgfNPZgMeqcvHJ7/zVxj+TO
nesTdlgal/q+X5x0f39z8t4+UcXJGIpctOULWDMIRt3n5G0aLIIlTSFae9yf3+gY
2UvR483ALXoBUsoBFxJfSyBedzVvt+syAenCsN2RgSJxWe5ymPNX9/LZPjrJULEs
d32HvN4hrGcIwKoHLceHRUCi4OBA9yJ2qEkAXgoPFFMBA5LaLM36SNAwr7yGw+SV
kJQAToTo4IAs7LntQr/Kt1B/9n7VXV6UcrWRAKzwEp4ibIo8DTfL7Clglfgw+UgD
NXmau7HKeWeCpAjmy7kprK2pgtSpbQ==
=34oG
-----END PGP SIGNATURE-----

--Sig_/t.tgKeD2y1yX06Oh8kdGcV0--


--===============2669195965695224140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2669195965695224140==--

