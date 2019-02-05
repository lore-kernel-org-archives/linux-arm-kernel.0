Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A84C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:13:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70162083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BA5ZpRpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70162083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7oBI0e0H0N2uV7PcGgR2mhwQiwmT8AOwmRAu3T3Yxsc=; b=BA5ZpRpwwKGZKIIZdmQI5VDUk
	YuZmNqh79vDf08dsYvk4Pm5/c4aU0DNCyOiDjfKWnkMQrKulvITNUCXWP5WbKQ02A4MCPp9y22keh
	v+zV+dJHX/355fxd9RTfEVWMmSzcefrlhwfJdVRnBpiK25BATUS4BMmAntyvuIyFWJV4vuTAbx58G
	SE93jHtjJ0QN4vQTj55nAufItGK+ugA3ETkqXXoKw1aNtsHwwMVvBesWe3agKY+REp0yb7imENBM5
	D4cBV7FfbZ6LWX0vbae48Df8YXKHKfFGDST8dqdmcSLk24J8vPu/4LL6KgrgVZJupPfx/IOXA5WGc
	owLNhOasw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0XH-0000zS-W7; Tue, 05 Feb 2019 13:13:12 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0XE-0000z6-7h; Tue, 05 Feb 2019 13:13:09 +0000
Received: from localhost (unknown [46.183.103.8])
 by pokefinder.org (Postfix) with ESMTPSA id 6BAA82C0509;
 Tue,  5 Feb 2019 14:13:07 +0100 (CET)
Date: Tue, 5 Feb 2019 14:13:06 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: qii wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v3 3/6] i2c: mediatek: remove completion_done()
Message-ID: <20190205131306.GE12401@kunai>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-4-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1548057574-8061-4-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_051308_426192_5A91D49E 
X-CRM114-Status: UNSURE (   6.07  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com,
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2419614118991220602=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2419614118991220602==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 03:59:31PM +0800, qii wang wrote:
> Completion_done() is useless when we don't use its return value,
> so we remove it.
>=20
> Signed-off-by: qii wang <qii.wang@mediatek.com>

Applied to for-next, thanks!


--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZi+IACgkQFA3kzBSg
KbYX9A/+Iivc9MIigT8flNM1FNz4z+XyRPcIdNWzZOJTkrPhh+nvPaQg9Ou28BOY
h/19/ZuwrjWE9UjJt1YFXN2zUyuczWwFz9FQeK0YA4nF8z8k1kaQTOlC1zmPkw14
nSzKTjWjyMYxx/R1vuv4XLWjOkgrhr1GCsRle6ytq/Yuuh/By+yQVg6FXxPWQCue
JyaHEsvgN2TYezWwdSKO4NOyMF2yURo3b4VHhL3DVKFWFzkRPm7SZvlqAaDYIQKx
c9oJuUCJE55yTNx0d4YlQQreZZawxYyTVwfLREM5oztgY807+LYFL1pd0+b+EzrL
1A6cw4IFABGWEnnLWy9XpVwliNUi+WdzyMeDJsQfVvZgEc2cTZ0BbhZZJORh2wKo
4z8z7Roi1foHef+lyJwyzt96AFLSoeJqEbpuPggCiKKgYSHyfW1TMvXAe8IpgAv6
8Je+Pp4AzkSlS07YN+ANzjjGQxOZuTy0Vvlm4HDZVDhDrXmJU6Yrk7z99kBzKe/c
Zvyqtb9wUe6niiPIDTmyqGXtkjVrb9/7GdGcBwtltEq3bpHjTXwdRASYNRe1lqF+
diUZuYEjOcpDP6ukt5D9kzHdO/L4UxUkDxLKGa3b/RhWl3zQcKlw3uuRYxQT7g2K
EmUCZHyBWqF7RfERjascnpr1JUqe9pcLJzwfTkw+N9gbupY/weQ=
=XJSM
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--


--===============2419614118991220602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2419614118991220602==--

