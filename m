Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22419C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:10:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FDB20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mrXSSEgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FDB20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Date:Message-ID:Subject:From:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=QWkchmDfjYiuOHLGTsrf+8vsnK4I+R7VToNYJJwde3s=; b=mrX
	SSEgRTHLt+QTsWOy4E+8eIst+7zCMhT709NR/AaAclK81M8u92c7/mqftKrY6eJyJ7iWHbpwIqgQF
	H3xbRp7LoCN+1BeOtFQV3+AR2R3UgesqrWuH8fiYm0f6FTCatGqCmPg6cTTyEPPNc+g+GnZqy0hQ6
	8zC6SxOTB8RoxDNagtAnw2juUVTotc2CnrdouNJbP2UKznPhADpMUWjd0kj5gTDQHaKilA0FLzprx
	J70xvsKjh35kVy/PFHo2/no1GvkxTKUIVA6qoWd0+T6YnpdptCZh6nas4qFDXE+wu8+M2qxd92EtJ
	pZO57QTl5iMrmqZB8iBypHgs0U/y6eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWP4J-0001Ui-JC; Mon, 10 Dec 2018 17:10:07 +0000
Received: from antares.kleine-koenig.org ([94.130.110.236])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWP4E-0000iV-CZ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:10:05 +0000
Received: from localhost (localhost [127.0.0.1])
 by antares.kleine-koenig.org (Postfix) with ESMTP id 827444D3F77;
 Mon, 10 Dec 2018 18:09:48 +0100 (CET)
Received: from antares.kleine-koenig.org ([127.0.0.1])
 by localhost (antares.kleine-koenig.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ajK_mKKXvQl2; Mon, 10 Dec 2018 18:09:47 +0100 (CET)
Received: from [IPv6:2a02:8071:b581:3afc:e07d:6c96:fb5f:12c6] (unknown
 [IPv6:2a02:8071:b581:3afc:e07d:6c96:fb5f:12c6])
 by antares.kleine-koenig.org (Postfix) with ESMTPSA;
 Mon, 10 Dec 2018 18:09:47 +0100 (CET)
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=u.kleine-koenig@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: mvebu: how to determine the address of the internal register window
Message-ID: <f54e8ca9-0ca5-ce03-aaf8-e837f68b3024@kleine-koenig.org>
Date: Mon, 10 Dec 2018 18:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_091002_778625_470997A1 
X-CRM114-Status: UNSURE (   9.11  )
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
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2711369437746963028=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2711369437746963028==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1Ugmz8tgtmZGtkhzaT7rDgJyHnbZVC06O"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Ugmz8tgtmZGtkhzaT7rDgJyHnbZVC06O
Content-Type: multipart/mixed; boundary="CCtKZIN5VF6DDJJSSsfqZ1vNCCdTfNqB9";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <f54e8ca9-0ca5-ce03-aaf8-e837f68b3024@kleine-koenig.org>
Subject: mvebu: how to determine the address of the internal register window

--CCtKZIN5VF6DDJJSSsfqZ1vNCCdTfNqB9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

using barebox on an mvebu machine the internal register window is moved
from 0xd0000000 to 0xf1000000. Compared to U-Boot the PCI Express BAR0
Internal Registers (on Armada 370: 0x40010 and 0x80010, on Armada XP a
few more) are not fixed which makes accessing pci devices fail. Instead
of letting barebox fix this up I'd like to make Linux ensure the
register is configured correctly.

I think the right place for that is mvebu_pcie_setup_wins which needs to =
do

	mvebu_writel(port, intregoffset, PCIE_BAR_LO_OFF(0));

I wonder however how I should determine the actual value to write here.
I didn't find a function that exports the offset of the internal
register window. Do you have a hint for me?

Best regards
Uwe


--CCtKZIN5VF6DDJJSSsfqZ1vNCCdTfNqB9--

--1Ugmz8tgtmZGtkhzaT7rDgJyHnbZVC06O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlwOndcACgkQwfwUeK3K
7AlQfAf7Bxaf/P3H91tesFQyugG7y61szIcdiEy/ZVI5llopmd1i5rcODPsJfUz+
Cb41KadzRBC5CWDJv3xCKJ+g9b+x5Gggi+r0wyBn/9KjWkerU/FvPGisVV/1kF9H
rFVHT4WJPXXEhr+Kuq2TApy81sHqg0AHl1RmlWMg/57ndUbqW8wMBL+gsEreMFtd
xseKz+knnU3PEoMgUysa7peVA++QGaf4z6FWBeNji86iPSI8XxA8eR32Pt9qT8l/
bi/whxk8KabtTGElR91F/xeQGJKDH8JOsUY8C8NQbNSLNN/5fzh1xZcn2MXZ88U/
DjVe+se+pmqOjOblY6tNfpfNijexXw==
=9FZz
-----END PGP SIGNATURE-----

--1Ugmz8tgtmZGtkhzaT7rDgJyHnbZVC06O--


--===============2711369437746963028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2711369437746963028==--

