Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5580C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:55:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A739E2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RCjD5xfF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6AEIqJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A739E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zdjU5TyL5jkiF4jk+SlWMx1RoDSZtPe7ns/eUlKRLhs=; b=RCjD5xfFObkrCT
	MKOzjFSc1ZM4qR/60nzHS9vLALms6wB48nspdC2Y4gSG2hZlWqltEoT3O9xCOJXi0c9zYkY7CLkZb
	dyVFqDYshupdQpeZqxxLaJcX8Q5Uoa5hT2PC0c/s1bLoFg4hjs64uSPfKv0tobKDyXaEeAVSwI/QA
	Pow5Ko9y412BfrBJxljs6vwfTFh5DGJ0W3qA635NwWcaB+Jb0jM2u7N2CxM7bczM7CZI5g0htT4V+
	YeBsUBQcnWlygUMKJOOUxKhVqlW8opknPnNoxdYznKMC7Y+UQWwyTvMDRqLMhodBFJxKmoRgX+48I
	aLwRCVZraTw+S9F8qFOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpAwO-0006h8-Kl; Thu, 31 Jan 2019 11:55:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpAwL-0006gi-Jq; Thu, 31 Jan 2019 11:55:30 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9549B2087F;
 Thu, 31 Jan 2019 11:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548935729;
 bh=ljvHK5+CxgCaWGa66nNZEVCCE59QxWDz8dsWIFaljuM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=c6AEIqJ3TZw6xN3zH5OQzsXGnZXJBbnJlBoMsHzcIydnfNwRLu6a4SfdZ60MeiBtS
 4jKAaqUtyjZ9EDCGSW0OIaUUoXsOi+qiVciXQKQNEawdpwrGkF8HxK+ZNIL4gdtsDL
 SLFggB2qZEg2X1oXRQxTneON4QGU490KviGVV7Tk=
Date: Thu, 31 Jan 2019 12:55:19 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Message-ID: <20190131125504.3eff449d@bbrezillon>
In-Reply-To: <20190130150818.24902-10-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-10-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_035529_673891_9601403D 
X-CRM114-Status: GOOD (  10.06  )
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

> +
> +static int atmel_sam9x60_qspi_set_cfg(struct atmel_qspi *aq,
> +				      const struct spi_mem_op *op,
> +				      struct atmel_qspi_cfg *cfg)
> +{
> +	int ret = atmel_qspi_set_mode(cfg, op);
> +
> +	if (ret)
> +		return ret;
> +
> +	cfg->icr = QSPI_ICR_INST(op->cmd.opcode);
> +
> +	if (!op->addr.nbytes) {
> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_REG;
> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_WRITE;
> +		else
> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
> +	} else {
> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_MEM;

Why do you use a MEM transfer here? What's the difference with a
regular transfer?

> +	}
> +
> +	/* Set data enable */
> +	if (op->data.nbytes)
> +		cfg->ifr |= QSPI_IFR_DATAEN;
> +
> +	ret = atmel_qspi_set_address_mode(cfg, op);
> +	if (ret)
> +		return ret;
>  
>  	/* Clear pending interrupts */
>  	(void)atmel_qspi_readl(aq, QSPI_SR);
>  
>  	/* Set QSPI Instruction Frame registers */
> -	atmel_qspi_writel(aq, QSPI_IAR, iar);
> -	atmel_qspi_writel(aq, QSPI_ICR, icr);
> -	atmel_qspi_writel(aq, QSPI_IFR, ifr);
> +	atmel_qspi_writel(aq, QSPI_IAR, cfg->iar);
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		atmel_qspi_writel(aq, QSPI_ICR, cfg->icr);
> +	else
> +		atmel_qspi_writel(aq, QSPI_RICR, cfg->icr);
> +	atmel_qspi_writel(aq, QSPI_IFR, cfg->ifr);
> +
> +	return 0;
> +}


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
