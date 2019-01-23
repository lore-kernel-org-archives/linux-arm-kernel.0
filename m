Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB97C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:32:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E2920861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LtBpCeVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E2920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ijq/jshqfg30SQYaL19KlvCEYcbMLY8iEAeyPk5K0ZY=; b=LtBpCeVxoVr/1FAEnHzf1F5B6
	b6vw8Ftj9HrPYZzXgTFEHsaWIO3zxmqnokJJ68jh3WYhJpKfrAOv2o3+feNd5sgeZ4Bj08MsK+db1
	1RHgidMNDZHl1c7lYNiSjGCRBEG9Xt0NV/3PpeQLQ1Ctvp5QvcJUlMiuiFhUMtbCuQ+6kA/LS1dma
	C23br5t1Jy/eLhLf6Os7x64oLuZ7UZULvx+fDRdY9GFEOkc/xO9dzmhsb8hxTMLD0wNvVnwMStc6F
	169k5R+FLJuSuWGso/ue+eV3ZxuB2dLNhCGJUQv2aqnKFcFEZZkk8wQzT4thRVSuidWc6i5RdFVQ8
	2X6CWouEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFph-0002AC-0A; Wed, 23 Jan 2019 10:32:33 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFpd-00029o-MV
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:32:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 499D720717; Wed, 23 Jan 2019 11:32:27 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1808120397;
 Wed, 23 Jan 2019 11:32:27 +0100 (CET)
Date: Wed, 23 Jan 2019 11:32:27 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] clk: sunxi: A31: Fix wrong AHB gate number
Message-ID: <20190123103227.pejyujxred2x2h6x@flea>
References: <20190123005911.27913-1-andre.przywara@arm.com>
MIME-Version: 1.0
In-Reply-To: <20190123005911.27913-1-andre.przywara@arm.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_023229_873647_FB93E5C5 
X-CRM114-Status: UNSURE (   9.32  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-sunxi@googlegroups.com,
 Chen-Yu Tsai <wens@csie.org>, Jagan Teki <jagan@openedev.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3868523468258375411=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3868523468258375411==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vmq2rj2joai4snm7"
Content-Disposition: inline


--vmq2rj2joai4snm7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 12:59:11AM +0000, Andre Przywara wrote:
> According to the manual the gate clock for MMC3 is at bit 11, and NAND1
> is controlled by bit 12.
>=20
> Fix the gate bit definitions in the clock driver.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Added the fixes tag and applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vmq2rj2joai4snm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEhCqwAKCRDj7w1vZxhR
xYgIAP9mP7mzs528x6r/0APYY5PgzMvb7E4eoefz0Mc3VP1MNgEA5lP5abkQdjSe
Xy81X4JsgaycZbN3UgS4MoFpJplu9gA=
=DQSH
-----END PGP SIGNATURE-----

--vmq2rj2joai4snm7--


--===============3868523468258375411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3868523468258375411==--

