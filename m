Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CABC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:16:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5552184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uNcP/3TZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5552184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kICtkV79LqcQ4gyD/kmdJcLAUH9iw8zMZWVGHEJHGG8=; b=uNcP/3TZPMtefe
	fwUJ+FcMUzk99F2QGOUppcvIwSGurOBcM4jlz1ELauiWDudmWxII/c9vZdmlj6K/WfeSiopt3fOvH
	Ep/DIHEOtiU9GUOf/sQJvJUD12pH7VdVB5lgY4YjfB/dnUm0oI9dlTp7Ljz2FqEhRs8FqvGQxcdjz
	Y3lHvLXdQPo5OMG4uxAMPxMbwoXZWkQ+lnDhKrUtRj/hCRUbHFpmZC0BvRitoV9Ot8Q6cCHX7mFL3
	c+LHU9wlJF5ZZiphL1EAgZPvGmBKpOhh5d/+rBtFohS9ysu5W4nvSzA08+qeJ9hz6EKAS/VdN9PJg
	cvXhwlifEqLaySJEL50w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLCT-0005z1-HM; Wed, 23 Jan 2019 16:16:25 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLCQ-0005ya-0t; Wed, 23 Jan 2019 16:16:23 +0000
Received: from oxbsltgw08.schlund.de ([212.227.220.152]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3DBd-1glWmZ3IOD-003dxv; Wed, 23 Jan 2019 17:16:06 +0100
Date: Wed, 23 Jan 2019 17:16:05 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: YueHaibing <yuehaibing@huawei.com>, broonie@kernel.org, eric@anholt.net,
 f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
Message-ID: <2064917135.710926.1548260165940@email.ionos.de>
In-Reply-To: <20190123070507.15404-1-yuehaibing@huawei.com>
References: <20190123070507.15404-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] spi: bcm2835aux: remove unneeded NULL check of
 devm_clk_get
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:9mabrZGoQKRSZQr9I6ZiP+0AnSc72EVBNLh84GmHZAfIEIf/sqX
 eMZcGcgGn2Q1dtLEB7Ix9raatAf7ELEJCBQjUaAkYVFENuVPgu9I1B5imDoVCoiId5YSJKO
 qH4JFhNGf7OWbkJBYkZA5S0NPcx5Q1LAKQPvz4xOIqjjn+eDp0tIc6M7JguPVfAnzCPcypa
 95IDmoW/yV3ujprIBYQ5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ReyfGeQ0ng=:SMw/zddT1TPelJJ9vHqAiC
 8nUzBPzPXqUgZ+HUDDcYYoBOLRqoWIS6Dm8vDxH1D85qP/KyUNFFCJ2K7csHsFomg0+As4XWJ
 715ZEaljr2j46Tpu+BW3/M+s9+wI1DRSGoIytr5FrP3lPo77+GNl6wcuwpVqb4VUwPp1niDBV
 tesgyhckN15ugYE/SAMszS3YxSOIcCo4ewHFA11z1pXKJ3X9dvwue5wVwTo/7mohtQhmbhiir
 isGp4E4OhdqoFAYpQrbocjjdYeRxtG9l8IXkc3GVFtP7pi9UnX9FtOWp8UPFLqEZ1wKQmgVPw
 KQPdiCq7ukhkuPqp4Lg3QH0TsXoyV3EOZRi7zs0BctSGWXZl7I1K/GtO/dnTF7OsqyfQtYXKH
 K/17L8oAGJ/dWZ7miVLuR3qdre2fVDU/uehcVEv4VvkKwZLj1DK8fCpUDfWQkC0U6nA9InsfB
 w8pgsdWZ1mqCtGgbTNeHvCmvxwmyYBVGcjONWhUeF0WKnV+CPYnc8TG/cqKvTd5giWMupd82B
 X/5SEwTsdslrqqCA0yYNBweVuTmX0z6up77ACUIu8ZHiy62H/OOfVGFCv6hcdxjY47J++qbxQ
 4UXn8cYJlc7LYRp+o5BEG2wcKjk3RIvaKYynLxzHInc5iCYJ8IN/YGfGT8LYX9c+AelPCBXx8
 ADdreqXqu9JqhvMXreHLJVZufaYLG0j2zAYipyyIdJdp9G03OUBWMyr6yVqTPg9Y62ziI7isa
 0+YKjwrzEQwKL0UfDdpXMc8sjPH8+4ScHUxcLSGDFg9zBdlGTU6PRScCbx8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_081622_366481_EA5B749F 
X-CRM114-Status: UNSURE (   8.21  )
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
Cc: linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> YueHaibing <yuehaibing@huawei.com> hat am 23. Januar 2019 um 08:05 geschrieben:
> 
> 
> Fix a static code checker warning:
> drivers/spi/spi-bcm2835aux.c:460
>  bcm2835aux_spi_probe() warn: passing zero to 'PTR_ERR'
> 
> In case of error, the function devm_clk_get() returns ERR_PTR()
> and not returns NULL.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
