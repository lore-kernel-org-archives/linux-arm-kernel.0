Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80ADC37121
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:31:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C01520844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sqprj4Er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C01520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eRVcMqdire5U3OBY4j1UvGHrv5dJG6crTI7qGD9tsgI=; b=Sqprj4ErshmTRSNekZrIb68GI
	YvVZQTUxi/bkz1TTiZgPJBGTuwjE3LnoG7huGJb7Nq+0r+hRNAGDcYUZrEUl0i66+Rdi5EbzhzInC
	as1pIHU0fjd4watezgLMiXnQ+azApzSBvhNXIoXHBsr/1hhh3LDZoD1tlT+d9Xa3wygvlehrTRe+6
	Zm6uiNH42SA4QWpXahVQQPHVdw4cZFEQYgqeOjoBaW9U0cP2/BT4vXF4esEKe5H1W/CkVJWbGp9ZS
	bsTwRVErTuej2Yd/KvJs423+aySwxM6GeYB1LDArs+UxbsTksZcTBjiVKu+iJzObZ/osvnZQC039Z
	bZKXJ4VSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glgEe-0001dS-7e; Mon, 21 Jan 2019 20:31:56 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glgC1-0007uO-0U; Mon, 21 Jan 2019 20:31:03 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id B392710A2A62;
 Mon, 21 Jan 2019 12:29:10 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 4wnkBYxl3LGS; Mon, 21 Jan 2019 12:29:09 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 976E110A0213;
 Mon, 21 Jan 2019 12:29:09 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 2EB272FE3A6E; Mon, 21 Jan 2019 12:29:09 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH] ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl
In-Reply-To: <1548003960-4807-1-git-send-email-stefan.wahren@i2se.com>
References: <1548003960-4807-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Mon, 21 Jan 2019 12:29:08 -0800
Message-ID: <87y37d3gbv.fsf@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_123051_966742_EA136D85 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7233481504113563960=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============7233481504113563960==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> There is no need to specify a pinctrl for the reset GPIO. So we better
> remove this avoid a potential conflict between pinctrl and pwrseq
> after the pinmux driver has been changed to strict:
>
> pinctrl-bcm2835 20200000.gpio: pin gpio41 already requested by wifi-pwrseq;
> cannot claim for pinctrl-bcm2835:499
> pinctrl-bcm2835 20200000.gpio: pin-41 (pinctrl-bcm2835:499) status -22
> pwrseq_simple: probe of wifi-pwrseq failed with error -22
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxGK5QACgkQtdYpNtH8
nuiUbQ//U3KGqKij+SJ32+YotSZa64EUJT4R00K4D27hd0/HMWcS/yECReOGv0RX
gAjxgAc5AIihAZjjlFRfN4fj3mKe+NhQMNNebDAQCdrD8yFFDhAeV5gpOMGLkcbU
fPEzSQz6/wSkJcAY20VSzBpuavCrUQI+g9w7TFyzhfqnTx1ftZdIinWxtdLudrMI
/L1eFH4R2XuUOzQ2enyPbvIBka4ouW2rjYZ5q8nwXQWdONSWkxt1UVAK1FvsZtyp
V/HRq9YvsAttDrJIjuo2kx4U6tWRWAOydfpMjQ67BRbVU/Y8LrXXapZiI3aqvRbG
88xfiY1zWqncUs9qtumtuUTSlzxPfWx8EInW+ZD9Ys/6IZ86K5Kngb9d5U1UQUxI
hvea/3wyE+tJI4FawWhZfer9+dzXHFIhpk/PjZGnWCEjcfIAwszSZ/Ctv+vbz2fW
X6kFgw+jm2oDezO92qy43YnefghpM13rC8CGjI1rhPH/IzOow5t+IBc+Nab5xHqj
5ESQ1v7pywdPyE1Gn8TRpGnAuohtErt8QR9zCvCNA7Ffiq1XplFfdGyKc3/xgxyP
zeam0dMkHnNPwclazRe64c+BIK81JiUx7JlFSkoZ8Gob3Y8cjlwrWjKJyMll5M8l
HjkrPzldf1D/cH7mT9GuMaWv8NmAq4c7DxVwzKptgN1AAG2qGnQ=
=ZREv
-----END PGP SIGNATURE-----
--=-=-=--


--===============7233481504113563960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7233481504113563960==--

