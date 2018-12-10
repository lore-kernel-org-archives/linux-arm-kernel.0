Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779C6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:41:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4805D2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D15BCKkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4805D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ivq/v0aGhO+pYPSvF5+LRqXIG07ZjM9v2UBgL9tTlH8=; b=D15BCKkhJEfm7+
	QDcH8Iq4TxMGXThbQx+myjRWYNR3ag3RXfZFCKLIH3lcnWR1et9xwAtmehJrLOp4Xi6pS0MJvR6v6
	a4DpMNv/c4vpJrYZaAxQUzp8jKlw1mLwcSlFo9jtdPyz8DEJeIVPhAyKvesOdzs+xWbtImx1Zk+Z5
	IyiMRAcJXVmx1o4mYeBXtqm0GXKjsfMjRCi0nu9tjHAx73XJ/OGAN0dXuxXi1hknAInmbXB7qAHTp
	8PsJCBCqy9DaIyHd0ghSGIguhszW1zWvn0jCZYzk2m/ufrNBTFKosw24zveQd4M3JtC9pPgIZaOKs
	EaaL+4awWHWj7Rzymbqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJ0O-0005Em-Jr; Mon, 10 Dec 2018 10:41:40 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJ0L-0005Dz-6H; Mon, 10 Dec 2018 10:41:38 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id EF34C20CE3; Mon, 10 Dec 2018 11:41:25 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
 by mail.bootlin.com (Postfix) with ESMTPSA id A2F972037D;
 Mon, 10 Dec 2018 11:41:15 +0100 (CET)
Date: Mon, 10 Dec 2018 11:41:15 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Message-ID: <20181210114115.3f3c1958@bbrezillon>
In-Reply-To: <b616a9c7-40cf-d2da-b164-0d56a82c6cbc@kontron.de>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
 <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <b616a9c7-40cf-d2da-b164-0d56a82c6cbc@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_024137_369026_0673847D 
X-CRM114-Status: GOOD (  14.40  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 10:35:35 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> >>> +
> >>> +static int nxp_fspi_exec_op(struct spi_mem *mem, const struct
> >>> +spi_mem_op *op) {
> >>> +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> >>> +	int err = 0;
> >>> +
> >>> +	mutex_lock(&f->lock);
> >>> +
> >>> +	/* Wait for controller being ready. */
> >>> +	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0,
> >>> +				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
> >>> +	WARN_ON(err);
> >>> +
> >>> +	nxp_fspi_select_mem(f, mem->spi);
> >>> +
> >>> +	nxp_fspi_prepare_lut(f, op);
> >>> +	/*
> >>> +	 * If we have large chunks of data, we read them through the AHB bus
> >>> +	 * by accessing the mapped memory. In all other cases we use
> >>> +	 * IP commands to access the flash.
> >>> +	 */
> >>> +	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
> >>> +	    op->data.dir == SPI_MEM_DATA_IN) {
> >>> +		nxp_fspi_read_ahb(f, op);
> >>> +	} else {
> >>> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> >>> +			nxp_fspi_fill_txfifo(f, op);
> >>> +
> >>> +		err = nxp_fspi_do_op(f, op);
> >>> +
> >>> +		/* Invalidate the data in the AHB buffer. */
> >>> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> >>> +			nxp_fspi_invalid(f);  
> >>
> >> E.g. in case of an erase operation or a NAND load page operation, the
> >> invalidation is not triggered, but flash/buffer contents have changed.
> >> So I'm not sure if this is enough...  
> > Ok, would change this and have invalidate for all operations.  
> 
> Maybe you can find out the correct way through testing with NOR and NAND.

Or just invalidate the buffer every time you're doing a read through the
AHB. This should always work.

I also think we should quickly move to a model where AHB accesses are
reserved for dirmap, and regular spi-mem op are limited to non-ahb
reads.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
