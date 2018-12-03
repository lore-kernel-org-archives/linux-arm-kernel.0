Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCA3C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:59:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84AAD208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yi+6iQTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AAD208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z7OfHIk6zV+iJZAeGYqPpcSqCpBRmZRjCGydGE1CD/A=; b=Yi+6iQTbZZ3DooGSpBfPobA4c
	bPSeYeblXlA2yTgvpib0wagjfMBsM3SEtSz5eUIiJCRVOqiO+OgoRrZIxGJ/K/SR1A5cnv5ktM5er
	KgG2LFnO2cn/8UwuM0QEkrF56IVRrVEQ/9MzTys+g3o/FGK+tPsCpC+M2FrfXTjK7I7hhpkmzOX3d
	R+N8N389MBwqIu8spcTsYecKLbRrfXCQxN4DTSC/TraVIRo57boQgiqI6t16PAmAzL7DNSgIreBIN
	wZa2t22V/adRVPWHVaiNc6JZzHgDQC6wRKQ+4n+QGg8KB31tueJO4N+ZvhGqXBGy8vkK15bwFwA5w
	R+NrgGQ2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtRW-000285-3m; Mon, 03 Dec 2018 18:59:42 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtRS-00026F-Kh; Mon, 03 Dec 2018 18:59:40 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 43E3E10A156D;
 Mon,  3 Dec 2018 10:59:25 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Affe33jGseZI; Mon,  3 Dec 2018 10:59:24 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 159F710A0388;
 Mon,  3 Dec 2018 10:59:24 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id A72852FE36E1; Mon,  3 Dec 2018 10:59:23 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 olof@lixom.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH] ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs
In-Reply-To: <1543862228-3863-1-git-send-email-stefan.wahren@i2se.com>
References: <1543862228-3863-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Mon, 03 Dec 2018 10:59:23 -0800
Message-ID: <87mupmjv1w.fsf@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_105938_715954_6099B4BA 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, stable@vger.kernel.org,
 arm@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3256999899678906704=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============3256999899678906704==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The commit b1b8f45b3130 ("ARM: dts: bcm2837: Add missing GPIOs of Expander")
> introduced a wifi power sequence. Unfortunately the polarity of the reset
> GPIOs were wrong and broke the wifi support on Raspberry Pi 3 B and
> later in 3 B+. This wasn't discovered before since the power sequence
> takes only effect in case the relevant MMC driver is compiled as a module.
>
> Fixes: b1b8f45b3130 ("ARM: dts: bcm2837: Add missing GPIOs of Expander")
> Cc: stable@vger.kernel.org
> Reported-by: Matthias Lueschner <lueschem@gmail.com>
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911443
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>
> Hi, i like to have this included in 4.20 if possible.

Reviewed-by: Eric Anholt <eric@anholt.net>

Florian, would you be able to pick this directly to a -fixes branch?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwFfQsACgkQtdYpNtH8
nug04xAAr7p8iHYm4chRUeOEDLHYkm7FtY73Np2c9Fe9MXzCiW8lb0hepbawQ1PC
0h2nJ6GYvbkgLaqOw0r07t4KEBJ5VWMAYAgozLo6K4sJkqN7VUhKVBzyy49PIpeS
ZDvu6wVsTjYDTQLR0YCDGp92EdgUjjXnl+V7C0WH/LsLVwItEiKLTLfXF2jWFSTW
Lg+kjJSBKlcaab4kKQLRR04KvxmQqTbrlcpRSf08VZRjDhTpa4oQXIwxtLCzy/p9
KAfXxIn0TEZMmWFB8gZP6hcgWmEEYvfAhI0NxoiAvJ3dQYD+nMhjVTg85see+c6G
ZRYttiHs2r1ZwDMzA6VHOlKdjirA32nrn242OWit9olfRCwPnMZM8UB9qpGOyLpP
BmSpmW/hgqoVCtmE6INSHJmm5lA42Mz1dzOwxRWbtBhFUK6GyMuni1HnpmhAL7NR
whxE106ZPq6POFne7xqD+abktFsdx+h8WaDLVYvBG7ToVek2KlQGyW1LVUM2922e
rahnTytAlooz8FPCNW+t93H7yCL4jnbIbTdSeMxbzfZcFGVxLuRYvPASx915Qk2X
bhKbGk0xit4fsqgD9SKmYSAbgJ+J2SmiRTGi8iq20/7BEFb/RAn1nc/ul1rs2cGu
AjG5F3GrF6AbdILd6vyBgS3ZirTPQ/GHTKkxrvoarzuQPTB6PEU=
=ll7G
-----END PGP SIGNATURE-----
--=-=-=--


--===============3256999899678906704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3256999899678906704==--

