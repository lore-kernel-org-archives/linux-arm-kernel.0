Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51B3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:40:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F2220675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HYTnt0Pc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kCRft6Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F2220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Ypg6ovmU5X9eUyONFGrSZu4HNC7l7ZD9Qteg2b+B+E=; b=HYTnt0PcSGpbwU
	qsfH++9zp2ykN6s4eMi3s840M5xVopX0O4zsZRps8uspz8CSJouKl8jQsKz5zvZoyO4TJ2hZPadFl
	i0OxOYzRTRDd/C+rZDrvSWzUF2XRqywQzvtraCVQXcYiwANPeZv1AJRjB//1rf1xWnKZJ3mi5UmRW
	r661tTFGJw9rcnesHitUzZXYKI8SBviSB10UcrgthlHCPlw/mY552inSiXCcVQp2ri1h8ti3Ng1W5
	zp6ja8eU/VGyudHcDnsKqJs0IV4fszfuWksMlKL8pqseLZuEXdPY9fMOHsVk9MX/qGQMsJ3YWQT7M
	Y5gULT3KCa2UhZrfDbww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gheJc-0002S5-3l; Thu, 10 Jan 2019 17:40:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gheJa-0000ya-G0; Thu, 10 Jan 2019 17:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
 From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sQwcQQHVJd43YSd7VheEcHtcIJvhVPnho8K9J7lDw/E=; b=kCRft6LuPcbQ91D0ygspja6iBC
 aMWH5wW6Jj7PAx8UGtIYFAUwNNkm011Ux0FnlhVhf36fXHqHL6wFAdVqTgDFSu+NpZopQqYvlExoJ
 +u23v/wcOon2YKsxsVykoc0Yf9CP1VoWl6nc3k6+T2983PB/V4gXogq6q0klmsKsWaX/f0wpCKF7B
 ezYQNwEUmQZRS/FFQF8tJU/oBdRAZEp3ap6WYeYwXZsJqhGaLIpn8fiqrQrJx0nzKKNwGfpNQJFDF
 JswjrNCwPyjkxfNjYLQKVQQbfpmMYjJ0iIhlvfXrxLysNHX2vuZLqOVY/sAZNaM8URjnjDsuytagJ
 7o27G/1g==;
