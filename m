Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7998BC41518
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:51:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3EB218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iWJcjSeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3EB218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P8t2ImDabrBkUefGqzU338Z3fGGDxO+379CpzuR4Epc=; b=iWJcjSeXriH1TJbq/CILpj6AX
	gn6AYSd5VlDjCTn8DIrpV0XeTQDEqI7DKgXryMpcduamx7BMwWmluuR5CA7uVHd/rmyzKOUC2S+Yf
	0jZgkxKY23FUki5r3TMW428xMpSEgGefanZzzkKR+uM32bF+2+85Rkacuuq8kMaD68U0+msvCNgBV
	vQDa9EvFaAT0QEalEBa7ogpNaUwQELosVCwXtyeo/nrslUeLsbAo5r3PD5To2zYdklSSyydz2yqk1
	O3WkK/ebgLeKj52amMdExPJpH5obih5fF8k5okqfWFFIHWtv5Vyr8mJfYBcl/gcz1ziUhUIDTMQK9
	bEt54VOyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn3lC-0004xO-Gh; Fri, 25 Jan 2019 15:51:14 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn3l8-0004ws-DQ
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 15:51:12 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A2F1020712; Fri, 25 Jan 2019 16:51:08 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7253C206A6;
 Fri, 25 Jan 2019 16:51:08 +0100 (CET)
Date: Fri, 25 Jan 2019 16:51:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
Message-ID: <20190125155108.op45cqrlssz6rw3t@flea>
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <20190121095014.b6iq5dubfi7x2pi4@flea>
 <CAGb2v66d0wM8Yt2uS4MMhU6PP02h8CKwKjinasO6jtZ4ue1CAQ@mail.gmail.com>
 <2800701.S2xdS7azMu@jernej-laptop>
 <CAGb2v66wm3ZVjHxqBvU1EgBjj3Dn9keyG8jGrdiiXEFa_HD2kg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v66wm3ZVjHxqBvU1EgBjj3Dn9keyG8jGrdiiXEFa_HD2kg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_075110_728070_B5FDA936 
X-CRM114-Status: GOOD (  38.30  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============6033447098573644705=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6033447098573644705==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xwltb647jb4hlhfl"
Content-Disposition: inline


--xwltb647jb4hlhfl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 10:49:58AM +0800, Chen-Yu Tsai wrote:
> On Fri, Jan 25, 2019 at 2:57 AM Jernej =C5=A0krabec <jernej.skrabec@siol.=
net> wrote:
> >
> > Dne ponedeljek, 21. januar 2019 ob 10:57:57 CET je Chen-Yu Tsai napisal=
(a):
> > > On Mon, Jan 21, 2019 at 5:50 PM Maxime Ripard <maxime.ripard@bootlin.=
com>
> > wrote:
> > > > Hi,
> > > >
> > > > I'm a bit late to the party, sorry for that.
> > > >
> > > > On Sat, Jan 12, 2019 at 09:56:11AM +0800, Chen-Yu Tsai wrote:
> > > > > On Sat, Jan 12, 2019 at 1:30 AM Jernej Skrabec <jernej.skrabec@si=
ol.net>
> > wrote:
> > > > > > A64 IR is compatible with A13, so add A64 compatible with A13 a=
s a
> > > > > > fallback.
> > > > >
> > > > > We ask people to add the SoC-specific compatible as a contigency,
> > > > > in case things turn out to be not so "compatible".
> > > > >
> > > > > To be consistent with all the other SoCs and other peripherals,
> > > > > unless you already spotted a "compatible" difference in the
> > > > > hardware, i.e. the hardware isn't completely the same, this
> > > > > patch isn't needed. On the other hand, if you did, please mention
> > > > > the differences in the commit log.
> > > >
> > > > Even if we don't spot things, since we have the stable DT now, if we
> > > > ever had that compatible in the DT from day 1, it's much easier to
> > > > deal with.
> > > >
> > > > I'd really like to have that pattern for all the IPs even if we did=
n't
> > > > spot any issue, since we can't really say that the datasheet are
> > > > complete, and one can always make a mistake and overlook something.
> > > >
> > > > I'm fine with this version, and can apply it as is if we all agree.
> > >
> > > I'm OK with having the fallback compatible. I'm just pointing out
> > > that there are and will be a whole bunch of them, and we don't need
> > > to document all of them unless we are actually doing something to
> > > support them.
> > >
> > > On the other hand, the compatible string situation for IR needs a
> > > bit of cleaning up at the moment. Right now we have sun4i-a10 and
> > > sun5i-a13. As Jernej pointed out, the A13's register definition is
> > > different from A64 (or any other SoCs later than sun6i). So we need
> > > someone with an A10s/A13 device that has IR to test it and see if
> > > the driver or the manual is wrong, and we'd likely add a compatible
> > > for the A20.
> > >
> > > Also, the earlier SoCs (A10/sun5i/A20) have IR TX capability. This
> > > was lost in A31, and also all of sun8i / sun50i. So we're going to
> > > need to add an A31 compatible that all later platforms would need
> > > to switch to.
> >
> > Actually, A13 also doesn't have IR TX capability. So I still think it's=
 best
> > having A13 compatible as a fallback and not A31. Unless A31 was released
> > before A13?
>=20
> No, but the A31 IR receiver has some additional bits in the FIFO control
> and status registers, as well as the config register (which controls
> sampling parameters). Looks like the A31 has an improved version. That
> would make it backward compatible, if not for the fact that the FIFO
> level bits are at a different offset, which might have been moved to
> make way for the extra bits. That would make them incompatible. But
> this should really be tested.
>=20
> So the fallback compatible should be the A31's, not the A13's.
>=20
> The A64's looks like the same hardware as the A31, with two extra bits:
>=20
>   - CGPO: register 0x00, bit offset 8. Controls output level of
>           "non-existing" TX pin
>=20
>   - DRQ_EN: register 0x2c, bit offset 5. Controls DRQ usage for DMA.
>             Not really useful as there isn't a DMA request line for
>             the hardware.
>=20
> Both bits are also togglable on the A31, but since actual hardware
> don't support these two features, I think we can ignore them.
>
> So it looks like for the A64 has the same IP block as the A31, in
> which case we won't need the per-SoC compatible as we've done the
> work to compare them.
>
> Maxime, what do you think?

Even though no hardware support those two features, I'd really prefer
to have an A64 compatible in addition to the A31's in the DT to be
future proof and being able to deal nicely with backward
compatibility. But of course, the driver can only use the A31 for now.

> And do you guys have any A10s/A13 hardware to test the FIFO level
> bits?

I don't think I have one with an IR receiver

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xwltb647jb4hlhfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEswbAAKCRDj7w1vZxhR
xTyeAQDnto6b9Er60BNXnIZMBEE23YGEyMhchSzYuHnBoQE5IAEA07vBJ+Wug7km
Z6GF5O5DpQTukNztjEXjk0znLD3+IA4=
=0mrN
-----END PGP SIGNATURE-----

--xwltb647jb4hlhfl--


--===============6033447098573644705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6033447098573644705==--

