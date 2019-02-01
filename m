Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36632C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054652086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BKdzPFYC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OptQj0lK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054652086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jrzHm+D5Kc02H8pvKmWylzlf1+5ILEevqQn+y2RxZwM=; b=BKdzPFYCKeLFkg
	P8TI8RaK+Y21+yob/5F+5UrqxI42CgqsHveqMpv+2ndk/t4yg/KDoKgW3DiHfqnNYrO/UalOwlXgY
	K8DN54enMSSHxoQbublOpo5k52cSyjje7KQtNrmpuS7jGvoBZXH7IJzDqY2d5v7YU888yUN39WsTJ
	hmzsSJnvQCySO8tac3peB6qOkxJp24t4AB4+trbWo5TesoEHcHI23z7klS7+BSb2R0I4FJMf8Yqmd
	UamR2sQ3EOgYIZbp+7X7YBiKGIQDibKC/yMm2asVHG3KnbS9+UuJBWZVvethDKJRkh6zTM/cRNg2x
	6irSq5oMXsT8PTIlna7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb4t-0001jH-3U; Fri, 01 Feb 2019 15:50:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpb0K-0005Hv-Pe; Fri, 01 Feb 2019 15:45:55 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 80B8D20855;
 Fri,  1 Feb 2019 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549035920;
 bh=1K/k12ABv52m0qd2+Gjk2G3Nr+pRmZ0USUlT5Q1Pg30=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OptQj0lKWEsy67XyHkIXeh9Sw1fvpLZ6rXPJxaZtCTetGDkppo/9YNmrFg9HtDp5y
 fmVlPt5pBcKiN04zMZcHPMLp/WOk9pl1KGRLr/Y35+CEZXqwKk9HEnyQUmCSTuVrEx
 xOidvpWILdjEZeLozsotqRPtTo3ThLNp0XlQ9wZE=
Date: Fri, 1 Feb 2019 16:45:08 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Message-ID: <20190201164508.4d1b214d@bbrezillon>
In-Reply-To: <8b935a95-0aaa-3430-e2c2-f5793fd9cf11@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
 <20190131161515.21605-11-tudor.ambarus@microchip.com>
 <20190131173207.56481a42@bbrezillon>
 <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
 <20190201085739.775add3f@bbrezillon>
 <8b935a95-0aaa-3430-e2c2-f5793fd9cf11@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074521_214226_27E851D0 
X-CRM114-Status: UNSURE (   8.59  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 1 Feb 2019 14:49:27 +0000
<Tudor.Ambarus@microchip.com> wrote:

> 
> >>>> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)  
> > 
> > And this one would be
> > 
> > define QSPI_IFR_SAM9X60_READ_TRSFR		BIT(24)  
> 
> I prefer letting this bit named as in the datasheet, QSPI_IFR_APBTFRTYP_READ,
> and change it if future versions of the IP will modify its sense. It is a READ
> transfer done on APB, it is more generic this way. If you have a strong opinion
> on this, please let me know.

As you wish.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
