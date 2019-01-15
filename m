Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E0BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:35:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13E520651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IYg2KQxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13E520651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pcCZEoUUvuQYW9OyuYGN4AoCP3bwAut5AcmUSeJCxLg=; b=IYg2KQxe5LA3+u
	yxjZRfeDVLgWMojxvJ2Dx6XnXzlp8X/CG8NpOR9qleVgOrisswXrC/11iHkQxrmYxTdwKFOOZ56kU
	GcRFEpga3YgdakGSfm+jl/XtmHzuTbkL2l4cgXbSR1Wsc3dOkVbe4Tx+FFYPD2ld3DkKOEEaAOpLS
	ZYw9gUXTtytsX9BZsPlAGSM/fVHOA0lw/lESzIrsdwNWClO7Ma+py0G8CcdV3r3MAILZjcnbvpXtm
	3q1x65IIy41oNju/b+YP4Ch3ZUqbZRuG9IhSTtQ8kVy+B7VmzboWodKIITBEE7S2DBfT0ivZoUn4c
	h9JxZ6gMWOgzpkeGqb6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjM4P-000143-IX; Tue, 15 Jan 2019 10:35:45 +0000
Received: from skedge03.snt-world.com ([91.208.41.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjM4L-00013T-6s; Tue, 15 Jan 2019 10:35:43 +0000
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge03.snt-world.com (Postfix) with ESMTPS id 6378567A649;
 Tue, 15 Jan 2019 11:35:36 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 15 Jan
 2019 11:35:36 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 15 Jan 2019 11:35:35 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Thread-Topic: [PATCH v7 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUrLfNlhnCm0z0KUqen764jAZScKWwEeWA
Date: Tue, 15 Jan 2019 10:35:35 +0000
Message-ID: <7b9a91f5-7b80-85b3-c8c2-82436d89b195@kontron.de>
References: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547545697-4042-2-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547545697-4042-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <42DA41C8871B404AB70BFAC3A8A144A7@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 6378567A649.A10D0
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
X-CRM114-CacheID: sfid-20190115_023541_575796_F8566EF3 
X-CRM114-Status: GOOD (  27.00  )
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

On 15.01.19 10:50, Yogesh Narayan Gaur wrote:
> - Add driver for NXP FlexSPI host controller
> 
> (0) What is the FlexSPI controller?
>   FlexSPI is a flexsible SPI host controller which supports two SPI
>   channels and up to 4 external devices. Each channel supports
>   Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional
>   data lines) i.e. FlexSPI acts as an interface to external devices,
>   maximum 4, each with up to 8 bidirectional data lines.
> 
>   It uses new SPI memory interface of the SPI framework to issue
>   flash memory operations to up to four connected flash
>   devices (2 buses with 2 CS each).
> 
> (1) Tested this driver with the mtd_debug and JFFS2 filesystem utility
>   on NXP LX2160ARDB and LX2160AQDS targets.
>   LX2160ARDB is having two NOR slave device connected on single bus A
>   i.e. A0 and A1 (CS0 and CS1).
>   LX2160AQDS is having two NOR slave device connected on separate buses
>   one flash on A0 and second on B1 i.e. (CS0 and CS3).
>   Verified this driver on following SPI NOR flashes:
>      Micron, mt35xu512ab, [Read - 1 bit mode]
>      Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> 
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v7:
> - Add func pointer for '.get_name' for struct spi_controller_mem_ops
> - Add input address range check as per controller memory mapped space
> - Update _fill_txfifo/_read_rxfifo funcs as per Frieder review comments
> Changes for v6:
> - Rebase on top of v5.0-rc1
> - Updated as per Frieder review comments and perform code cleanup
> - Updated _fill_txfifo/_read_rxfifo func write/read logic
> Changes for v5:
> - Rebase on top of v4.20-rc2
> - Modified fspi_readl_poll_tout() as per review comments
> - Arrange header file in alphabetical order
> - Removed usage of read()/write() function callback pointer
> - Add support for 1 and 2 byte address length
> - Change Frieder e-mail to new e-mail address
> Changes for v4:
> - Incorporate Boris review comments
>    * Use readl_poll_timeout() instead of busy looping.
>    * Re-define register masking as per comment.
>    * Drop fspi_devtype enum.
> Changes for v3:
> - Added endianness flag in platform specific structure instead of DTS.
> - Modified nxp_fspi_read_ahb(), removed remapping code.
> - Added Boris and Frieder as Author and provided reference of spi-fsl-qspi.c
> Changes for v2:
> - Incorporated Boris review comments.
> - Remove dependency of driver over connected flash device size.
> - Modified the logic to select requested CS.
> - Remove SPI-Octal Macros.
> 
>   drivers/spi/Kconfig        |   10 +
>   drivers/spi/Makefile       |    1 +
>   drivers/spi/spi-nxp-fspi.c | 1105 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 1116 insertions(+)
>   create mode 100644 drivers/spi/spi-nxp-fspi.c
> 
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
> +	 * The number of address bytes should be equal to and less than 4bytes.

Nitpick: use "or" instead of "and", add a space between "4" and "bytes".

> +	 */
> +	if (op->addr.nbytes > 4)
> +		return false;
> +
> +	/*
> +	 * If requested address value is greater than controller assigned
> +	 * memory mapped space, return error as it didn't fit in the range
> +	 * of assigned address space.
> +	 */
> +	if (op->addr.val >= f->memmap_phy_size)
> +		return false;
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
[...]
> +static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
> +				 const struct spi_mem_op *op)
> +{
> +	void __iomem *base = f->iobase;
> +	int i, ret;
> +
> +	/* clear the TX FIFO. */
> +	fspi_writel(f, FSPI_IPTXFCR_CLR, base + FSPI_IPTXFCR);
> +
> +	/*
> +	 * Default value of water mark level is 8 bytes, hence in single
> +	 * write request controller can write max 8 bytes of data.
> +	 */
> +
> +	for (i = 0; i < ALIGN_DOWN(op->data.nbytes, 8); i += 8) {
> +		/* Wait for TXFIFO empty */
> +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> +					   FSPI_INTR_IPTXWE, 0,
> +					   POLL_TOUT, true);
> +		WARN_ON(ret);
> +
> +		fspi_writel(f, *(u32 *) ((u8 *)op->data.buf.out + i),
> +			    base + FSPI_TFDR);
> +		fspi_writel(f, *(u32 *) ((u8 *)op->data.buf.out + i + 4),
> +			    base + FSPI_TFDR + 4);

Nitpick: Add a "u8 *buf = (u8 *)op->data.buf.out" to the top of the 
function and use it here...

> +		fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR);
> +	}
> +
> +	if (i < op->data.nbytes) {
> +		u32 data = 0;
> +		int j;
> +		/* Wait for TXFIFO empty */
> +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> +					   FSPI_INTR_IPTXWE, 0,
> +					   POLL_TOUT, true);
> +		WARN_ON(ret);
> +
> +		for (j = 0; j < ALIGN(op->data.nbytes - i, 4); j += 4) {
> +			memcpy(&data, op->data.buf.out + i + j, 4);

...and also here.

> +			fspi_writel(f, data, base + FSPI_TFDR + j);
> +		}
> +		fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR);
> +	}
> +}
> +
> +static void nxp_fspi_read_rxfifo(struct nxp_fspi *f,
> +			  const struct spi_mem_op *op)
> +{
> +	void __iomem *base = f->iobase;
> +	int i, ret;
> +	int len = op->data.nbytes;
> +	u8 *buf = (u8 *) op->data.buf.in;
> +
> +	/*
> +	 * Default value of water mark level is 8 bytes, hence in single
> +	 * read request controller can read max 8 bytes of data.
> +	 */
> +	for (i = 0; i < ALIGN_DOWN(len, 8); i += 8) {
> +		/* Wait for RXFIFO available */
> +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> +					   FSPI_INTR_IPRXWA, 0,
> +					   POLL_TOUT, true);
> +		WARN_ON(ret);
> +
> +		*(u32 *)(buf + i) = fspi_readl(f, base + FSPI_RFDR);
> +		*(u32 *)(buf + i + 4) = fspi_readl(f, base + FSPI_RFDR + 4);
> +		/* move the FIFO pointer */
> +		fspi_writel(f, FSPI_INTR_IPRXWA, base + FSPI_INTR);
> +	}
> +
> +	if (i < len) {
> +		u32 tmp;
> +		int size, j;
> +
> +		buf = op->data.buf.in + i;
> +		/* Wait for RXFIFO available */
> +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> +					   FSPI_INTR_IPRXWA, 0,
> +					   POLL_TOUT, true);
> +		WARN_ON(ret);
> +
> +		len = op->data.nbytes - i;
> +		for (j = 0; j < (ALIGN(len, 4))/4; j++, buf += size) {
> +			tmp = fspi_readl(f, base + FSPI_RFDR + j * 4);
> +			size = min(len, 4);
> +			memcpy(buf, &tmp, size);
> +		}

In the second iteration of this loop, the calculation of size seems 
wrong, as len has not changed.

Maybe this could work?:

len = op->data.nbytes - i;
for (j = 0; j < op->data.nbytes - i; j += 4) {
	tmp = fspi_readl(f, base + FSPI_RFDR + j);
	size = min(len, 4);
	memcpy(buf + j, &tmp, size);
	len -= size;
}

When this is fixed and tested you can add:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Thanks,
Frieder
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
