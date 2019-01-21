Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB7C37121
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:31:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A09C20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mLawGejS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A09C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jc9/7fDYXYsAx9sGe3Mw4TgWsRn8x9P87GKPA5ozXDo=; b=mLawGejSBOsvVkJmBarPgwRsG
	LLaiDOsbWZ8+NN1Nggz+03EVircBZ0JQ4v4ckmENkYLgXgcIGrOXLAKo3LSPsq+pOelQAzdsTZ7jU
	mO29EM4UO2X7Ql2C0nQwevDaRgto6YgL3TZNUBxEcB2XXTFz0CiGsPkAZhnd302g8c8wI/sUCYMpA
	J9mcLC1KWZGb7cJODDvuzFgS7DjyObm8ZFT1yhXtkoHqJkxVFnNiKPHhHEqPcDM1JfelFDosHvFUO
	bU9vMhPHXWvo2iHwEatt4ldMcjQyPk+WgGmrrwrSW2Q5cuY5dg5GSFS3bQfVX5zWrQRhino5PFoRu
	a6PABitIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glgDx-00012h-Eb; Mon, 21 Jan 2019 20:31:13 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glgAM-0007sg-0F; Mon, 21 Jan 2019 20:31:01 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 016A210A2A5D;
 Mon, 21 Jan 2019 12:27:25 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id ZVGcZVUbQBvM; Mon, 21 Jan 2019 12:27:23 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id D67E410A0213;
 Mon, 21 Jan 2019 12:27:23 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 700282FE3A6E; Mon, 21 Jan 2019 12:27:23 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 6/6] ARM: dts: bcm283x: Add missing GPIO line names
In-Reply-To: <1547297008-2740-7-git-send-email-stefan.wahren@i2se.com>
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
 <1547297008-2740-7-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Mon, 21 Jan 2019 12:27:23 -0800
Message-ID: <871s554uz8.fsf@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_123051_961003_29B01B48 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: Gottfried Haider <gottfried.haider@gmail.com>, devicetree@vger.kernel.org,
 Stefan Wahren <stefan.wahren@i2se.com>, Phil Elwell <phil@raspberrypi.org>,
 bcm-kernel-feedback-list@broadcom.com, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7657847242977051009=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============7657847242977051009==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The GPIO sysfs is deprecated and disabled in the defconfig files.
> So in order to motivate the usage of the new GPIO character device API
> add the missing GPIO line names for Raspberry Pi 2 and 3. In the lack
> of full schematics i would leave all undocumented pins as unnamed.

I didn't cross-check the GPIOs against schematics this time, but I trust
your attention to detail on this.

Series is:

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxGKysACgkQtdYpNtH8
nujUHA/+MJTcTE82y75LgXa7DY7+ZVSnD6afFFuBLYyRiwxt9JKN3nG4I5DM+NzH
FHpHgtZwaddCYpZfb0s12xnirlqaekLZf3LJkBlbEVP3jFT7Qr42dVJqrDXunyVX
7QCCs+4X/0Z0MlejJFUQxGvgKIt+of/6XPIRjcn8o5nOMaGxcgJYclnpKiBcykLq
L06DNsLzluH4gYYfTMGSOi+MFnqza22ePVDc/JJYVqKz4ihTaurow4EOPfhZ54dd
cI5QikGmSSwN4P2Am9pLC6dhfh69jynZpvVjcvfcnZhqdYFoZ6LPMm7mGOjFhuyR
sRonMvh95jWhhDtxuuqrX2AeOXCqbXYDLpEjw5XpKyg57eVBvtnnME/iBlNPMNaS
Pj3oEl8nRb9JbR2s9CtBfwi7R7kB9fFm55yveS7e1x3gNultjStgNaTXcWdCL71l
RyhPYKzvNAKX/CsR9Tl6G3OgiiEsMwNtVc0CPLdptiU1pt8ZCRX5epustVlNtqgu
3V7yaPv6pY16bZpyTlw4eS2K8LYcGWAr5yzvD6pPjfvOVx2GjoZsnYY3xXjoYH+q
CGlj98/LgRgGCgmWHHgNrC/wc8/0sSirp1rgs7vksdsDrXOAkv9LXKvAlHzV9q+g
0ImAwJibcNAYj7me1i6lC4jguA4mn68q6AUhnoLRjG+xyxMRqYk=
=sgYs
-----END PGP SIGNATURE-----
--=-=-=--


--===============7657847242977051009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7657847242977051009==--