Received: from skedge03.snt-world.com ([91.208.41.68])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghe8c-0000EE-1Y; Thu, 10 Jan 2019 17:29:04 +0000
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge03.snt-world.com (Postfix) with ESMTPS id 64DB267A887;
 Thu, 10 Jan 2019 18:28:58 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 10 Jan
 2019 18:28:58 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Thu, 10 Jan 2019 18:28:58 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Thread-Topic: [PATCH v6 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUpzP8UrlUpBv3BkeiEjKwk1C7CKWotMOA
Date: Thu, 10 Jan 2019 17:28:57 +0000
Message-ID: <dbb6ddc8-5939-3d4b-7031-931afa79fccb@kontron.de>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1546939346-20181-2-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1546939346-20181-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <B1A30D48233E2A4BA19CBDE5A99C26DA@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 64DB267A887.A076C
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
X-CRM114-CacheID: sfid-20190110_172902_197169_739ABD11 
X-CRM114-Status: GOOD (  29.50  )
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

my comments below are mainly about things I already mentioned in my 
review for v5 and about removing or simplifying some unnecessary or 
complex code.

Also as I gathered from your conversation with Boris, there's still a 
check for the length of the requested memory missing.

On 08.01.19 10:24, Yogesh Narayan Gaur wrote:
[...]
> +
> +static bool nxp_fspi_supports_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)
> +{
> +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> +	int ret;
> +
> +	ret = nxp_fspi_check_buswidth(f, op->cmd.buswidth);
> +
> +	if (op->addr.nbytes)
> +		ret |= nxp_fspi_check_buswidth(f, op->addr.buswidth);
> +
> +	if (op->dummy.nbytes)
> +		ret |= nxp_fspi_check_buswidth(f, op->dummy.buswidth);
> +
> +	if (op->data.nbytes)
> +		ret |= nxp_fspi_check_buswidth(f, op->data.buswidth);
> +
> +	if (ret)
> +		return false;
> +
> +	/*
> +	 * The number of instructions needed for the op, needs
> +	 * to fit into a single LUT entry.
> +	 */
> +	if (op->addr.nbytes +
> +	   (op->dummy.nbytes ? 1:0) +
> +	   (op->data.nbytes ? 1:0) > 6)
> +		return false;

Actually this check was only needed in the QSPI driver, as we were using 
  LUT_MODE and there we needed one instruction for each address byte. 
Here the number of instructions will always fit into one LUT entry.

Instead of this, a check for op->addr.nbytes > 4 (as already suggested 
in my comments for v5) would make more sense. So we can make sure that 
the address length passed in is supported (between 1 and 4 bytes).

> +
> +	/* Max 64 dummy clock cycles supported */
> +	if (op->dummy.buswidth &&
> +	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
> +		return false;
> +
> +	/* Max data length, check controller limits and alignment */
> +	if (op->data.dir == SPI_MEM_DATA_IN &&
> +	    (op->data.nbytes > f->devtype_data->ahb_buf_size ||
> +	     (op->data.nbytes > f->devtype_data->rxfifo - 4 &&
> +	      !IS_ALIGNED(op->data.nbytes, 8))))
> +		return false;
> +
> +	if (op->data.dir == SPI_MEM_DATA_OUT &&
> +	    op->data.nbytes > f->devtype_data->txfifo)
> +		return false;
> +
> +	return true;
> +}
> +
[...]
> +static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
> +{
> +	unsigned long rate = spi->max_speed_hz;
> +	int ret;
> +	uint64_t size_kb;
> +
> +	/*
> +	 * Return, if previously selected slave device is same as current
> +	 * requested slave device.
> +	 */
> +	if (f->selected == spi->chip_select)
> +		return;
> +
> +	/* Reset FLSHxxCR0 registers */
> +	fspi_writel(f, 0, f->iobase + FSPI_FLSHA1CR0);
> +	fspi_writel(f, 0, f->iobase + FSPI_FLSHA2CR0);
> +	fspi_writel(f, 0, f->iobase + FSPI_FLSHB1CR0);
> +	fspi_writel(f, 0, f->iobase + FSPI_FLSHB2CR0);
> +
> +	/* Assign controller memory mapped space as size, KBytes, of flash. */
> +	size_kb = FSPI_FLSHXCR0_SZ(f->memmap_phy_size);
> +
> +	switch (spi->chip_select) {
> +	case 0:
> +		fspi_writel(f, size_kb, f->iobase + FSPI_FLSHA1CR0);
> +		break;
> +	case 1:
> +		fspi_writel(f, size_kb, f->iobase + FSPI_FLSHA2CR0);
> +		break;
> +	case 2:
> +		fspi_writel(f, size_kb, f->iobase + FSPI_FLSHB1CR0);
> +		break;
> +	case 3:
> +		fspi_writel(f, size_kb, f->iobase + FSPI_FLSHB2CR0);
> +		break;
> +	}

The switch statement above can be replaced by:

fspi_writel(f, size_kb, f->iobase + FSPI_FLSHA1CR0 +
	    4 * spi->chip_select);

> +
> +	dev_dbg(f->dev, "Slave device [CS:%x] selected\n", spi->chip_select);
> +
> +	nxp_fspi_clk_disable_unprep(f);
> +
> +	ret = clk_set_rate(f->clk, rate);
> +	if (ret)
> +		return;
> +
> +	ret = nxp_fspi_clk_prep_enable(f);
> +	if (ret)
> +		return;
> +
> +	f->selected = spi->chip_select;
> +}
> +
> +static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
> +{
> +	u32 len = op->data.nbytes;
> +
> +	/* Read out the data directly from the AHB buffer. */
> +	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);
> +}
> +
> +static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
> +				 const struct spi_mem_op *op)
> +{
> +	void __iomem *base = f->iobase;
> +	int i, j, ret;
> +	int size, tmp, wm_size;
> +	u32 data = 0;
> +	u32 *txbuf = (u32 *) op->data.buf.out;

You can cast the u8 buffer to u32 and increment it by 1 in each cycle 
below, or you can just use the u8 buffer and align and increment by 8 as 
I did in my proposal for v5.
I still like my version better as it seems simpler and easier to 
understand ;)

