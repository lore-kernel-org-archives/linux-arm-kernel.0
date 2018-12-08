Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7080EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:50:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCEE20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ztff/BEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCEE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n6Ufh7XMFbjDco23vYwSPyQTaScl9GffmsVMfaEhytA=; b=Ztff/BEyrQGJKRBOSz11s43Ry
	Sm/Ol4X9gEpnFQhD2TFn+l++KUgIGJNf6GIGE/ziaA/Sa2kjmTSvHNpMAWXw/+5Xm5tWXwxeX/yV/
	Rkp6U0Hb5wU8j6E1MmwFWBE46GLMSD8vIdurWjfaeidmrTbdruZBkyDS7ncuIRcbKv9ZLf8gswQQE
	eJ1bBnw2TZbOGcbuboQEWoXyj0TPZ4TDROceRk8fyI8vy/2kvUO2BkpNLufozh4xVQ4uOMO06KxaU
	7yOW3wrXn3+783m/L9pSeE5nFIDH/zIluBthyXoZ0gfE3qpUReF3frVMCHt2S8Tmo3PsaEH3PZP0J
	4pP2nWPHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVVVE-0007Hb-1m; Sat, 08 Dec 2018 05:50:12 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVVV8-0005zV-Ns; Sat, 08 Dec 2018 05:50:09 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id ABB9B10A142E;
 Fri,  7 Dec 2018 21:49:49 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id J3DjnH_EQQmJ; Fri,  7 Dec 2018 21:49:48 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 81D7710A04C3;
 Fri,  7 Dec 2018 21:49:48 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 0FDBE2FE2D16; Fri,  7 Dec 2018 21:49:48 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] soc: bcm2835: sync firmware properties with downstream
In-Reply-To: <1544206871-15725-1-git-send-email-stefan.wahren@i2se.com>
References: <1544206871-15725-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Fri, 07 Dec 2018 21:49:47 -0800
Message-ID: <87va44ftz8.fsf@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_215006_816435_CC290E37 
X-CRM114-Status: UNSURE (   9.06  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6034677799786113597=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============6034677799786113597==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Add latest firmware property tags from the latest Raspberry Pi downstream
> kernel. This is needed to use the reboot notify in the following
> commit.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

These are:

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwLW3sACgkQtdYpNtH8
nug4Pg//b3XKC5Vy62B95Uzy7w1KYXnVNyYPXMU+BIZ41mlY95xn8uMcORtQKNQa
c9Iw51A0dbLh4sZGmBNLYuVklUr4xVCMwsVMls8JR3fKPuNeG4gKteywA/5+9Rzp
Ilv+XbdjZink3pWBRqPSxZpESWYkB63E2lHYVKJ6vg+Na9ng4nLBHzybf1djV4zC
I0MG1q0hevL23J4e+fEGYQb/CHYZgDV18AC/k7jRkpc6QtNzRZ9lK/zwD1x3Byed
YwUiOCTZts+snsfXwPxXbD3tgVnwX4gSsVK03UXHm3HQTcf+t37iQwaMpkSSuZVk
mbjms7MVYthvMisCO2HmZRkHci8RSt+BzLTVElLctRAyKn52bHtd0l9tarrIKRCu
VxZq5wH/xUGwcIE7nSoNkIh/xOaTwByTXWtVCWayODgFXBtzjbLuZBymd4MT03Ud
xRoEG/zOllzqpuuBf/SrnYtftQa3njA2lfHPri1y26CHcGq3gwhy0mMypeRof4dC
Xwuys+OEEXbVCGP5wJUKkSywLAn3dNT3IgrCvpS9m8o3bPOAO6RqktC7dMhX0NNh
abbmM2OB+GPFU4+QImKPtny5QgVUTHJLk1xKae+UutvLDfBTaDb8xSsp0VpDRMV9
9o6b0A6nPOC1dA0rf2coHtBESoQeGJ52oBeT7dfoIa3pn6mxT5U=
=xcF0
-----END PGP SIGNATURE-----
--=-=-=--


--===============6034677799786113597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6034677799786113597==--

