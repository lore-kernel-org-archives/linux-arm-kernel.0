Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF0BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:13:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEA02087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lFxVyuwP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEry/j8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEA02087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+VVXfZSB7OrHLUlmhfhRgi0piygA28+sMZCH6IwjHek=; b=lFxVyuwPxzaJd9
	8CHVTq2bMJc5DKvO3b6PJQ+JqA6D4p7drfoKSQwzB9O0eL4E+u9CG6gjbEQZWFgTcafzJWlWMphQL
	Lc4j9qx7Mke6sfPXgeG02Z4QOm5XAhq+bVfSadHJLQEM8RKX1Q4x7AOsPJtGgbbGOLZOkCGwIVDyg
	R7HoRcUx05CrlHmz5hB28WqJ4Duev+ka2QC0sMPwYzL2ZCKKvpxa8FNZnfNK+qlsJWLsiGZCa+7vc
	6ehsuvIf+x57ka9Q2ijTD1Qw+WnKxUIj3GCk1eZZxacaU5ITrPX2JF59NBRzzTaoL1/cEEDTNc6dG
	yUKZDiTR9SugFodJ61eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpC9F-0008IA-77; Thu, 31 Jan 2019 13:12:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpC9C-0008Hk-Ds; Thu, 31 Jan 2019 13:12:51 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E072F2087F;
 Thu, 31 Jan 2019 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548940368;
 bh=l+hMYyleZdMvs+nKECj68JvNPAZLYxFaw+dcGnDGAs4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gEry/j8ctx5y7ogEtPv/kKAh/Aq9UGxP7DPURymMwibOP2Q7787qslVCFEy6508TY
 +1u1FJKhQtXe4k5HG8Nv4Rt7CJQTvTU0K++ggUmIqJR1zHbqsYkqcPwD6K+kdaoMXu
 thKSvbyp7NEUh+nWAqQLxn6qvV2nS9iWMqC/cSh4=
Date: Thu, 31 Jan 2019 14:12:35 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Message-ID: <20190131141235.418e8e9c@bbrezillon>
In-Reply-To: <5a91b6b2-0fed-f411-6e96-568e610f15fa@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-10-tudor.ambarus@microchip.com>
 <20190131125504.3eff449d@bbrezillon>
 <5a91b6b2-0fed-f411-6e96-568e610f15fa@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_051250_484289_561ADAED 
X-CRM114-Status: GOOD (  16.75  )
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
 linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 31 Jan 2019 12:40:04 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 01/31/2019 01:55 PM, Boris Brezillon wrote:
> > On Wed, 30 Jan 2019 15:08:47 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> +
> >> +static int atmel_sam9x60_qspi_set_cfg(struct atmel_qspi *aq,
> >> +				      const struct spi_mem_op *op,
> >> +				      struct atmel_qspi_cfg *cfg)
> >> +{
> >> +	int ret = atmel_qspi_set_mode(cfg, op);
> >> +
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	cfg->icr = QSPI_ICR_INST(op->cmd.opcode);
> >> +
> >> +	if (!op->addr.nbytes) {
> >> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_REG;
> >> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> >> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_WRITE;
> >> +		else
> >> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
> >> +	} else {
> >> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_MEM;  
> > 
> > Why do you use a MEM transfer here? What's the difference with a
> > regular transfer?  
> 
> QSPI_IFR_TFRTYP_TRSFR_MEM must be set when one wants to read/write in the serial
> memory, and particularly a memory data.
> 
> QSPI_IFR_TFRTYP_TRSFR_REG must be set when one wants to read or write to serial
> memory, but not a memory data.
> Read examples: JEDEC_ID or QSPI_SR
> Write examples: writing the configuration or the QSPI_SR.
> 
> Does this answers your question?

Not really :-). From the SPI bus perspective, there's no difference
between a read/write from/to actual memory blocks or a read/write
reg/param-page, so there must be something different on the controller
side. I think regular transfers should work for anything, which is why
I initially suggested to use that in the ->exec_op() implementation.
If memory accesses are optimized somehow and do not work for all
accesses, then we should keep them for the dirmap implementation.

After reading the sama5d2 datasheet, I have the feeling that the only
difference is the fact that the address is directly extracted from the
AHB window offset when using mem accesses (instead of being taken from
the IAR register), plus the possibility to enable the data
scrambler/randomize.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
