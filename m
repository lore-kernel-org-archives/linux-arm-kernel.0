Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D72CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:06:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1A02145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="km5SY6ZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1A02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mjg9HkTWwKbi8Exvse0MgGXOjWkebFZZEKG8ZFxFwCo=; b=km5SY6ZP+GT+guJumMCaC7cAT
	YlQcSOrSBz4D5NJ0yrOsuaocJbhFs3tvLGcDIze1G0pmHSo50KR3oq8OdCoV+B8Dg0jqriSZJxNOq
	jOTtm6eslVchnvZohSRAnkuwePPeE5hVOrdbjRxGEdwb9ohG0cvltyPwYzoxwhymrMs71LEraA9j6
	LWyCqvNJK7P1Aky/czEgS+MuldYIx57yyhXTt6d/sLGv+wjZYftgWv31W4gugYOLKHVzkuc9bquo6
	h0tql9fsHcJ1HrVzlkIi2yMVFKvN37B+BJU9EiSVpDoggagdi5PZIA/mF5HIcFsXNcQZWxCby+BfW
	Bfhqx365A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtXo-00057G-5S; Mon, 17 Dec 2018 14:06:52 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtXg-000508-Lu; Mon, 17 Dec 2018 14:06:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2DC4320CE3; Mon, 17 Dec 2018 15:06:33 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id EDFE820711;
 Mon, 17 Dec 2018 15:06:22 +0100 (CET)
Date: Mon, 17 Dec 2018 15:06:23 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 0/5] phy: core: rework phy_set_mode to accept phy mode
 and submode
Message-ID: <20181217140623.2zze2kfclup7wjti@flea>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
In-Reply-To: <20181120012424.11802-1-grygorii.strashko@ti.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_060644_992432_D655C691 
X-CRM114-Status: GOOD (  23.32  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Quentin Schulz <quentin.schulz@bootlin.com>,
 Manu Gautam <mgautam@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 netdev@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>,
 Sekhar Nori <nsekhar@ti.com>, Russell King - ARM Linux <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: multipart/mixed; boundary="===============2420841942870268099=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2420841942870268099==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="553g4on6q5epsg5z"
Content-Disposition: inline


--553g4on6q5epsg5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grygorii, Kishon,

On Mon, Nov 19, 2018 at 07:24:19PM -0600, Grygorii Strashko wrote:
> Thank you for your review.
> I've not added "Tested-by"/"Acked-by" tags due to code changes in v3.
>=20
> As was discussed in [1] I'm posting series which introduces rework of
> phy_set_mode to accept phy mode and submode. I've dropped TI specific pat=
ches as
> this change is pretty big by itself.
>=20
> Patch 1 is cumulative change which refactors PHY framework code to
> support dual level PHYs mode configuration - PHY mode and PHY submode. It
> extends .set_mode() callback to support additional parameter "int submode"
> and converts all corresponding PHY drivers to support new .set_mode()
> callback declaration.
> The new extended PHY API
>  int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
> is introduced to support dual level PHYs mode configuration and existing
> phy_set_mode() API is converted to macros, so PHY framework consumers do
> not need to be changed (~21 matches).
>=20
> Patches 2-4: Add new PHY's mode to be used by Ethernet PHY interface driv=
ers or
> multipurpose PHYs like serdes and convert ocelot-serdes and mvebu-cp110-c=
omphy
> PHY drivers to use recently introduced PHY_MODE_ETHERNET and phy_set_mode=
_ext().
>=20
> Patch 5 - removes unused, ethernet specific phy modes from enum phy_mode.
>=20
> Testing:
>  - series tested on TI am335x/am437x/am5(dra7) paltforms.
>  - other driver build tested.

I realise I'm a bit late to the party, but while working on the D-PHY
support, I noticed a few things that could be improved.

I guess the main issue is that the sub-mode is completely opaque to
the generic phy framework now. This might not be a big issue, and I
assume that it has been done that way because the net framework
already has a define for the submode it wants.

However, this creates a bunch of drawbacks at the phy framework level:

 - phy_set_mode will now pass a submode of 0, all the time. This means
   that the behaviour is undefined for all the modes not using the
   submodes at the moment, and phy_interface_t seems to have the value
   PHY_INTERFACE_MODE_NA matching 0, but I guess this could change in
   the future (or the guarantee is not documented anywhere).
 - on a similar note, there's no documentation for which value to pass
   to phy_set_mode_ext when used with something else than a
   PHY_MODE_ETHERNET.
 - at the provider level, if you're supporting a phy that isn't using
   the submodes, you have no way to filter out or reject any subnode,
   since you have no idea what the "no submode" value is.

I guess this can be addressed by:

A) defining a generic phy framework wide unused / invalid phy submode,
that wouldn't collide with the subnode values (such as -1?), and
making phy_set_mode_ext use that.

B) moving the phy submodes definition to the generic phy headers. This
would allow to have a documented, obvious link between a mode and its
subnodes, for all the actors involved (consumer, provider, and
framework) without prior knowledge.

C) Document what the submodes expectations are

What do you think?
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--553g4on6q5epsg5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBetXwAKCRDj7w1vZxhR
xeUGAQCR50AQDteX+9l+EKki80/VMKbK438CYL7PPVfr3Qu84AEAjDNV9Y+LVbAp
XRC0B5OfKDq6wnecuDvlw4UyOlmKWAo=
=hd40
-----END PGP SIGNATURE-----

--553g4on6q5epsg5z--


--===============2420841942870268099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2420841942870268099==--

