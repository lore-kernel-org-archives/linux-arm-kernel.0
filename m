Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E410C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:15:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2154221872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a9lKV8+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2154221872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v3UTsZ7OhsFuprVX1BG4N1FW5kQ1GcBwEORnY5ELaos=; b=a9lKV8+U9Fa23dO7LATNrnLYN
	ouNiVRouvjLW9NdyOPhxcV2Dkwr6fJJ5wVezrvOp7YqePoyOcyfICeJ/bTlnEC/pJ3YBUpEt92Sv3
	cIbLkwOMWUokpSlMb0K57nkiitAlbebV4lK59oNVCba8hnFLHvt71i+wfLjtC4oVV9SpNcBd1S6JZ
	PRyxbPIRWuEro1BD8W972WuIMZ3E3AiIVFzVMyy5+oUIQDylSeHMXBCErtM1CglMrYbIwa5Vjs3jl
	KqYhlTaNyCnV3IptHqPFjwCKOo1Yel8nM4+kdzPb0DTCjtzYArKBN8RbADOa2UX/UsgTuAlEmVXZD
	byWRtw7GA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjXW-0006Ad-0W; Thu, 24 Jan 2019 18:15:46 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjXS-0006AE-1i; Thu, 24 Jan 2019 18:15:43 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id D9E0C10A2AB0;
 Thu, 24 Jan 2019 10:15:36 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id OlgTVtixoxYa; Thu, 24 Jan 2019 10:15:35 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id BE82A10A2AAF;
 Thu, 24 Jan 2019 10:15:35 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 2BA362FE3A6E; Thu, 24 Jan 2019 10:15:35 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH V2] soc: bcm: Make PM driver default for BCM2835
In-Reply-To: <1548353060-4900-1-git-send-email-stefan.wahren@i2se.com>
References: <1548353060-4900-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Thu, 24 Jan 2019 10:15:34 -0800
Message-ID: <87imydvs55.fsf@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_101542_128860_2D50369D 
X-CRM114-Status: UNSURE (   9.61  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3990040631218582730=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============3990040631218582730==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Since commit 52a4adbaebcc ("ARM: bcm283x: Switch V3D over to using the
> PM driver instead of firmware.") VC4 on BCM2835 requires the power driver.
>
> Otherwise the driver won't probe and HDMI output stays black:
> vc4_v3d 20c00000.v3d: ignoring dependency for device, assuming no driver
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxKAMYACgkQtdYpNtH8
nugyxg//dPy1UDTnpWEJJGZMoQYJVRo4IN8mr43r+Us/miOTA6R1i5kdbbAjdROl
SzLduri9mJxF6lFXI0UtpEqBJZV9jIDzSbRNS/1+7XN0UrYGkjUlGG0ncUpDIy5z
m42yDf0xwHnG0QMACyF6uvugmTXopV6jS9mnAaWlrr7JNiIxrcQjrTlfg8Y78LpN
bmDcq10rtpT2j3dZvARmxY2aOVlLenJaa3YZaAJwmS3QrLkp3pPwIZSJsXJckb2T
TnP5Xsba+J8GGrFaCkD22dkWQ8FPCoKDlJcht9PAPQOrbGw3AbCu1m4wHnUr7MfL
9w+jvBRYs5ZuBWfecTo0JaMVoPYBlLGG8Iz1HJdSlwHTI2wANNokPwIbPTdv/qck
B+DYBsPJm4WgoMiVdmALT7i/UF24kWU4ZIDWqA7h5+YFsnrcrVaj3ItSd0HbokMG
DsT/MXVoXf215rfgBMPOGRx5Caeq8Gb7KjXH6VmGKbeLnACrMKxkBJpQsV8mA+5f
BxqaDgfLjozCOYDVz7yKjfgV4WKkK0trNBV3k/GJyYEknNzNq53vHQWYFUTO+kaa
CKTUBOYJegrOLP1epf7UfPl3RfQZlRsREx5Q9lmF8HlsEUcNAZTRXMuuX2v7Tzna
DxCLb1e9kwytOitig4OLJs4YeSmOsrc2LRBV7h9m/xUFHHFiM/E=
=XM9Z
-----END PGP SIGNATURE-----
--=-=-=--


--===============3990040631218582730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3990040631218582730==--

