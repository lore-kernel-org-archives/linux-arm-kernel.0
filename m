Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02795C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:43:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA242081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o9y9uog5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA242081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aTYWiMVmfPsSdbHMqoNnFnH8vj2Ni9AwsUnal4Zk55s=; b=o9y9uog5XsdHabU/8dzKEA6sK
	9/bCcD/ziZvuOzgXNyj/6QypRvVLyfCDhZdVHzcbVunBye2zyKx7KbCzs+JckKmPbop/Wos9mdBRG
	rg3npg6qsv/E3CB7jX7gfJpwVwy5jb6gU1/rJ76soQGgkbZbdcNqJu5Ch+ixapS9v3LfcSU+FX9Zz
	aInL3udvVrCnISeqEokvIcCnHKlFnJ9wBNt11tJA/irG3e8MM1mFbYZnAFsg4CR55IHfWI3Din/Ab
	qAKFnr07m+LGWorPRYBESLZ/FeDWFx6jnhUfd75xE67rPMgb1A85XXwY6DMjT33PCVycwXm+unzVa
	DMtgf6ZqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSdSZ-0003Nb-FC; Fri, 30 Nov 2018 07:43:35 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSdSW-0003C5-4w
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 07:43:33 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id C116720CFC; Fri, 30 Nov 2018 08:43:20 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 97658209AB;
 Fri, 30 Nov 2018 08:43:20 +0100 (CET)
Date: Fri, 30 Nov 2018 08:43:20 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH][media-next] media: sun6i: fix spelling mistake "droped"
 -> "dropped"
Message-ID: <20181130074320.6spzycux7hrqd6wk@flea>
References: <20181129105038.17902-1-colin.king@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20181129105038.17902-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_234332_319472_7F177A06 
X-CRM114-Status: UNSURE (   8.27  )
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============3940393150318267505=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3940393150318267505==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="amdigqxhty2obyqy"
Content-Disposition: inline


--amdigqxhty2obyqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 10:50:38AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There are spelling mistakes in dev_dbg messages, fix them.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--amdigqxhty2obyqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXADqGAAKCRDj7w1vZxhR
xZgaAP40Hi5WIMUHJMWcF/VgTjhvdJ6GdeVuRuZgodrhOWr55wD/V/92v/kyp1TD
NZelKPHKcr1jy5Gl0LwfL7+MhHBxpgE=
=2dfI
-----END PGP SIGNATURE-----

--amdigqxhty2obyqy--


--===============3940393150318267505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3940393150318267505==--

