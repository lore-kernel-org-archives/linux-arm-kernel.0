Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800D7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:21:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDA82064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YPygWT1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDA82064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6/dHRJgPs24Nq0CPItKjD+5ymeUtGRyFtXo4hAGLy8s=; b=YPygWT1yBg3FCRv6ewSReA7uR
	jb6aVvll2qN7IiRUFmo6JDDMT1EF71oCi+ssBF3QrDex51S/PrbpvVd33QKqkjtsMiHVrUeLPF2O8
	WvPbDlh1eN8ZdzoPPBTrTu8YDKQD8JWPP6WUpz3Mf0m1Wqdj5S/aQKEvbm+tdfGws7CKLV20hq7iw
	HxBOYjZ95IIJ/zFbF+7uvOgb5237A/W5CriWoH6J9Jqk0+kM5m4glaKtAldgfiiOo+kcZQhpNSMtQ
	WLC2HTQNIdA898NKmUDDJkizRky4R38mr5odROTZpa8D6pkK9uyGsNHKbISrsmV9ocll5mIujapVg
	tWyXeXI0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghAzY-0003ug-Ff; Wed, 09 Jan 2019 10:21:44 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghAzV-0003uI-7D
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:21:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1F2F020898; Wed,  9 Jan 2019 11:21:40 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr
 [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id AD9D120A1D;
 Wed,  9 Jan 2019 11:20:49 +0100 (CET)
Date: Wed, 9 Jan 2019 11:20:49 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
Message-ID: <20190109102049.npk77pxtxru4tcyb@flea>
References: <20190108191840.16007-1-jernej.skrabec@siol.net>
 <20190109101228.alsaaw6s57dbapfe@flea>
 <CAGb2v64QM9gyPTtpw0C0fpANW5R9DEsWFSDA_tJPYhdgF_FAhQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v64QM9gyPTtpw0C0fpANW5R9DEsWFSDA_tJPYhdgF_FAhQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_022141_391911_F410D933 
X-CRM114-Status: GOOD (  14.82  )
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
 Jernej Skrabec <jernej.skrabec@siol.net>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5250113941214597712=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5250113941214597712==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mkj2k5z2j34krmbx"
Content-Disposition: inline


--mkj2k5z2j34krmbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 06:13:24PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jan 9, 2019 at 6:12 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Tue, Jan 08, 2019 at 08:18:40PM +0100, Jernej Skrabec wrote:
> > > Because "ethernet0" alias is missing, U-Boot doesn't generate board
> > > specific MAC address. Effect of this is random MAC address every boot
> > > and thus new IP address is assigned to the board.
> > >
> > > Fix this by adding alias.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > Applied, thanks!
> > Maxime
>=20
> Might we add a fixes tag, so the patch gets backported?

It's done, thanks for the suggestion!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mkj2k5z2j34krmbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDXLAQAKCRDj7w1vZxhR
xRhyAQDIcRHuTOixnaioB3IrRwVWG+S5j6m/zbAtmcJ3832tCgEAroU7bsx43+oL
M10O81HgPW+/7Us9jOpc86koW4FV/A4=
=JI+r
-----END PGP SIGNATURE-----

--mkj2k5z2j34krmbx--


--===============5250113941214597712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5250113941214597712==--

