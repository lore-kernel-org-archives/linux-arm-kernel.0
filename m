Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5193FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:06:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1497F21783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b7D8Hx7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1497F21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xRq4I3fgSPPjaLKjp8imxwU9Gq3nSKKYVFUaqokc7pg=; b=b7D8Hx7w9KJWCNKQa6lviEtjB
	gBuBS/HxGGeD/hX1aVEVo0J73bfZOYhVICf4VVVBSGuhbOkS6/SFVFAMWRv+7A1am1ldKi4Rnjx/6
	xPtf5QF6s024GiCd1cYuPQLFEXQPZrNYtzPjAjHp0wLEkKeZg0w26SkUiC6GXxrJrOSzzkP2Hituk
	V6/Ua7FGC0JJ+/2Cb7m40+4OXQVI06Q6E1EWAhDaRqtgxrBx0xqlkZFhOuAXj9+Ery/XjpzWgxAAg
	utE+7Ax11YVglypEZZUG3fn9alsEDjRscF0qXdjAwBXY4rj8hSY+imCAzoGH+xA7FvE1aUgndxmsX
	dR2I7yQuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ1yJ-0003xu-Ga; Mon, 17 Dec 2018 23:06:47 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ1yF-0003x8-ML; Mon, 17 Dec 2018 23:06:45 +0000
Received: from localhost (p54B3357B.dip0.t-ipconnect.de [84.179.53.123])
 by pokefinder.org (Postfix) with ESMTPSA id BE1512E3656;
 Tue, 18 Dec 2018 00:06:29 +0100 (CET)
Date: Tue, 18 Dec 2018 00:06:29 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20181217230629.i7i3kbreurgt7u73@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
 <20181211202931.xav4gzi7rzh2scgx@ninjato>
 <1544693547.11699.40.camel@mhfsdcap03>
MIME-Version: 1.0
In-Reply-To: <1544693547.11699.40.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_150643_876532_ABFFC35E 
X-CRM114-Status: UNSURE (   9.05  )
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
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1765357498413480999=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1765357498413480999==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gph3bc2aynqejfb4"
Content-Disposition: inline


--gph3bc2aynqejfb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > What is "multi-user"? Why can't you add this offset to the reg-property
> > directly?

=2E..

> MT8183 doesn't need to support muti-user according to the latest project
> information, and I'll remove this feature from patches.

Okay. It will be dropped then, thanks for the heads up!

> > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> >=20
> > Please explain in more detail? Is this an I3C controller?
>=20
> Yes, it is a i3c controller, and it is compatible with i2c. I only use
> the feature of i2c, so I need a flag to do some extra settings.

Can't you derive this from the compatible? If it is
"mediatek,mt8183-i2c", then you know you need these extra settings?


--gph3bc2aynqejfb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwYK/UACgkQFA3kzBSg
Kbae4A/+MilZ2mxtZBN5/KQAX4PI8TwMRQpdfTOFfHZL1U1qxKqJm5ojSZvI3Dle
BxpSYHyWhFGblcmMckmfTHFSVfPu12UB7ma0h3A/h/6gXTemtuS1LXMolzhA6rIx
ShCNSsmji6Wk4AH0Bjok+uaO+0dP6SzWX978UmQdNPRAXg12Txf39t8cFzdwkh6t
/kN6UcNP9aUgVXASp/FXlDfGUQEQvN5opoae8JzBJYvmO7/hbECqRykVlQ1S5p4e
cwuRjPohrvKGkAwvWuyL7IoZVFotwtd9NEFE56xpykuDKMHstnmqbUS9vYKboWmZ
oLA0B075zO/iAYhAjKmbD25NAGGIucaTXpB0OsgRdRuQMs6K0rdyUZ9j81iry27N
zU5wKtoim8klrsgqQTHu+pZ1gYYgKP+M0lu7Hc1P4AYGE/qiEx4KSTX8ZBB7xXPm
JndAI+ElJracuCTvxDBPZfx5YlQnqOngKwGSwLInVGClA3sm7gRZu8TY8/5jlx7r
f8evwPSN6A7bSTSLJi5RbKe9PkmXA3XFMa7FWamrluxeVdf1jAmXC39VAF+mIvVi
ncoTmAmoVIo88lSX7qUNjZVGS6syFgQ3WYZ6lxu0b7lbx7j2PggOZl2l3dc9d+vP
GbV9jZYhcSF/57+zDFY0TIvfKT/JxyU9FZCuEHTdGcS3zosRL4E=
=FiE4
-----END PGP SIGNATURE-----

--gph3bc2aynqejfb4--


--===============1765357498413480999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1765357498413480999==--

