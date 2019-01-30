Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14501C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:43:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0BA21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OR4jiI3m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZNG4yQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0BA21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2teDxavixXGUw939lBPC/7TRRB1a8HocIABCbN0+1VY=; b=OR4jiI3mDGq7kZ
	qlGuOdaLXFUYpIClMdEhUY/YeA/MesP163/GRBsBrZw1fHsJCNRY//25R8l7BrcCKmeiJ3G44x4K/
	BLY09vcfR+LhSQcY0mMILtdcJzzNCNJk9Lt1TH60cyxEc6zlVnGomBoTrV5uU0jl2wDgUYTxXU03v
	D2pwi0d6y92zjn3q0xqcxKBmlAlHF0U1fnux3E+g9yBWLQQgkBEDT1KmP8uHcgSo3fXjH1WXRGARy
	zONFHJuSG9LevwKIHrAUbeeAjOOSLSABMfBTEO6+yybB+q+QKLUR4VtVd1Tul+XbaXCKlp4JNDEV5
	Zc0vkNId22bQ2CuX+ZNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gottX-0001EL-NK; Wed, 30 Jan 2019 17:43:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gottT-0001Df-WA; Wed, 30 Jan 2019 17:43:25 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 38D6E2087F;
 Wed, 30 Jan 2019 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548870203;
 bh=3XBGqaxbIgirgGdiwL2FpJd4AZ+2J/mt9qBsXw7eYSs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MZNG4yQGUa+lUxsCA/fw9zcPYVkyoxVdiFJfMqbl7klNSZ8SzkkgavUmTo7bC+quu
 2BXZZAiNHyHGfji9HE/JWb6YRlXhhxe/1hGuEacutxk//vsBkiM1oRPvsAE7hXewUv
 pp1+i8nlTK8nNJBlSfOvAIv2JFZu6D41PmtvBMME=
Date: Wed, 30 Jan 2019 18:43:13 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Message-ID: <20190130184313.281f5374@bbrezillon>
In-Reply-To: <20190130150818.24902-10-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-10-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_094324_052325_0AA7669C 
X-CRM114-Status: GOOD (  10.78  )
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
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 15:08:47 +0000
<Tudor.Ambarus@microchip.com> wrote:

> +static int atmel_sam9x60_qspi_clk_prepare_enable(struct atmel_qspi *aq)
> +{
> +	struct device *dev = &aq->pdev->dev;
> +	int ret;
> +
> +	if (!aq->clk) {
> +		/* Get the peripheral clock */
> +		aq->clk = devm_clk_get(dev, "pclk");
> +		if (IS_ERR(aq->clk)) {
> +			dev_err(dev, "missing peripheral clock\n");
> +			return PTR_ERR(aq->clk);
> +		}
> +	}
> +
> +	if (!aq->qspick) {
> +		/* Get the QSPI system clock */
> +		aq->qspick = devm_clk_get(dev, "qspick");
> +		if (IS_ERR(aq->qspick)) {
> +			dev_err(dev, "missing system clock\n");
> +			return PTR_ERR(aq->qspick);
> +		}
> +	}

Move the devm_clk_get() calls to the probe path instead of doing it at
prepare time, and you can make it generic for both compats with
something like:

	aq->clk = devm_clk_get(dev, "pclk");
	if (IS_ERR(aq->clk))
		aq->clk = devm_clk_get(dev, NULL);

	if (IS_ERR(aq->clk))
		return PTR_ERR(aq->clk);

	if (aq->caps->qspick_required) {
		aq->qspick = devm_clk_get(dev, "qspick");
		if (IS_ERR(aq->qspick)) {
			return PTR_ERR(aq->qspick);
	}

> +
> +	/* Enable the peripheral clock */
> +	ret = clk_prepare_enable(aq->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable the peripheral clock\n");
> +		return ret;
> +	}
> +
> +	/* Enable the QSPI system clock */
> +	ret = clk_prepare_enable(aq->qspick);
> +	if (ret) {
> +		dev_err(dev, "failed to enable the QSPI system clock\n");
> +		clk_disable_unprepare(aq->clk);
> +	}

Again, you can make the enable function generic since
clk_prepare_enable(NULL) is a NO-OP that returns 0 and aq->qspick will
be NULL when it's not required.

> +
> +	return ret;
> +}
> +
> +static void atmel_sam9x60_qspi_clk_disable_unprepare(struct atmel_qspi *aq)
> +{
> +	clk_disable_unprepare(aq->qspick);
> +	clk_disable_unprepare(aq->clk);

Ditto.

> +}

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
