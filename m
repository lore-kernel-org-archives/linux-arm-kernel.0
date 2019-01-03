Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE033C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:14:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A862520815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cfS2szMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A862520815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=su8S5SLQD/JFHPyNsw4u76/OROt+MScWyuGcGW8WHSg=; b=cfS2szMxWhBlAGKKVJzT4CO49
	2VzJ7vrVoJJkjQucbXG74AALU32MLYwAfnaKgMwcugd7vo0Dttnj6J9iVPsTpqqknFigONaRwFd8o
	7JpEJEDccwYQPNiW8nUioQ5q5BjUjuJ/1jkHyw++opCooOmVFPGUxGZP3AozHeRf8GIJ8ojBORoHb
	qkTIa9IiBwLvOXPBTyDor2zLK8L6sZwp3dOQe2lXmXoTs0nFAp1sozrLs/BEwQc7SL9q+3dYKdd4x
	ylYIG5hoYOsC8k82jJ8uInhnBxL8fd6A+4ajyvrBfj47tjd+Dxbh0x0nNzqdbuLqnosHm9eoZvFdT
	bxrXAawgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8RI-0008Pb-55; Thu, 03 Jan 2019 19:13:56 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8RD-0008PE-UL; Thu, 03 Jan 2019 19:13:53 +0000
Received: from localhost (p54B3379A.dip0.t-ipconnect.de [84.179.55.154])
 by pokefinder.org (Postfix) with ESMTPSA id E98202E3614;
 Thu,  3 Jan 2019 20:13:50 +0100 (CET)
Date: Thu, 3 Jan 2019 20:13:50 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v3 1/4] dt-bindings: i2c: Add S700 support for Actions
 Semi Soc's
Message-ID: <20190103191350.ud4fbl5wx3hazs4m@ninjato>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-2-pn@denx.de>
MIME-Version: 1.0
In-Reply-To: <20181211080448.24007-2-pn@denx.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_111352_127024_9DBA313E 
X-CRM114-Status: UNSURE (   5.47  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@cubietech.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 thomas.liau@actions-semi.com, robh+dt@kernel.org, linux-i2c@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1069870076021342135=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1069870076021342135==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pxiyn77e74u5fpf6"
Content-Disposition: inline


--pxiyn77e74u5fpf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 09:04:45AM +0100, Parthiban Nallathambi wrote:
> Add s700 compatible string to Actions Semi SoC dt-bindings.
>=20
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

Applied to for-next, thanks!


--pxiyn77e74u5fpf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwuXu4ACgkQFA3kzBSg
KbbVsw/+IgVQLFBXRkETFjun9/mUOF1Li/1IfKeT418b5XHu9xk924nJeaPQNoAl
TWiJhDhcoD7nx/2nE6h87lnBgYdmrfukgukqGszt2iuXRE6ObKGVY8g4TeCWkJPS
+KoifU5j4oah97ZStucLlHJrBM1y1YrBBIjHC21ntpKiOyYcPjHry7uTCkrQOXOd
VsGHsGQmSE1CCcNlRfX9Rzhr8z9zzpnTg5AOHZCE2SEw2tM543cTFgJ3GTHrjeEr
qqxU/CQ3f/ALcimX6YSBmejqXpTBS2pJG1R0bLQKj50aCNnaq/fNpwVBNvR4+497
CLNlgPWWscFtMXbNT1Nz+sKzNGEZDViPmGH/zupL6hPgYrAUtfZGnZcugeVpEZOY
9zq6Tte9Ekg2iBLP+PTTiNjRq/h0LA+l3HWiSwwstMiDkGC23D67zTVZRN/6Salo
ewQADA9X67j3FkFKUOEvqEZ6rO8//SyG0I3eF/MOkHrtb5lEJE/7HKd9B4KqIT7w
4+iouUUoY8Wscao0miYCDNwFmRQmpeGC0K8mVFJnYvsxkIN0kXU6oNx/VJWxaWEW
MVGlJLg20VfMNFs0KkdBZrT6Wiei1iB/qwRZKamVEQeJ9biePNyy8C1KBfN3BPyx
8oegVkJ383+d5ot/Z6mdPtY15rvG5XWXpou5o7NIFVdBHe5FSE0=
=KmY6
-----END PGP SIGNATURE-----

--pxiyn77e74u5fpf6--


--===============1069870076021342135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1069870076021342135==--

