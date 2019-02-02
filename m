Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBACC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:11:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BB421479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J7gzZw0R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pq2CwzjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BB421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UBlDedDqM5zIdSTq2ToF9ixunMEPbyUBMYw9X8h7bCM=; b=J7gzZw0RLvJ/dj
	IM/QYL0NQW4lDcB1VYqeYzzm2lkSXDwB+8oHd9ZyafJ99Tqt0nff74pnx/wUEmpzRY2xa1xm5P+iW
	f6O3fFFj3893kCCjqVAnKycxzftBsF1gL8lSutkXapWIXEWaP5lJ4ekPRmBQQQRE0QP+Bfsb5TwLG
	egj70EYqLsjEsJHBoBD/aEkAX5r6OPkpT+tAhfbUBupFOM3j2CHqnjesi+Axxpmo/HeGiYf2g80RC
	/BRGcO1Ls9Y3KraG9W+XiiDta6GZaiUlI9kPZp3fbL15CAYUsOe+JMVelKHJ8trhsXXQS2sHZUEjt
	bp550jK6oyDOt29GvKcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gppSb-00087q-Oj; Sat, 02 Feb 2019 07:11:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gppSY-00087P-Ic; Sat, 02 Feb 2019 07:11:28 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E181A20870;
 Sat,  2 Feb 2019 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549091486;
 bh=Q0YOtIvWPFPRChO/tSJzzFw3b6+MkY60OoXzjcEUZoY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pq2CwzjNR3N2vzUf/6pfOG9iU1LzzAixB2sbNsGj5vGwiq1LSqmf0MmgAdqBuouoi
 mOICEra73/LXzrEJJ3h5PvK0DA+45Ac5ITHGK/aRhQ/jDNZS55BgVnJm0fOZ9Fw2f6
 WkzkwgbQJNxHkE3sBu771ObyDtam3kb4ESe6X55Q=
Date: Sat, 2 Feb 2019 08:11:11 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Message-ID: <20190202081111.0bbc4443@bbrezillon>
In-Reply-To: <20190202040653.1217-4-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-4-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_231126_651335_72FEB7C2 
X-CRM114-Status: GOOD (  20.16  )
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
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Cyrille.Pitchen@microchip.com, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 2 Feb 2019 04:07:19 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The wrappers hid that the accesses are relaxed. Drop them.
> 
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v3: no change
> v2: new patch
> 
>  drivers/spi/atmel-quadspi.c | 47 +++++++++++++++++++--------------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index feeddcb25e1f..131374db0db4 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -175,17 +175,6 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
>  	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
>  };
>  
> -/* Register access functions */
> -static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
> -{
> -	return readl_relaxed(aq->regs + reg);
> -}
> -
> -static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
> -{
> -	writel_relaxed(value, aq->regs + reg);
> -}
> -
>  static inline bool is_compatible(const struct spi_mem_op *op,
>  				 const struct qspi_mode *mode)
>  {
> @@ -229,6 +218,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
>  static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  {
>  	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
> +	void __iomem *base = aq->regs;

Can we name this variable regs instead of base or even get rid of it
and dereference aq->regs in the xxx_relaxed() calls (doesn't look like
the lines would be over 80 chars even when doing that). With this
addressed, you can add:

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

>  	int mode;
>  	u32 dummy_cycles = 0;
>  	u32 iar, icr, ifr, sr;
> @@ -240,7 +230,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  
>  	/* Set the QSPI controller in Serial Memory Mode */
>  	if (aq->smm != QSPI_MR_SMM) {
> -		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
>  		aq->smm = QSPI_MR_SMM;
>  	}
>  
> @@ -300,17 +290,17 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
>  
>  	/* Clear pending interrupts */
> -	(void)qspi_readl(aq, QSPI_SR);
> +	(void)readl_relaxed(base + QSPI_SR);
>  
>  	/* Set QSPI Instruction Frame registers */
> -	qspi_writel(aq, QSPI_IAR, iar);
> -	qspi_writel(aq, QSPI_ICR, icr);
> -	qspi_writel(aq, QSPI_IFR, ifr);
> +	writel_relaxed(iar, base + QSPI_IAR);
> +	writel_relaxed(icr, base + QSPI_ICR);
> +	writel_relaxed(ifr, base + QSPI_IFR);
>  
>  	/* Skip to the final steps if there is no data */
>  	if (op->data.nbytes) {
>  		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
> -		(void)qspi_readl(aq, QSPI_IFR);
> +		(void)readl_relaxed(base + QSPI_IFR);
>  
>  		/* Send/Receive data */
>  		if (op->data.dir == SPI_MEM_DATA_IN)
> @@ -321,22 +311,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  				op->data.buf.out, op->data.nbytes);
>  
>  		/* Release the chip-select */
> -		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
> +		writel_relaxed(QSPI_CR_LASTXFER, base + QSPI_CR);
>  	}
>  
>  	/* Poll INSTRuction End status */
> -	sr = qspi_readl(aq, QSPI_SR);
> +	sr = readl_relaxed(base + QSPI_SR);
>  	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
>  		return err;
>  
>  	/* Wait for INSTRuction End interrupt */
>  	reinit_completion(&aq->cmd_completion);
>  	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
> -	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
> +	writel_relaxed(QSPI_SR_CMD_COMPLETED, base + QSPI_IER);
>  	if (!wait_for_completion_timeout(&aq->cmd_completion,
>  					 msecs_to_jiffies(1000)))
>  		err = -ETIMEDOUT;
> -	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
> +	writel_relaxed(QSPI_SR_CMD_COMPLETED, base + QSPI_IDR);
>  
>  	return err;
>  }
> @@ -375,18 +365,20 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  		scbr--;
>  
>  	scr = QSPI_SCR_SCBR(scbr);
> -	qspi_writel(aq, QSPI_SCR, scr);
> +	writel_relaxed(scr, aq->regs + QSPI_SCR);
>  
>  	return 0;
>  }
>  
>  static int atmel_qspi_init(struct atmel_qspi *aq)
>  {
> +	void __iomem *base = aq->regs;
> +
>  	/* Reset the QSPI controller */
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
> +	writel_relaxed(QSPI_CR_SWRST, base + QSPI_CR);
>  
>  	/* Enable the QSPI controller */
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
> +	writel_relaxed(QSPI_CR_QSPIEN, base + QSPI_CR);
>  
>  	return 0;
>  }
> @@ -394,10 +386,11 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
>  static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
>  {
>  	struct atmel_qspi *aq = (struct atmel_qspi *)dev_id;
> +	void __iomem *base = aq->regs;
>  	u32 status, mask, pending;
>  
> -	status = qspi_readl(aq, QSPI_SR);
> -	mask = qspi_readl(aq, QSPI_IMR);
> +	status = readl_relaxed(base + QSPI_SR);
> +	mask = readl_relaxed(base + QSPI_IMR);
>  	pending = status & mask;
>  
>  	if (!pending)
> @@ -503,7 +496,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
>  
>  	spi_unregister_controller(ctrl);
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
> +	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
>  	clk_disable_unprepare(aq->clk);
>  	return 0;
>  }


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
