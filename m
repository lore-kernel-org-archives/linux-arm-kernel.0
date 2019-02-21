Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AF4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:21:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F6720836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R9DJv6l7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F6720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1SnfSZGacd4zlld3cZBf5EbYM2Ckbs0fj+i6ruLDh/w=; b=R9DJv6l7rMscGEY+ieezKNTQM
	kpREr04cEmLGWohKdsBOdwfq1erMZR+e4NYxaMyPY0k1swOZIolmr3F2cE6w9hOzSJPSOhVFhh3oo
	lKImA25k+9GWYhRDmlXkfTI5wg/nKqRih8sAWZo6c5WaM1ReFBwzbLchF6Cuu+Rr4w4Kaxo1zyO8d
	8bpRIo9TPTBaAV00g9YXOfl3w71tH90AcBH3/gEGYXnaxneUXfFwREB+5vGCuXUTRdUxnyMqKgOn9
	OF6D8I3MOQc0CNBE+Z+zeoHhXZEnq9XoCY4OWmX8IWf4po7PbscYkF9n5fJojWMltq4sfak2tzd7v
	Nn9I8qwtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwtup-0005l8-Gq; Thu, 21 Feb 2019 19:21:51 +0000
Received: from mout.gmx.net ([212.227.15.19])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwtum-0005km-Dp
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 19:21:50 +0000
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoVBq-1hXaEg0S8w-00gaiC; Thu, 21
 Feb 2019 20:21:32 +0100
Date: Thu, 21 Feb 2019 20:21:29 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] spi: spi-gpio: fix SPI_CS_HIGH capability
Message-ID: <20190221192129.GJ2061@latitude>
References: <20190221152459.axrjce7yqkjmedgl@shell.armlinux.org.uk>
 <E1gwqlS-00053l-QU@rmk-PC.armlinux.org.uk>
 <CAOMZO5B_ELinMtAipaM9GP3Frj1YxRA5DmL-RJYnSE5i_W04uw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOMZO5B_ELinMtAipaM9GP3Frj1YxRA5DmL-RJYnSE5i_W04uw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:UD12LPKP5pSWpwc1cul5GP64V515va+yJdCaa5riuwKlXX3jkBy
 KU83g8oBuolSvhXudm3/9Dze8maZOBQ/gea/MXzhyuNtM+11KuYJ+smAWSPOFihhBvD0D5v
 3Kp7KRYSi6AvghyIjNqjGNCqX3drduBqt+ucnodqhkZDry+EvARC8IQYNdb+us4iePO5PkS
 dDGgbsPMZ+u5T6nnE3ZBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bq6VWYcrwQY=:dLq/ngOpxjWO22fxt4hj2W
 2NWW3d5+O//WomA/2ls0x9g8dGGZj/P5dl23dqKu7vTiAzgH0kATZZf3X9StMMtMi9irY9tfE
 b1XQr7tpoIJi6UZgCNknxC7ifzQ5/nwUoA3kE/a70N82u66mCaH5zw4wpdbhg1d3yR7Yy0Sij
 ZYG3erTUMUAKl7VU83Sjr5zljhg/eP+vrtP17TAJbNlq3kcFnwmRDKv9OMS/30HkMMhkPbYZx
 01tbwPkqSznfxvYjV0WLWdjd8Phwli627vn9jGRDszRWz3gLl3qvJ9cJn3MrHIHWds3JKlf7U
 lC+MbGlfmZyDFZFMQIKBc3Xl1GqY/Fb1QtFqc3D4LKb0YZ7d2jXHnC+6nWgP99VlNXKSVTiFh
 lo+zfdFWFDBmdDcLwdvULqwd+wxMiW78aofjtJonneTSYXIeGi1iQXk0meN2GJGRDipUULqFA
 CmWER2WfkgJ3eQz9TVpagCGCDMC/ERV76d13tPrORInqUkWtpoBikpqLJeihFZ++RZ1Ra3aWq
 vXg0aestqLMiK86zOymIeBo63zLzsA2S/+nGYP/j1ZnkxEQ822W/24plLR5zyEK2X0s+3i9ia
 WmHcF7tvIyT/25GsJWhZPlwzHDVzlFE7y3i1TqOK8NQrfVC649VFAAm/iv89+xQswbtgLCSsP
 F45ms4thasN8q84AwtjKm7ksDr1YPisyRgteWRwwVhWWmUydBAWCkiYplJWgWr5wczdLsvUPX
 nL+UMYMTQo4m9Ev1Pzmdmr0FEQs7f874y7cXsJSCju/jcFb4fyvqb/6LNSjP0SeF5fTkA/j/3
 +ATot/sPtoBaAsU9LzctDzqyKMX7IT/3i0Kp6YPpqknTd6v5/QQiHnLgX4V1hD22YEn1rCfeW
 1ioUwSgsF52hu0VNFu2U4qjetEq+GVvWJvBKzYr8p/8HHYv4dg8nr0EafK4fF+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_112148_777767_71E07B18 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-spi@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
 Mark Brown <broonie@kernel.org>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============8561632142360866982=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8561632142360866982==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 01:14:04PM -0300, Fabio Estevam wrote:
> On Thu, Feb 21, 2019 at 1:00 PM Russell King <rmk+kernel@armlinux.org.uk>=
 wrote:
> >
> > spi-gpio is capable of dealing with active-high chip-selects.
> > Unfortunately, commit 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE
> > support") broke this by setting master->mode_bits, which overrides
> > the setting in the spi-bitbang code.  Fix this.
> >
> > Fixes: 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support")
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> > Patch against 4.20
>=20
> Adding Jonathan who sent a similar fix recently:
> https://patchwork.kernel.org/patch/10804855/

Hello Russel,

your patch looks better, and I think Mark Brown has already applied it.

Thanks.

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxu+jIACgkQCDBEmo7z
X9u6xg//Y3siFJybMCa3/A1LdwUkzzddcQTwtdyEB1/3MxL6r6c0EnQDNEex9C8Y
X6FpoSbs7YshlZ1dvPz3BaOE7t1w1kB+pMVvvhTvg5BCdG6/T1T2JwqM4hSraQmd
/5hSR4VXZOTz6XgGX+MXP9q471DVcm06lRrH7qXnjRPnMQqJ8lDCZG7gPlZ+oF1z
3s/o8LU4zIPZDPwt5Y9KRIEntfl5fE2HRxxmJuO8J3xDnU8BZR6zUzLeEa8UVOmK
EqnaJqCRR76gYtB56rgS87ypzeJa0Tu9Fwi7KOYbsnuPnASgT56/5tWORaAOWWR2
/bYPlnPLWnW7VIrphuu9AtiJBVmIvzXbLKQxDWralUkhuUHTSDAKWtax4sFJc0TE
q6j96aYeF+0Rvf3wKqb48CQKGKh7h+G+loWKkKHdVTGsVU83pA2FG42SArDXeLMG
cW3pQ9Rou8otTAdAoc/DxLQCNUNT4DdIjVegidHn5HnCF3MlAE7EKYs2Ru9eq1Qz
nsR3KX0FaB0ojeElo+D+UJ8Q0Jd/A7EADVXLtXoQUxTixfkBF1NIpn462fn8ljCE
RyI7+Cm01o9UIVuW2fGfObnOgTVcbMHvTzuBh4H6v2vFawvPJ8BQeIEXkheNcPfH
DapZlbrUtRZ6TJPo8n603999cfveVGmta/iyk5VTCgwV9SFqN9g=
=ZvR7
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--


--===============8561632142360866982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8561632142360866982==--

