Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14A3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:35:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15552082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TtX8CsN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15552082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z6MD91Gq7Z/rGeBgw0ws69vd7ZiFhWdM958y7uR8Ihg=; b=TtX8CsN5YueP12
	QTuON7JdgWQc37dE1b4q2dSULqzgXuQLPwx0wVXmZ2WbN/wBYAV2iXhr5N8Kr9vuNZkph7eBrmTY8
	IudYnKl5K+tJyDhl76Q2tdYTkYIelc7ge0xHM+aELVbRoZdukKyuW8au0bAi7ephhQ5GjeTtsYtlC
	T+nIL2cx1Nj4M9GAmL7Ny6GMNq0Grie/9ybz3UC5dFiZGwes+JxDZHyLQOhafvPaDWWvt1Brs18oR
	Ksq2fTLSrnJZjPj+KxuKInqfKSe8k7N6TUJUdxgizB7ywba2P+bZmtdtcj+vX4x36NGUs6B08LQDV
	LIczA3mRRz0NedLpG0rA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIum-0002W7-Ip; Mon, 10 Dec 2018 10:35:52 +0000
Received: from skedge04.snt-world.com ([91.208.41.69])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIuj-0002VD-BL; Mon, 10 Dec 2018 10:35:51 +0000
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id 5158167A868;
 Mon, 10 Dec 2018 11:35:36 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 10 Dec
 2018 11:35:35 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Mon, 10 Dec 2018 11:35:35 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Thread-Topic: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUfZ16K+V2Xzw84ki+MmwTwSKgB6VxfoaAgAZOooCAAA8EgA==
Date: Mon, 10 Dec 2018 10:35:35 +0000
Message-ID: <b616a9c7-40cf-d2da-b164-0d56a82c6cbc@kontron.de>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
 <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <09BA064FA0EDFB4488DEE315E521920F@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 5158167A868.AF09A
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
 computersforpeace@gmail.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, mark.rutland@arm.com, robh@kernel.org,
 shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_023549_719928_308FA7AB 
X-CRM114-Status: GOOD (  16.10  )
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
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Yogesh,

On 10.12.18 10:41, Yogesh Narayan Gaur wrote:
[...]>>> +
>>> +static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>>> +				 const struct spi_mem_op *op)
>>> +{
>>> +	void __iomem *base = f->iobase;
>>> +	u32 lutval[4] = {};
>>> +	int lutidx = 1, i;
>>> +
>>> +	/* cmd */
>>> +	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
>>> +			     op->cmd.opcode);
>>> +
>>> +	/* addr bus width */

This comment should match the code below. So maybe only "addr" should be 
enough.

>>> +	if (op->addr.nbytes) {
>>> +		u32 addrlen = 0;
>>> +
>>> +		switch (op->addr.nbytes) {
>>> +		case 1:
>>> +			addrlen = ADDR8BIT;
>>> +			break;
>>> +		case 2:
>>> +			addrlen = ADDR16BIT;
>>> +			break;
>>> +		case 3:
>>> +			addrlen = ADDR24BIT;
>>> +			break;
>>> +		case 4:
>>> +			addrlen = ADDR32BIT;
>>> +			break;
>>> +		default:
>>> +			dev_err(f->dev, "In-correct address length\n");
>>> +			return;
>>> +		}
>>
>> You don't need to validate op->addr.nbytes here, this is already done in
>> nxp_fspi_supports_op().
> 
> Yes, I need to validate op->addr.nbytes else LUT would going to be programmed for 0 addrlen.
> I have checked this on the target.
> 
>>
>>> +
>>> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
>>> +					      LUT_PAD(op->addr.buswidth),
>>> +					      addrlen);
>>
>> You can also just remove the whole switch statement above and use this:
>>
>> lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
>> 			      LUT_PAD(op->addr.buswidth),
>> 			      op->addr.nbytes * 8);
>>
> Ok, would include in next version.
> 
>>> +		lutidx++;
>>> +	}
>>> +
>>> +	/* dummy bytes, if needed */
>>> +	if (op->dummy.nbytes) {
>>> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
>>> +		/*
>>> +		 * Due to FlexSPI controller limitation number of PAD for
>> dummy
>>> +		 * buswidth needs to be programmed as equal to data buswidth.
>>> +		 */
>>> +					      LUT_PAD(op->data.buswidth),
>>> +					      op->dummy.nbytes * 8 /
>>> +					      op->dummy.buswidth);
>>> +		lutidx++;
>>> +	}
>>> +
>>> +	/* read/write data bytes */
>>> +	if (op->data.nbytes) {
>>> +		lutval[lutidx / 2] |= LUT_DEF(lutidx,
>>> +					      op->data.dir ==
>> SPI_MEM_DATA_IN ?
>>> +					      LUT_NXP_READ : LUT_NXP_WRITE,
>>> +					      LUT_PAD(op->data.buswidth),
>>> +					      0);
>>> +		lutidx++;
>>> +	}
>>> +
>>> +	/* stop condition. */
>>> +	lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_STOP, 0, 0);
>>> +
>>> +	/* unlock LUT */
>>> +	fspi_writel(f, FSPI_LUTKEY_VALUE, f->iobase + FSPI_LUTKEY);
>>> +	fspi_writel(f, FSPI_LCKER_UNLOCK, f->iobase + FSPI_LCKCR);
>>> +
>>> +	/* fill LUT */
>>> +	for (i = 0; i < ARRAY_SIZE(lutval); i++)
>>> +		fspi_writel(f, lutval[i], base + FSPI_LUT_REG(i));
>>> +
>>> +	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x]\n",
>>> +		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3]);
>>> +
>>> +	/* lock LUT */
>>> +	fspi_writel(f, FSPI_LUTKEY_VALUE, f->iobase + FSPI_LUTKEY);
>>> +	fspi_writel(f, FSPI_LCKER_LOCK, f->iobase + FSPI_LCKCR); }
[...]
>>> +
>>> +static int nxp_fspi_exec_op(struct spi_mem *mem, const struct
>>> +spi_mem_op *op) {
>>> +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
>>> +	int err = 0;
>>> +
>>> +	mutex_lock(&f->lock);
>>> +
>>> +	/* Wait for controller being ready. */
>>> +	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0,
>>> +				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
>>> +	WARN_ON(err);
>>> +
>>> +	nxp_fspi_select_mem(f, mem->spi);
>>> +
>>> +	nxp_fspi_prepare_lut(f, op);
>>> +	/*
>>> +	 * If we have large chunks of data, we read them through the AHB bus
>>> +	 * by accessing the mapped memory. In all other cases we use
>>> +	 * IP commands to access the flash.
>>> +	 */
>>> +	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
>>> +	    op->data.dir == SPI_MEM_DATA_IN) {
>>> +		nxp_fspi_read_ahb(f, op);
>>> +	} else {
>>> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
>>> +			nxp_fspi_fill_txfifo(f, op);
>>> +
>>> +		err = nxp_fspi_do_op(f, op);
>>> +
>>> +		/* Invalidate the data in the AHB buffer. */
>>> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
>>> +			nxp_fspi_invalid(f);
>>
>> E.g. in case of an erase operation or a NAND load page operation, the
>> invalidation is not triggered, but flash/buffer contents have changed.
>> So I'm not sure if this is enough...
> Ok, would change this and have invalidate for all operations.

Maybe you can find out the correct way through testing with NOR and NAND.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
