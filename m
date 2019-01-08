Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF32C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:03:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083232084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PlSE20Q/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lentin.co.uk header.i=@lentin.co.uk header.b="HJR7aKIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083232084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lentin.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E1VcQFo9D2hS39zCQ/r1Yfz5jKCi6tTL9NsTcI3rRRw=; b=PlSE20Q/N6tKhpwLW+ZuBWTDu
	KPD1DQIoIdxZyu8cf1LjCiA0BUoQOk5rZSNxZB1NcWduOuracveYvFldFPDfZCiFzrMuThLDuzBOA
	zBOmKp+NaZNPPlAhcR+vPav/5l3eMHmKDs13jYWNcLj1qKCC1oQSw/j4xVGmxgTe0HP5BY9iD2Kya
	S45hXXh0s8hxI5HyMFqKEnaOCWhsIv0n6HXvwbp4kPGqMp51M40DknUtQUiueYwNHrUhSo/ELgDuZ
	p14svmkNJQ0rC/P8bI6ciIoyeqAw9UyHm0iQue+yo7u1B+X3NoCyq0YKJ4RGkShIcvWSbUezXWVXG
	6CkPAT0Zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh0Od-0005K0-M4; Tue, 08 Jan 2019 23:02:55 +0000
Received: from marmot.wormnet.eu ([2a03:9800:10:2d:3203:b3a5:8bdc:5b68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh0OY-0005Iq-Qc
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 23:02:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lentin.co.uk; s=budgerigar; h=Content-Type:MIME-Version:References:
 Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3mCOcYXnj25W8gHL8a9V4Wo5AyqC/8Jzr3SEzQ3rZ1o=; b=HJR7aKIVnulkDSexmbb2fafCp
 47/5adPO4lBv/BQYt5acJG73R6k4jiu8oVcpR7iForf5IYeJ6E/LEJ9HtisTlEWNEB1Rmx6zAnlQ2
 dyAx7DeU/Mq8RUXqL3gQCcA5CF4iHimfXXc3Bhu6QNTZOa1iRtHPi1OXdvm+2cAUXNJ68=;
Received: from localhost ([127.0.0.1])
 by marmot.wormnet.eu with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.91) (envelope-from <jm@lentin.co.uk>)
 id 1gh0OF-0007VQ-UN; Tue, 08 Jan 2019 23:02:31 +0000
Date: Tue, 8 Jan 2019 23:02:28 +0000 (GMT)
From: Jamie Lentin <jm@lentin.co.uk>
X-X-Sender: lentinj@marmot.wormnet.eu
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: dts: kirkwood: Fix polarity of GPIO fan lines
In-Reply-To: <20190107230818.6020-1-linus.walleij@linaro.org>
Message-ID: <alpine.DEB.2.20.1901082243480.22787@marmot.wormnet.eu>
References: <20190107230818.6020-1-linus.walleij@linaro.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_150250_900939_5ED0A3BC 
X-CRM114-Status: UNSURE (   7.25  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Gregory Clement <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Julien D'Ascenzio <jdascenzio@posteo.net>, Guenter Roeck <linux@roeck-us.net>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 8 Jan 2019, Linus Walleij wrote:

> These two lines are active high, not active low. The bug was
> found when we changed the kernel to respect the polarity defined
> in the device tree.
>
> Fixes: 1b90e06b1429 ("ARM: kirkwood: Use devicetree to define DNS-32[05] fan")
> Cc: Jamie Lentin <jm@lentin.co.uk>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Julien D'Ascenzio <jdascenzio@posteo.net>
> Reported-by: Julien D'Ascenzio <jdascenzio@posteo.net>
> Tested-by: Julien D'Ascenzio <jdascenzio@posteo.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Jamie Lentin <jm@lentin.co.uk>

...on a DNS-325 applied atop arm-soc/for-next. Apologies for not noticing 
this sooner!

Cheers,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
