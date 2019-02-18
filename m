Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C76C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:33:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358ED2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mO6ydJDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358ED2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EhRHzVkb0WSvdeezp/hM8/FFkqz2XFCiOR+B5yEaBfk=; b=mO6ydJDjCncwQs7qtu3lYR0is
	AICwYnxIG/2p7zJ6cYoSNMB1iYkCak7so3TYh3DkbZb2/Fhf5pBhCXWQ7mtV/OA/YOobDwPqG4/yg
	ck9Lt2+dD68Ou2+QSnROnf/WKA/6+QUePOUk3BMx9EobU+Vgj5A9X+Cahr/bfvHTLY5lHxojDGO4p
	O0hnKXhFMOjGIHvXWw8chMNUrV7KnrQ3B7HiLZxDZ2af+9o3BJv0R1muOiu1vHXe6Bi/OZgv/Bj+E
	0xnZu1OO3gSYURIZr4FIyyLwfaWv6cvIQB4K8AQY3E+GJR1q5Nc79LEniL/Z0T0h9kcHgloi3BAGi
	UaBB8LD/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfJ5-0001qs-Mp; Mon, 18 Feb 2019 09:33:47 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfJ1-0001pa-Vq
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:33:46 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7EBB3E000E;
 Mon, 18 Feb 2019 09:33:40 +0000 (UTC)
Date: Mon, 18 Feb 2019 10:33:40 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
Message-ID: <20190218093340.jcggm7jplpwrogsv@flea>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
 <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea>
 <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
 <CAEExFWv_K_07e30dgPbafVhDD_smwZkpi6Fqk6yzCahesdnrGg@mail.gmail.com>
 <20190215135613.sdz56vtiawqeryi5@flea>
 <CAEExFWt84MmpoWeibVf4bBJXOuPy9P7RrAFmEx304zz5z1GHwQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEExFWt84MmpoWeibVf4bBJXOuPy9P7RrAFmEx304zz5z1GHwQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_013344_178741_38F74334 
X-CRM114-Status: GOOD (  19.50  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============2108757960132993587=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2108757960132993587==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i5c56aqsedye5nda"
Content-Disposition: inline


--i5c56aqsedye5nda
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 15, 2019 at 10:09:51PM +0800, Frank Lee wrote:
> On Fri, Feb 15, 2019 at 9:56 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > Hi
> >
> > On Fri, Feb 15, 2019 at 12:56:03AM +0800, Frank Lee wrote:
> > > How about to implement a thermal driver that is not integrated with
> > > gpadc =EF=BC=9F
> > >
> > > GPADC on soc is rarely used now.
> >
> > You mean GPADC in general, or the gpadc driver in particular?
> > Otherwise, yes, having a driver for the thermal sensor in the H6
> > sounds like a good plan for thermal throttling, but I don't see it as
> > a dependency for that whole series.
>
> At present, sunxi's thermal driver is integrated with the gpadc driver.
> I have a idea to implement the thermal driver alone. I haven't started ye=
t,
> and it may take a while to do it.
>=20
> How about the plan to implement a thermal drive alone and put i
> under drivers/thermal?

The Thermal Sensor is basically a stripped down GPADC, which is why it
would make sense to have a single driver.

There was a pending series doing this that could be a good idea to
improve and merge:
https://lkml.org/lkml/2018/8/30/729

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--i5c56aqsedye5nda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGp78wAKCRDj7w1vZxhR
xYT8AQDFxHvCKmLk+1YErRAvdFGGHBrdOrKxpjtJeofe/lDUvQD/Uhgp577MmwWQ
kR6nS3Mly0LqyrhHUlvweeyb6jR+zw8=
=qt/e
-----END PGP SIGNATURE-----

--i5c56aqsedye5nda--


--===============2108757960132993587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2108757960132993587==--