> +
> +	/* clear the TX FIFO. */
> +	fspi_writel(f, FSPI_IPTXFCR_CLR, base + FSPI_IPTXFCR);
> +
> +	/* Default value of water mark level is 8 bytes. */
> +	wm_size = 8;
> +
> +	size = op->data.nbytes / wm_size;
> +	for (i = 0; i < size; i++) {
> +		/* Wait for TXFIFO empty */
> +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> +					   FSPI_INTR_IPTXWE, 0,
> +					   POLL_TOUT, true);
> +		WARN_ON(ret);
> +
> +		for (tmp = wm_size, j = 0; tmp > 0; tmp -= 4, j++)

I still think the inner loop should only be added when someone 
implements watermark levels other than 8. It is of no use at the moment 
and makes reading the code more difficult.
But if you insist on using it, please at least simplify the code.

What about:	for (j = 0; j < (wm_size / 4); j++)

> +			fspi_writel(f, *txbuf++, base + FSPI_TFDR + j * 4); > +
> +		fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR);
> +	}
> +
> +	size = op->data.nbytes % wm_size;
> +	if (size) {
> +		/* Wait for TXFIFO empty */
> +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> +					   FSPI_INTR_IPTXWE, 0,
> +					   POLL_TOUT, true);
> +		WARN_ON(ret);
> +
> +		for (tmp = size, j = 0; tmp > 0; tmp -= 4, j++) {

Same here:	for (j = 0; j < (size / 4); j++) {

> +			data = 0;
> +			memcpy(&data, txbuf++, 4);
> +			fspi_writel(f, data, base + FSPI_TFDR + j * 4);
> +		}
> +		fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR);
> +	}
> +}
> +
> +static void nxp_fspi_read_rxfifo(struct nxp_fspi *f,
> +			  const struct spi_mem_op *op)
> +{
> +	void __iomem *base = f->iobase;
> +	int i, j;
> +	int size, tmp_size, wm_size, ret;
> +	u32 tmp = 0;
> +	u8 *buf = op->data.buf.in;
> +	u32 len = op->data.nbytes;
> +
> +	/* Default value of water mark level is 8 bytes. */
> +	wm_size = 8;
> +
> +	while (len > 0) {

What is this outer loop good for? Below you are first reading aligned to 
wm_size and then the remaining bytes. Why would you need to repeat that?
It looks like the loop will always be executed only once.

> +		size = len / wm_size;
> +		for (i = 0; i < size; i++) {
> +			/* Wait for RXFIFO available */
> +			ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> +						   FSPI_INTR_IPRXWA, 0,
> +						   POLL_TOUT, true);
> +			WARN_ON(ret);
> +
> +			for (tmp_size = wm_size, j = 0; tmp_size > 0;
> +			     tmp_size -= 4, j++, buf += 4) {

What about:		for (j = 0; j < (wm_size / 4); j++, buf += 4) {

> +				tmp = fspi_readl(f, base + FSPI_RFDR + j * 4);
> +				memcpy(buf, &tmp, 4);
> +			}
> +			/* move the FIFO pointer */
> +			fspi_writel(f, FSPI_INTR_IPRXWA, base + FSPI_INTR);
> +			len -= wm_size;
> +		}
> +
> +		size = len % wm_size;
> +		if (size) {
> +			/* Wait for RXFIFO available */
> +			ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> +						   FSPI_INTR_IPRXWA, 0,
> +						   POLL_TOUT, true);
> +			WARN_ON(ret);
> +
> +			for (j = 0; len > 0; len -= size, j++, buf += size) {
> +				tmp = fspi_readl(f, base + FSPI_RFDR + j * 4);
> +				size = len < 4 ? len : 4;

What about:			size = min(len, 4);

> +				memcpy(buf, &tmp, size);
> +			}
> +		}
> +
> +		/* invalid the RXFIFO */
> +		fspi_writel(f, FSPI_IPRXFCR_CLR, base + FSPI_IPRXFCR);
> +		/* move the FIFO pointer */
> +		fspi_writel(f, FSPI_INTR_IPRXWA, base + FSPI_INTR);
> +	}
> +}

Thanks,
Frieder
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
