Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CD5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:39:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBB220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OAMbPbsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBB220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=btIjbXs+6x6nRtwIokGuIZSs3Q6mvkxHsHa6tiijKVY=; b=OAMbPbsvw8WazXWAEUYQygY5J
	BiHSjtrp4yaVb8qjQv3PkQGRLCLmT4DF+W62tvk4k1nzo7LT0uA3Is1oNs2Tkt6dzD0gSOLlE9wVT
	j2fTGVStvz2XQP6Y4slLB9AbS5zTkMNc0u2kUDoCaGT8obBLijrFwnWrmyCWD4UXjdAbHI0L9GygR
	gNeXXpoGvT46VVXlnw+ZB+Kh6+vgFYkLpBvxYJWQyZaiVIsc/Kta5s84Mfjl9czj55UoVG+fLP9+W
	o/PBRUVyERA+4jsPID5JoTgT0QrV4jYId2NUvQyzKLUv9RoSNzgVCD9jEsxJuAi3frLAtyf3rbTmP
	UU2w3/j8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkCZd-0000Wv-42; Thu, 17 Jan 2019 18:39:29 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkCZY-0000WV-7d
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 18:39:26 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8E1AB20A85; Thu, 17 Jan 2019 19:39:22 +0100 (CET)
Received: from localhost (unknown [212.81.177.10])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3A97F20717;
 Thu, 17 Jan 2019 19:39:12 +0100 (CET)
Date: Thu, 17 Jan 2019 12:33:40 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [linux-sunxi] Re: HDMI/DVI spurious failure
Message-ID: <20190117113340.ydszal5c3nlrqr47@flea>
References: <20190114132934.rywqqtjarbf6fgcr@plaes.org>
 <20190115094951.e7jnjpibj5tcp5pz@flea>
 <20190116075854.o2kme5nxq5kckwem@plaes.org>
 <20190116192442.qz4xi2ky6axgiyvg@flea>
 <20190116203516.s7pisy4miaclo63u@plaes.org>
MIME-Version: 1.0
In-Reply-To: <20190116203516.s7pisy4miaclo63u@plaes.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_103924_547694_9C55C87C 
X-CRM114-Status: GOOD (  25.12  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
 Chen-Yu Tsai <wens@csie.org>, Jonathan Liu <net147@gmail.com>,
 dri-devel@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0277985398309222821=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0277985398309222821==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z7fpevo4jcnqrmxs"
Content-Disposition: inline


--z7fpevo4jcnqrmxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 08:35:16PM +0000, Priit Laes wrote:
> On Wed, Jan 16, 2019 at 08:24:42PM +0100, Maxime Ripard wrote:
> > Hi Priit,
> >=20
> > On Wed, Jan 16, 2019 at 07:58:54AM +0000, Priit Laes wrote:
> > > > On Mon, Jan 14, 2019 at 01:29:34PM +0000, Priit Laes wrote:
> > > > > I have a somewhat curious case with one HDMI/DVI screen that fails
> > > > > to initialize properly every 6-7 boots. The display itself is also
> > > > > somewhat flawed (missing HPD pin and the VSYNC/HSYNC pulse width
> > > > > is set to 0 in EDID), but I suspect there could be some issues
> > > > > regarding timing in A20 HDMI driver in Linux.
> > > > >=20
> > > ...
> > >=20
> > > > It doesn't look related to the clock rate itself, since it doesn't
> > > > change between the two cases. However, in one case the DDC clock is
> > > > enabled and in the other it's disabled.
> > > >=20
> > > > Was it taken at the same time? Maybe you can try with that patch?
> > > > http://code.bulix.org/z7jmkm-555344?raw
> > >=20
> > > Thanks, after doing ~50+ boots I haven't seen a single failure.
> > >=20
> > > Previously I had following failure cases which are now both fixed:
> > >=20
> > > a) Linux without u-boot HDMI, where one in every 6-7 boots failed.
> > > b) u--boot with hdmi enabled switching to simplefb and then switching
> > > to kms, where previously all boots ended up with garbled screen.
> >=20
> > So it's not really a fix, but it really looks like the clock is not
> > enabled when it should.
> >=20
> > Can you describe your test scenario a bit more? What are you doing
> > exactly, just booting? When do you start using the display? When did
> > you capture the debugfs output that you pasted?
>=20
> Display is already connected via HDMI to the board. I don't really
> remove it, I just boot the device and let it start Xorg.
> Meanwhile I just ssh into the device and capture debugfs output.
> See my 3 testing scenarios below.
>=20
> Kernel also includes one extra patch to fall back to DDC, in case HPD
> fails. Mostly the same I already submitted last November [1].

Do you have the same issue without that patch?

> For u-boot I have also some extra patches, to detect HPD-less HDMI
> displays [2] + relax some EDID timing checks [3] so u-boot can actually
> initialize my screen.

Do you have the same issues without those patches?

> So first configuration with 100% failures:
> 1) u-boot initializes HDMI ( A20-OLinuXino-Lime2-eMMC_defconfig )
> 2) Linux switches to simplefb
> ... somewhere around here blinking cursor is replaced with garbage
> on screen=20
> 3) Linux switches to kms
> 4) Xorg starts
>=20
> Second scenario with failure every 6-7 boots:
> 1) Disabled HDMI in u-boot for my board
> 2) Linux sets up kms (sometimes fails here)
> 3) Xorg starts
> 4) ssh to machine and take the clock dump

Do you have the DRM fbdev emulation enabled in that case or is Xorg
the first to setup the kms driver? Do you have some logs and a
configuration?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--z7fpevo4jcnqrmxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEBoFAAKCRDj7w1vZxhR
xcEqAP9tLEyots8XmcR9FUaKs8sWpv4r/K5KHR8X07/mi/ocrAD9FlUmq6JLGP2G
c4w+aSexRL82eURQjwQvfMr7pgPJrgI=
=71gA
-----END PGP SIGNATURE-----

--z7fpevo4jcnqrmxs--


--===============0277985398309222821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0277985398309222821==--

