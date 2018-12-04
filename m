Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB18C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:18:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32C32082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HciRKVp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32C32082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5bQArr2oSfs2khStaDIY+hh8JFEyobUS090Fj6/6SjM=; b=HciRKVp2I363xapzez0aiL0Cg
	AEOTULKZ1C7Bv+GvlcWQzRWcN4Gafh5zwfcLOuR43W+r+lxe9X73YGPnMwZzBfLaaJLao9YAXATQx
	ErP7CAPsxL/7VPqDgSSiz1MlQeGhmA3CXLq5YhK5tjwodN5/l5JYGHsS17byL/Z05XdAJ4QS28HR6
	EbRvDfdWgw5bqE8xp8xdqvHHg8QnecHccM5aUB1eppTthTYgjuf0l6L2fOotU7+R0STInNK0TsYf/
	bpTW4aYdW8Ajv6ckqDtM8tRZrwJ0ebP6sbN7ger/K85tZUcQO9Yl70p2pIOgeFDrtDW0cwVvYiM70
	61t+aeG7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6qQ-0002bl-02; Tue, 04 Dec 2018 09:18:18 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6qM-0002Pt-5v
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:18:16 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6ED4520A58; Tue,  4 Dec 2018 10:18:09 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3BEAC20723;
 Tue,  4 Dec 2018 10:17:59 +0100 (CET)
Date: Tue, 4 Dec 2018 10:17:59 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 08/14] rtc: sun6i: Expose internal oscillator through
 device tree
Message-ID: <20181204091759.o5rp464qopm3ity7@flea>
References: <20181203145825.20511-1-wens@csie.org>
 <20181203145825.20511-9-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20181203145825.20511-9-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_011814_529589_247ED295 
X-CRM114-Status: GOOD (  12.85  )
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
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
 Rob Herring <robh+dt@kernel.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============6120720222606011784=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6120720222606011784==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o4zvu5pyfbvkyy7z"
Content-Disposition: inline


--o4zvu5pyfbvkyy7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 10:58:19PM +0800, Chen-Yu Tsai wrote:
> The bindings have been updated to expose the RTC's internal oscillator,
> for some SoCs that have it directly feeding the PRCM block. The changes
> include the index 2 for the clock outputs, as well as the clock output
> names.
>=20
> This patch adds the internal oscillator to the list of clocks exposed
> through of_clk_add_hw_provider(), and also have the driver optionally
> fetch the name of the clock from the device tree if it's available.
>=20
> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--o4zvu5pyfbvkyy7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAZGRwAKCRDj7w1vZxhR
xeJnAQCgRrhnfUnOJRB5h4FA60OJG9fs8U/gZvsedmR+U0ZmJAEArMLCjW37IHZm
11848ViWtwLrkbc/RnDF1LZ8o7+pJwM=
=yD68
-----END PGP SIGNATURE-----

--o4zvu5pyfbvkyy7z--


--===============6120720222606011784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6120720222606011784==--

