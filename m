Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE90DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:27:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D20E2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PVU2/fW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D20E2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TeAkiCiJbeaXj0fnA9xZoL8qJqV2TsKq4+Z9Z/wqGMw=; b=PVU2/fW7KZG5FEg95nEwCvIK6
	TTlHHmKgFyzj52KEH7odPE28UqIZIVWep2pllZllVafVL3r27p2Kbs2drRn1biqJrLXmNCEndFnmP
	VOlV4CC9p7yDsWg87wcPMLverc2mcgpLK0JdtUAsMcxhya/8nqJqUFJBr2QTX/ulSLKmFK/08eUHg
	dTjdTuTuOXzwJ2qgH2B1LA9l12W7tE7xkBz8ckcx7W5cWUhqJJc560hLJ80yQzuzwXkHNV+furPwS
	Cs+xBYeytwY4ExAhgxseeMaAZTMf1hbraL/etdV7CVpKX3wu5kdsVlFFEH9kWSLtSkjJDDgesijd8
	88GkzDiMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw5QZ-0006hL-UA; Tue, 19 Feb 2019 13:27:15 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw5QS-0006fZ-7K; Tue, 19 Feb 2019 13:27:13 +0000
Received: from localhost (p54B338D8.dip0.t-ipconnect.de [84.179.56.216])
 by pokefinder.org (Postfix) with ESMTPSA id 32EBD2CF689;
 Tue, 19 Feb 2019 14:27:05 +0100 (CET)
Date: Tue, 19 Feb 2019 14:27:04 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190219132704.pmtai25fltxkwso6@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
 <20190205131641.GF12401@kunai>
 <1550109268.30065.13.camel@mhfsdcap03>
 <20190215090257.geumssb2cucs7rzt@ninjato>
 <1550316723.30065.44.camel@mhfsdcap03>
 <20190216122915.hchghozcn7ntdkbm@ninjato>
 <1550582023.30065.52.camel@mhfsdcap03>
MIME-Version: 1.0
In-Reply-To: <1550582023.30065.52.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_052708_427122_2131F1CD 
X-CRM114-Status: GOOD (  12.41  )
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
 srv_heupstream@mediatek.com, Rob Herring <robh@kernel.org>,
 leilk.liu@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2657901014486394359=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2657901014486394359==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k2kejit4druie2cz"
Content-Disposition: inline


--k2kejit4druie2cz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Maybe you think that MT8183 SoC only has the I3C controllers. Actuall=
y,
> > > there are I2C and I3C controllers on MT8183 SoC. We will remove
> > > "mediatek,share-i3c" for I2C controller driver, so these patches are
> > > just to support the I2C controllers on MT8183 SoC. For the I3C
> > > controller we will send some new patches which are based on i3c
> > > framework directories(kernel/drivers/i3c), not based on
> > > i2c-mt65xx.c.
> >=20
> > Sounds perfect to me. If it turns out that the I3C driver can share
> > things with the I2C driver, we can discuss it then. But unless we have
> > an I3C driver and know for sure, the above strategy seems good to me.
> >=20
>=20
> Can I push the V4 patches of I2C controller driver now? or you just want
> an I3C driver that is compatible with the I2C controller?

If the V4 series does not use the "mediatek,share-i3c" binding anymore,
please resend it. From what I recall, it should be OK then.

> According to our plan, I2C controller will use
> i2c-mt65xx.c(kernel/drivers/i2c/busses/)and I3C controller will use
> i3c-xxx.c(kernel/drivers/i3c/master/)

Sounds OK from what I understood. The I2C fallback from I3C will be
interesting.


--k2kejit4druie2cz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxsBCgACgkQFA3kzBSg
KbaQMA//RJ3BJa9WaL2VJq/24hYu8KHYFLR8oSwjgTCVTU5CEx/wuhF9Aw06Zntr
WkkM9aCiuqmp2J2WdtYjAHZoaKybFrvF4ktxWQ/iaopO1MHWBFoF4ZbOlKlTiO6s
bT/LA2xCHrc2iDdmgTTNJm9EzAWag9oqx1GYUjwYmMGuwz3H+buaCztv0OKJLz7F
jD5GQTAd1NfDFU+FSM+SAzcSTpI4rIEMr3V6wgGELwmpzS2Tg9MlZIoAcfwvIKyT
gGTlX+nwqQuM1x1NmCsoc8zi2feG32yFbQJg+7lihFMGLsqwbyBVXDY7IBhWuDwG
DWU1+KxNRUsNb5J1HGU/31EfVp4vdaQnZ0yHHx9LRwTcYSJgkXK+tHrfquH+5SQ7
fEbTLai903NE/2E2/OCZ3fJA0uuiwwhr7nVh9SDhFlglFUnmb2YuLZl9OKhtKTss
Fis7vn51hOLOOe3BAY1QFab8/MZ8gBG6/kxaKsf1X5PMXT3CVICGDLerIjFYSqa9
XajG/uYjvOvJWfT400Kkbh/xmXnQg+7TDeohwFvqgwVe32d+3iV4rFxDOklQYGms
VVT9Ahq82ZCjUoj4+21q0B1mI+5E6FwSh83u6ATe0aUD01vwlrsbnd9P3MlGtLeM
Rw86N9PlDnLbaG08s/74s/tJ98/f9ykiH5XelxbdXnfdY20GeUA=
=Bofb
-----END PGP SIGNATURE-----

--k2kejit4druie2cz--


--===============2657901014486394359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2657901014486394359==--

