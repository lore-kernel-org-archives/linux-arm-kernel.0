Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1971FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:03:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36002190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l38YrdgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36002190C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6Rt/VFJnkfmkJ81b7VDiQSpNK9ZTRknUgaosG3ybIfI=; b=l38YrdgJ4n/YDbdCi5OK+m2d/
	9DTiQ+EBBhv2jMb/ODLdxUmrmPR4W+LqgQK6WLYTKlGBBohyHtaYIkOoA/Bp7HLYlyjNq0Z6xFng4
	AULfmFNhmX6uMOXxOVSZi5tIWTMcTd8XwAk3+asbl9yjjRxgy+cXw28CVODpJ8jg7aCwm0rQ7f/X8
	8eDEEilgqqYLl6Q/DreyuYk1Qr2GujR63z16CzelybpuzSfpweQ5io1EXORNFICTV53JEmIb2pPG9
	84xgTum0TOPKONmroSFhb+usEJrXVcrp3WuF/CRNRCFxnyJdf3EfwBxcdqSbBeq46y2dXs8jwMtHh
	ibje9mugg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZOf-0002sN-Oq; Fri, 15 Feb 2019 09:03:01 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZOc-0002rt-OF; Fri, 15 Feb 2019 09:03:00 +0000
Received: from localhost (unknown [83.221.228.209])
 by pokefinder.org (Postfix) with ESMTPSA id E354F2E3551;
 Fri, 15 Feb 2019 10:02:57 +0100 (CET)
Date: Fri, 15 Feb 2019 10:02:57 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190215090257.geumssb2cucs7rzt@ninjato>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
 <20190205131641.GF12401@kunai>
 <1550109268.30065.13.camel@mhfsdcap03>
MIME-Version: 1.0
In-Reply-To: <1550109268.30065.13.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_010258_941185_D6175B83 
X-CRM114-Status: GOOD (  14.25  )
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
Content-Type: multipart/mixed; boundary="===============4225351234860739266=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4225351234860739266==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pzwi6i3t3hyzmfbc"
Content-Disposition: inline


--pzwi6i3t3hyzmfbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 09:54:28AM +0800, Qii Wang wrote:
> On Tue, 2019-02-05 at 14:16 +0100, Wolfram Sang wrote:
> > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> >=20
> > I am not happy with this binding. There must be a better way of using
> > the I3C controller in I2C mode. I think it would be easier to tell if we
> > had an I3C driver to see how it implements I2C fallback there. Is the
> > I3C driver on the way?
> >=20
>=20
> I am very sorry for the late reply due to the Chinese New Year holiday.

No worries. I hope you enjoyed the holidays!

> After confirmation, for I2C mode in I3C controller, we will push an I3C
> driver to implement I2C fallback there later, and we will remove
> "mediatek,share-i3c" for i2c controller driver in the next patch.

The problem with DT bindings is that you need to support them forever
once you introduced them. Because there might be old device trees on
boards out there which need the property. So, I don't like the idea of
having a temporary binding which is meant to be removed anyway. My take
is that you should just send out the I3C driver which will handle the
I2C support then.

Adding Rob to CC in case he has a different opinion.


--pzwi6i3t3hyzmfbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmgEEACgkQFA3kzBSg
KbaYzQ/9GMVjiYKg0Awt5r1WZ23GftvsUaudHFYCqO3OuZ4iTC3cHFAvYIDxsUKh
1L/HNEup5EICTXVUe6AoFPe6MFyC4w8e7/00n2Nsj9mfTUFjaR/2DcRWqrR0kv4T
x48s/UmUVhe8PtRT7AbX3aKkA/Jm6puhFHPCjpaLaDX20mw35B/hLIJ7lkqmpce0
fN1R2Vuo2xGHueDHv4MBbtsTC4wcOTfPVJwNVfd6nOoDOhQX+UyAqYJyoQ8exaJM
QmCfPea170F4Ov6fLgrGilWqwiN9EQDbudmlZA8vt0dflDMG+Awt5rFgEpvfKlj0
Zndw5Kwi1NCCH6b4P/GcUOaTKcrNwwA7b7/A4/dQTIVcAx/WXM+ibKY7ZQz3mfAg
LgswXBgkDL3jx3gLjHWtYjc39KVzROIBed24BIX80F1G7tfvkkhshm9KJ7gi4yks
NA2CSlS4Ufgqb0LVgRGK7e6LEFVoBL4kMlMutSToiWdrwB1tJAdWj8F986EB4v9t
5BzNW9pjN922TqY0k2gtrhFcFGyeb1BP9rvobMaFHLLt31hCIp4gkuWln7TjMFtD
LiHknLpKMjHUUd4jib/5RRnXtIAmSh7dag/5zM3m7m+Jx4T2k8E5MCQ9eI4ZlGfm
Rw2Pno7LzRHIeS5oZBAVt2n4U2gfl/okiqdkP0d9kMF1z5vbduY=
=A+6v
-----END PGP SIGNATURE-----

--pzwi6i3t3hyzmfbc--


--===============4225351234860739266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4225351234860739266==--

