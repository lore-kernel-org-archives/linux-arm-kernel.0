Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A64C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:06:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC3A21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eUsfIga7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC3A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9tDzUd5DVRjEEmpPCvQVPuNRHbsQ2dmZh0rTMPMSdEg=; b=eUsfIga7I+qsxYNsEwWUtM4DL
	QWBUrvNLKd8oVnlj8uC4SnSc2n6Syue1WW90+4p1nvTsdEoeozAhGzSOIF+iAG5S3bUKgwz3oz6I6
	lzZzR2oqRYEmyR4p4j1mtQqnb5kKyjkzni+p4VdpKMFplveS6hoglpDRrHYGa5zloh00YaJE2cHT2
	ZZkMtEfPBgkR7OvNxlMoHiaugPOFNGaOlsVDHa5O0Osr3lL+IzpU3ZNQPkbtvXlCr9bT1m/7sBJg2
	Xs9VQ6ANVJEMOXkk7rORXiA+M1N+HRKIu5W/amUH8Q9jLOcjVbzOqMJGV6WLRlWaX1ix/dNjx8LCC
	79ozPBBnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1nI-0001DH-6v; Thu, 06 Dec 2018 22:06:52 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1mq-0000h9-1F
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:06:38 +0000
Received: from localhost (p54B332AE.dip0.t-ipconnect.de [84.179.50.174])
 by pokefinder.org (Postfix) with ESMTPSA id 49E8E3E409B;
 Thu,  6 Dec 2018 23:06:10 +0100 (CET)
Date: Thu, 6 Dec 2018 23:06:09 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 0/4] UniPhier I2C fixes
Message-ID: <20181206220609.GA1100@kunai>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_140624_825009_E8650791 
X-CRM114-Status: UNSURE (   7.17  )
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
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============0187028385076123271=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0187028385076123271==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:55:24PM +0900, Masahiro Yamada wrote:
>=20
> Masahiro Yamada (4):
>   i2c: uniphier-f: fix timeout error after reading 8 bytes
>   i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
>   i2c: uniphier: fix violation of tLOW requirement for Fast-mode
>   i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

They all look like bugfixes to me, so applied to for-current, thanks!


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwJnUwACgkQFA3kzBSg
KbbVWg//SKoF8iqLVzVaLHhyaqytaaee2i2wicaihztkC0smv+LNc63fzMf4ozL3
AyqCa/1NKy2qfBW9bXl7Dd6T4RpXZmQAPQ67vVlk74Dn6S89pk1lZztG61/m+HsB
dBlzXxPoF87/cPbq9aU9GLEvsSJcy57h7Z03m24rtemdKDcNFEaxkZy26i5+Ccku
kdFVQm70SUyQyg6ScQLX9bl/X8JDOvhpv/xI49iTXYvdK+Xeu+dAgGNcjkUhMDYQ
ynLdb3F/XNfNmqXjgsABe3A0cYwuBqstqKBSUzWax/66rgSOFv2cUO7cI04bPg9C
5gNbaeoOGE8FGvaxptO+VmasGcF08rhw+KRoMKxEoag3vNdFTOtUf13UwbmVxGHi
0b+02hUbXEBSVSDVT0vrmeIFA3906R4gmyyNsTYMhlt4BM8r/w1cSsXAEAhuHrc8
hdNeyA58t8Fj3Si2/aoNd6rpKEKQbCsPtlIXaFbmmC3CedP4M565oGsIt2rL7jZ3
IU9W/6Mqe274W6ztifoaccJIn13x19Z04EUS5PrLWh++bnL4QOksQu/vEw+ZNl6+
6Tv4JKmLziiajhbAxGL2jfd9Hu8n457VSFu3esz1hO1qS5ZI3ucquQ8zOsCWyOrG
zYteCM5Oyx8ECP/m2uQikinXpBNYA8Ci4n5MGTzjYJnHmQuwXpE=
=MQIn
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--


--===============0187028385076123271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0187028385076123271==--

