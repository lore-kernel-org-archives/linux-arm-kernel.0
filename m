Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D07C2F3A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:25:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99FB2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WEbneVjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99FB2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jq3x5IRjqlh9gssh3HcOrIZb2+xuwnvlm3nfDwm6ewA=; b=WEbneVjAl9pQiyittGaZa/IVF
	JVQYHs/0FxcLp+4eOQe38+ZqAxnkRadr1Vr5C3cDLhR5EGOJrtZeCJ9WyI2rFmzefmH5vm3X2vaF5
	ZZSUvFU3AyQzECh09bKVTfbpiJ5WTQCSwNqyA/Y8UrkPf4SCZc2IEIT8wiATffLAELKGAxMMlTSmG
	LPBjMKpwoM7inTPt5lBoMokQvC0ViB0/UxnaKMZ26J84jUkqp+X6mtfe6x4fSNIz6dyH8ec4ABxWD
	7vEpgijFQtpyVnNNwROSfJC3B77hcEIeobdXSpLPukZ6h0GVmoVGb1k+PU8Xox8+jM8wNt+tY47uT
	Sso5CR8bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZa0-0007pV-7Q; Mon, 21 Jan 2019 13:25:32 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZZx-0007pB-EO
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:25:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1E4B4207B2; Mon, 21 Jan 2019 14:25:27 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id CACA12078C;
 Mon, 21 Jan 2019 14:25:16 +0100 (CET)
Date: Mon, 21 Jan 2019 14:25:17 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [linux-sunxi] Re: HDMI/DVI spurious failure
Message-ID: <20190121132517.iv2v3hug4uihefnk@flea>
References: <20190114132934.rywqqtjarbf6fgcr@plaes.org>
 <20190115094951.e7jnjpibj5tcp5pz@flea>
 <20190116075854.o2kme5nxq5kckwem@plaes.org>
 <20190116192442.qz4xi2ky6axgiyvg@flea>
 <20190116203516.s7pisy4miaclo63u@plaes.org>
 <20190117113340.ydszal5c3nlrqr47@flea>
 <20190118101053.gkxpfymsjzw3ptxf@plaes.org>
 <20190118140418.m5mliyvddfdfju3v@flea>
 <20190118145126.mpjz5t5hjqqpgzys@plaes.org>
MIME-Version: 1.0
In-Reply-To: <20190118145126.mpjz5t5hjqqpgzys@plaes.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_052529_754301_5E04B0DA 
X-CRM114-Status: GOOD (  26.18  )
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
Content-Type: multipart/mixed; boundary="===============4352959909304121907=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4352959909304121907==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pwfuitnpzretg3l6"
Content-Disposition: inline


--pwfuitnpzretg3l6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 02:51:26PM +0000, Priit Laes wrote:
> On Fri, Jan 18, 2019 at 03:04:18PM +0100, Maxime Ripard wrote:
> > On Fri, Jan 18, 2019 at 10:10:53AM +0000, Priit Laes wrote:
> > > > > > > > It doesn't look related to the clock rate itself, since it =
doesn't
> > > > > > > > change between the two cases. However, in one case the DDC =
clock is
> > > > > > > > enabled and in the other it's disabled.
> > > > > > > >=20
> > > > > > > > Was it taken at the same time? Maybe you can try with that =
patch?
> > > > > > > > http://code.bulix.org/z7jmkm-555344?raw
> > > > > > >=20
> > > > > > > Thanks, after doing ~50+ boots I haven't seen a single failur=
e.
> > > > > > >=20
> > > > > > > Previously I had following failure cases which are now both f=
ixed:
> > > > > > >=20
> > > > > > > a) Linux without u-boot HDMI, where one in every 6-7 boots fa=
iled.
> > > > > > > b) u--boot with hdmi enabled switching to simplefb and then s=
witching
> > > > > > > to kms, where previously all boots ended up with garbled scre=
en.
> > > > > >=20
> > > > > > So it's not really a fix, but it really looks like the clock is=
 not
> > > > > > enabled when it should.
> > > > > >=20
> > > > > > Can you describe your test scenario a bit more? What are you do=
ing
> > > > > > exactly, just booting? When do you start using the display? Whe=
n did
> > > > > > you capture the debugfs output that you pasted?
> > > > >=20
> > > > > Display is already connected via HDMI to the board. I don't really
> > > > > remove it, I just boot the device and let it start Xorg.
> > > > > Meanwhile I just ssh into the device and capture debugfs output.
> > > > > See my 3 testing scenarios below.
> > > > >=20
> > > > > Kernel also includes one extra patch to fall back to DDC, in case=
 HPD
> > > > > fails. Mostly the same I already submitted last November [1].
> > > >=20
> > > > Do you have the same issue without that patch?
> > >=20
> > > Can't really test this display without this patch and I do not have o=
ther
> > > HDMI/DVI screens. And this issue does not happen with other HDMI disp=
lays
> > > that I have here.
> >=20
> > Can't you just force the monitor to be reported as present? It's not
> > great and we don't want to merge it, but that would allow you to test
> > that setup without too many interferences.
>=20
> Baseline is clean u-boot / linux. U-boot does not detect/enable display.
>=20
> 1) Booting Linux with drm.debug=3D0xe
>=20
> * Linux does not detect/enable display
>=20
> 2) Booting with drm.debug=3D0xe video=3DHDMI-A-1:640x480@60e
>=20
> * Linux detects display, but display is garbled, and proper edid data is =
detected:
>=20
> [snip]
> pll-video1                     0        0        0   327000000          0=
     0  50000
>    pll-video1-2x               0        0        0   654000000          0=
     0  50000
>       hdmi-tmds                0        0        0    25153846          0=
     0  50000
>          hdmi-ddc              0        0        0       89835          0=
     0  50000
> [/snip]
>=20
> 3) Booting with drm.debug=3D0xe video=3DHDMI-A-1:640x480@60e
> And also one extra patch for Linux where HDMI DDC clock marked as critical
>=20
> Linux detects and initializes display properly:
> [snip]
> pll-video1                     1        1        0   327000000          0=
     0  50000
>    pll-video1-2x               1        1        0   654000000          0=
     0  50000
>       hdmi-tmds                1        1        0    25153846          0=
     0  50000
>          hdmi-ddc              1        1        0       89835          0=
     0  50000
> [/snip]

I guess you'll need to track down when the hdmi-tmds and hdmi-ddc are
enabled and disabled, and if it makes sense :/

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pwfuitnpzretg3l6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEXIPQAKCRDj7w1vZxhR
xcL9AP90HKorMjZWKBoBqwq4XAdHAARaeew1QhNIgEON/f+xqwEAzD+7Pkh/RHY9
MtqiJ6wLMZsP5DEfmy/dv4x3d9lvOQw=
=JEgz
-----END PGP SIGNATURE-----

--pwfuitnpzretg3l6--


--===============4352959909304121907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4352959909304121907==--

