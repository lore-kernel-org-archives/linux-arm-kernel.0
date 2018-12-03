Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335A4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:58:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF8F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OFztoQXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF8F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3/g99LUiNXa3HHcmjqvuRITSx8oX+1+rgGlcpbZdzQ4=; b=OFztoQXafc4WLhD10a3cJvGxT
	a9xrTHVZjbfYs05Ggq078wqxa+gY34IePD4TxReuL8MOOaLj9ayH9H1/nnzAaDjiGdsiOKV3cX+64
	Ar10CDeGdVTLoArKcy0ilzyXmYaw0zmu6WF6nUslKyyP3PKMtY4OaK669Pj/CDwhxdLV5NwmOhW/8
	zd8i79IcvQ5KJm2vssAjSg93ZO8ocTrRBjSBdpXNmKG622/N1UxLL4iFn/y1dGx+OE33gn3N/v7xV
	JUg7Y6otYu3b2gAXh8sSQTri7G7PHLFnx31YQ2wBMZBDO9mI3WvDFG2fPrkqlqgJk82o8lmHIrBJ8
	jTPeaNMvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwEp-0001DB-3B; Mon, 03 Dec 2018 21:58:47 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwEl-0001CV-Ce
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:58:45 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 45E5410A12C6;
 Mon,  3 Dec 2018 13:58:30 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id HjoeCEUlU4lQ; Mon,  3 Dec 2018 13:58:28 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id B0E8010A0388;
 Mon,  3 Dec 2018 13:58:28 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 376C82FE2D16; Mon,  3 Dec 2018 13:58:28 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Olof Johansson <olof@lixom.net>, Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [GIT PULL 2/4] Broadcom drivers changes for 4.21
In-Reply-To: <20181203210740.x5zxpty5x4jnb47v@localhost>
References: <20181201203942.13376-1-f.fainelli@gmail.com>
 <20181201203942.13376-2-f.fainelli@gmail.com>
 <20181203210740.x5zxpty5x4jnb47v@localhost>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Mon, 03 Dec 2018 13:58:27 -0800
Message-ID: <87wooq9ssc.fsf@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_135843_458091_BE2DED48 
X-CRM114-Status: GOOD (  11.74  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 James Hughes <james.hughes@raspberrypi.org>, arnd@arndb.de, khilman@kernel.org,
 Yangtao Li <tiny.windzz@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, arm@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3984961578430569588=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============3984961578430569588==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Olof Johansson <olof@lixom.net> writes:

> On Sat, Dec 01, 2018 at 12:39:40PM -0800, Florian Fainelli wrote:
>> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097=
d2a:
>>=20
>>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
>>=20
>> are available in the Git repository at:
>>=20
>>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.21/drivers
>>=20
>> for you to fetch changes up to 1861a7f07e02292830a1ca256328d370deefea30:
>>=20
>>   soc: bcm: brcmstb: Don't leak device tree node reference (2018-11-28 1=
3:46:44 -0800)
>>=20
>> ----------------------------------------------------------------
>> This pull request contains Broadcom ARM/ARM64/MIPS SoCs drivers changes
>> for 4.21, please pull the following changes:
>>=20
>> - James fixes the firmware interface after a commit changed the use of
>>   VLA and broke large transfers
>>=20
>> - Stefan adds a timeout check for Raspberry Pi firmware transactions and
>>   updates a bunch of SoC/firmware files to use SPDX tags
>
> Should the timeout and large transfers be merged as fixes?
>
> Picked it up in next/drivers now, we can cherry-pick the fixes if needed.

Large transfers only currently affect the Raspberry Pi fork, and we
shouldn't ever see a timeout in normal operation, so I don't think we
need them for fixes.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwFpwMACgkQtdYpNtH8
nujfTBAAkmUXirG7Bx84XFHnN8GNcGkX4iHkTuPjhcqgzbwddsjzQKSpzvTkbvDR
LdtXRZlz1vediuCYol0GYzsZz/PkaSAc/pvOQlca/fV7/MKQw1P+nUm+QhDhfZ8i
/slADsxUPK8fiPrICFQ2exSXK1XZdKjntgY1TbhpUHqryBas3R7lyQ+ZMrVT4NcM
beZy660ql7r9drIIij/sIYGH0Da9MLwTPl+2DZvIu7TBHN2C/akgu7NxfOy7sEdk
wPzJTIvN4r6hcE7bkgQcTjrxLS7ekHmJ6mnx865o0eZh+O6XJNdt70oNRLmCquG3
WZv6zXgkjellrNtrfxQ4jWVSk5qORVvXlVrpVfeEv/MYNgUXdSHtdLsem/k6O+Hh
WqYcHfNYC4TC7j17htVIPOWVaZUgdX1bEXxfe97pyVCT4yV6jyvronp1XzqclD2N
eXDuIJqZozHKiT+5Vzk/VwvLYXBXYAmDvWEpf4/uChwz8Uqzu7zlaEA1tPvUKalg
v4GmeKS8infr6N0Fa/4EsHwWvGXo4WFL+Ov7faj5mulbKQW2wVWJ6ISOiSwksEXz
+POUXMIgmHauBYz9mMjOopYnitLD+qViS/1wXb/+zehaI1ZRtezLs64NPFfeUEpu
RHePNSQm5aPX0m9VWVxlC2tNxeIwoRbiwrtsz3f3ecsW0cMUl5A=
=dQxk
-----END PGP SIGNATURE-----
--=-=-=--


--===============3984961578430569588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3984961578430569588==--

