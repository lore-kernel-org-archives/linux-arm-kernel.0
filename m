Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A937C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:14:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB3020815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MU2m5MHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB3020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a0dZnLN4Cj3LnCFwoTPZXkkoMsm22XS+MbllySHDeJ8=; b=MU2m5MHhQ5wP92eWHYPNIEaux
	hBvsoBKJ+LyJuISLf+5RrNMq8lBcq+GBUwfQSTwulAlEldDheIDQvVACV/GvYugkA3Mxe7mVO+izI
	/HQAroqQlAvTmUsAlgUSBPAcTRs03hxhpBuCfDQMgbt6bZ9PHGk5o8dYJAiM6Y9IawT1DYF7IxZGa
	xrlAVF23G9UXytCJ7o4p/9mrIv+HdG0PDR1ryAPii1toxXTGtRSixgcNJVAtc3d7XT6xiVpiU7eqZ
	0i6g+gveuB2Caj6JfYOUeZ1suyN31Z06Z1VjDBCWjkceHBfiwDCoQtgnSnFkKKxVC/4P6FXVvTNo9
	9lEt2uO5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8RT-0000Ad-Gf; Thu, 03 Jan 2019 19:14:07 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8RK-0008SI-Qf; Thu, 03 Jan 2019 19:14:03 +0000
Received: from localhost (p54B3379A.dip0.t-ipconnect.de [84.179.55.154])
 by pokefinder.org (Postfix) with ESMTPSA id D43822E3614;
 Thu,  3 Jan 2019 20:13:57 +0100 (CET)
Date: Thu, 3 Jan 2019 20:13:57 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v3 3/4] i2c: Add Actions Semiconductor Owl family S700
 I2C support
Message-ID: <20190103191357.iegsd3w2qwdyt7qv@ninjato>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-4-pn@denx.de>
MIME-Version: 1.0
In-Reply-To: <20181211080448.24007-4-pn@denx.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_111359_494125_36B11C45 
X-CRM114-Status: UNSURE (   6.32  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@cubietech.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 thomas.liau@actions-semi.com, robh+dt@kernel.org, linux-i2c@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5655031775422976579=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5655031775422976579==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fpxnagkc257sawko"
Content-Disposition: inline


--fpxnagkc257sawko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 09:04:47AM +0100, Parthiban Nallathambi wrote:
> Add S700 to the list of devices supported by Owl I2C driver.
>=20
> Add Actions Semiconductor Owl family S700 I2C driver.
>=20
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to for-next, thanks!


--fpxnagkc257sawko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwuXvUACgkQFA3kzBSg
KbbIXhAAn7Gr/BtL4P+5gCIKhJ+7uZDVeTxTHH6v/I9Zcrlr25sY2PgnqXEwzsGl
Kz+3zElXy4q6qMZ8sXjc778+VsmwE5TJXEmnYiVobCprx0Paf+pgxMX/1gKOYmSr
gBJqGiW66FeJSBYkvaoI89moQxyJhl3vmJSDVi8mrlE8/AXhfqyJ2m49IdflIn/8
7WHwMD9jNIuC41tJBtqigS5l0UjYtyB9j4/EXXltcBYyom9t7famyomNOE0eeGRn
qhcN9uBNhHOl4yBbjxqsONyMt+ZjOEa9TyPHXLUsob0POwRwe0FiJMiMy3RmIrqc
n5BbAJIjqATGmpwKtVDjEEvAJ1qbUoMUNu6cEbcmyV5ySkJ3OwKPf8zUiGDTkFU/
/hVvAtc0WutEzoz1kwKpsm7OufuE6C96cDNkPvDyzgI5VjlSsFuhmBxtmUvLLIg4
0E9h5j1cpI7luxt3SFGtIM4kfJyWXDZnIRGxllJKkgmQzM+9+ZkTLjpXQ5sFMuJu
VEZQfG2Z5AcKUDzaHcXLA0lhedrDTYQIB9IowFRN8AHjxpt4TElehgkroohOh2ad
sH8jaN9oH/uYuA1z4SjtPVafd2giR8ChZ3PMrqVfuCRtgav7c2morRLr9J7Ru3PS
lFibpUL6pUNiw1M9C+3DD+68y9MkiGTGf7PUk+WLIH1n8CdGLgU=
=bUoW
-----END PGP SIGNATURE-----

--fpxnagkc257sawko--


--===============5655031775422976579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5655031775422976579==--

