Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29E9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:14:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8066F2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nqabo3ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8066F2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=saRMwEMH2WRNwTQ0dQrL7S5i3qcVVMSIj45LYdz4Bas=; b=Nqabo3htBS84ZSn7lbIVuMiTt
	hSFnQ99kssxhoYwmfQozYRN/jbFBzQkS98Q5j092LqQ5/8s6VZUKTr/KX7/59YuNxODto2LG9/Gei
	h+R3NGKioSCKxBp3mlLBdhHiz44/RkM9/R1/NoaaMYQrLxfNvURLvKMptfbG29X8Fi/Y2n81uwPEW
	JBJCMXgmOpAKuvNibyfXk6vLjU7ZM4vCoJVWQWjFe638EzU7IGjfpii+YE7uRtEr1pGaSTbLNwWrV
	xCEdDnxHjzVCR1+wtn4sH+VU7QlaqdZY80p8qBUEJleGzUCoQI4LfTm1qvkPVk2ik7vmrNDO/00/4
	kjRpJ580A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufBo-00028W-BC; Fri, 15 Feb 2019 15:14:08 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufBl-00027d-BC
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:14:07 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B62A0FF80E;
 Fri, 15 Feb 2019 15:13:57 +0000 (UTC)
Date: Fri, 15 Feb 2019 16:13:57 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATVH v2 0/4] arm64: dts: allwinner: h6: Enable CPU
Message-ID: <20190215151357.noovkx3r6ia4boag@flea>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190215134937.10259-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_071405_527061_3BC8A6BC 
X-CRM114-Status: UNSURE (   9.79  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7177603966821102959=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7177603966821102959==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="om2f4swtpe4optgl"
Content-Disposition: inline


--om2f4swtpe4optgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 08:49:33AM -0500, Yangtao Li wrote:
> Add the cpufreq support of h6, source of information is as follows.
>=20
> h6 cpu opp info:
> https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm6=
4/boot/dts/sunxi/sun50iw6p1.dtsi
>=20
> axp805 spec:
> http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf

Was that tested on the two H6 boards this time?

Adding a changelog between version is nice as well so that we can see
what you changed.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--om2f4swtpe4optgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGbXNQAKCRDj7w1vZxhR
xYxkAP9kUMkZaTrK23zivcyuBxMBvnEttPQW5ZUNNelMTWvr5wD/Vg6TAuWXUOQ8
6NQLJne5OBfdUYosfymIYyMamN2pMwY=
=Uep5
-----END PGP SIGNATURE-----

--om2f4swtpe4optgl--


--===============7177603966821102959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7177603966821102959==--

