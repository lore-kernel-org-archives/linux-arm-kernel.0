Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97059C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:19:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662992073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="keLJfp5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662992073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R5y61YO2uHTnVqHIG993CZJi7NJDMBmmPO+DbaizlN0=; b=keLJfp5r9wizHlN9NFajwqYk2
	o8AhedbBWmzx28VFCDpReH+opS5xEXJyoJtGhetMa2hihm4B/QhxV5wBImy3ocRPp+3+g59MEf1Ab
	NJ6pV/x5+CWiEkL4BjF62BtFhklfZ2WjhahrgmFfgCoRwjHB8G396daZXCxy9/ZyVsAd05qgWF+V7
	Wlx1zRtlUyNjGHQAL5XSKP5+b0WyZGWbjtMbNHYnW4nyqL76kBhTDI4OmFE7SPi4th1F26I3FQhi3
	1wu4M7g18SbOwxDCJHRmQCd8l+1dlTs7+L6g2TQBue40+vafX2Af8pQFA3x29aBc+lGjvU2dNrg0O
	Dl6cQPOxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grMAy-0001gs-Et; Wed, 06 Feb 2019 12:19:36 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grMAt-0001eW-Hl
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 12:19:33 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5CF246000F;
 Wed,  6 Feb 2019 12:19:29 +0000 (UTC)
Date: Wed, 6 Feb 2019 13:19:28 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: a64: Enable PMIC power
 supplies on various boards
Message-ID: <20190206121928.6t2sawpqsmf6buv3@flea>
References: <20190205150040.12343-1-wens@csie.org>
 <20190205150040.12343-2-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190205150040.12343-2-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_041931_895789_DF152C5D 
X-CRM114-Status: UNSURE (   9.91  )
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0885591113632808570=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0885591113632808570==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jf7jxt6isqtwx3zl"
Content-Disposition: inline


--jf7jxt6isqtwx3zl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 11:00:40PM +0800, Chen-Yu Tsai wrote:
> On these A64 devices, the DC input jacks are wired to the ACIN pins of
> the PMIC, which is represented by the AC power supply. With the
> exception of the Nanopi A64, all devices include LiPo batteries or have
> connectors for them, which are represented by the battery power supply.
>=20
> Enable these power supplies in the device tree.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied both, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jf7jxt6isqtwx3zl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrQ0AAKCRDj7w1vZxhR
xdAKAP9fz6ckXKwqb4cq4wgG3yp4QtxUn/nRE2+12D3r4GyYuAEAnOpwyf5VId9/
6sqPb0u3JsgWuwAicwCXbsTIpiWBOw0=
=pSt1
-----END PGP SIGNATURE-----

--jf7jxt6isqtwx3zl--


--===============0885591113632808570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0885591113632808570==--

