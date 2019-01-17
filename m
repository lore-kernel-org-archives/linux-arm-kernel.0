Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E34C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:18:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C3620856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mhav0sfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C3620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q9/vV1QOmGxMnE88HBM6VMF3jaE3O+nm2EXrKVtmpgw=; b=Mhav0sfhnL3C8A825vH2k84IA
	yi9YZEs+VupCto0WCSUYr683rmcUOZFGyKSN0hS0xq4IKKMB5m0jVpTMKU3Im9g7KdjmL6z/5rLwG
	dUvdEG78udrstovRv4gFztJ6aSCiurs7h34pcMTJhyp+YE661TNbee3OqZKQ0mCBtlzAnFbV/KQzP
	TdtXmWpMLmAd0UGgwp7PJuudUZh7nlwMo6GDyrwg1ykFfBYkos/h4eQ5ERACBDFQO2u6Iwb9TiaoD
	6PBvXENG/yURA23wmtIigSLu6YaUeEAGLtDx1ToYf9wBHE2nkMqVvzjM+iNh/W5HvRLHI/dwRS7M7
	dlQj1X2ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk8Ux-0005wT-VA; Thu, 17 Jan 2019 14:18:23 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk8Ut-0005w0-UD
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 14:18:22 +0000
Received: from localhost (p54B33243.dip0.t-ipconnect.de [84.179.50.67])
 by pokefinder.org (Postfix) with ESMTPSA id 048A82C3F83;
 Thu, 17 Jan 2019 15:18:13 +0100 (CET)
Date: Thu, 17 Jan 2019 15:18:12 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of
 SDHI3
Message-ID: <20190117141812.kvyjeja65r7e26jq@ninjato>
References: <20190110142833.31577-1-horms+renesas@verge.net.au>
 <20190117133216.sx7rqao73xy3ne7r@verge.net.au>
MIME-Version: 1.0
In-Reply-To: <20190117133216.sx7rqao73xy3ne7r@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_061820_122381_097FAA02 
X-CRM114-Status: GOOD (  11.31  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6093161093162097551=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6093161093162097551==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sd7bkl657h4vc6nw"
Content-Disposition: inline


--sd7bkl657h4vc6nw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 02:32:17PM +0100, Simon Horman wrote:
> [CC Wolfram, Niklas]
>=20
> On Thu, Jan 10, 2019 at 03:28:33PM +0100, Simon Horman wrote:
> > Add SDHI3 UHS pin control and use it when enabling HS200 support
> > for SDHI3.
> >=20
> > Based on work by Takeshi Kihara.
> >=20
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > Tested on top of renesas-devel-20190110-v5.0-rc1
>=20
> I would value a review of this patch.

Can you resend with the added CCs, please?


--sd7bkl657h4vc6nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxAjqAACgkQFA3kzBSg
KbaUpg/+P2YBrB9/z3BFTyfuIJY+KVx7a0ivXZK3TU15a7yhT8hd07j8GHvIq2HD
Yh30c8YS7DP8J7J+wLONnLt7CWdiWaz2GP/v1mMH1OgNtKqVh/ZYeWmwwJKyjeqT
uMWGFy+CwKVJFq2zWfgq1iT14dkknNo98PU379SXPluXf0/VmjdLgrUE67Fe9yVx
AaHoa+DGTYrSbXQ/z/Znw8zNDdJjFv9SVaqfkSDS6q5YxNuPj7OHjwZpmgisQ4Ns
CP+ap4UglRSA1/CM+BaTvSQUPJHJIlQEuC2QBV0MX2zqiNhLDn3PwvruQPCi9ZUg
iCsCE7jx4+PJT4lwc7OdH/MAngbsUJzrALDlivIn7r5hbkCTMyvyb/WZAxVsbSPQ
WMYb/FQOVM8xaXnruDUaaHlo9ba4WXKIUWCVA0pg+kLbSS/rnL4amN3QURgC2y7Z
C30DYj/mQndbuSyUuPLovVi9Ea6hk5wWd4V/RTpHUtK3YMe5ZkEnMv5RzPg39Eb/
Ip/dfW9QqUAVlBlbUIyMcDUvhXz/qKt44VTKjo8YLc2iqK4Ppxvhi4G2F598ysKQ
QSpT2tXrqcUzBIwi9/yH4eHj+YuU/oqK1ggb4PzRTl2lWkFLwYr/A6jFlJnfyGdx
g7tMAKjnihJTbsgr+u5DKIrCUd13AnHMOaLsNfJF8eNQS3XlQcg=
=ZyD/
-----END PGP SIGNATURE-----

--sd7bkl657h4vc6nw--


--===============6093161093162097551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6093161093162097551==--

