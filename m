Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F4CC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:19:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5ED2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Aj4tr7Ue";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot577WB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5ED2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jn3JMfg5/UyCev6vqF1jwZjIcHJhUOjN0MPnTgW4mrs=; b=Aj4tr7UexnR/b6
	D6bcO0GbuVLCN17QfiqAyV7+fwBHZIMn7X1EV03DBNL/zQmP8ed9+hX/vZgTUk+sXV2ZX+0sFs579
	CQFd+mb+aPb3sB5MP4obeGJWZoG5JLyidaKR/mGWmaKRopFP0s4usSfrPouR1NZgIL2B6wOtGuuhm
	i02/o+CDt0c/nhzI3VdpooWU7wGe+ynpkcMxQQKF69Ap5urKbm5pEKVgb+cTml4pfS618QlgrZhuf
	O9PRQQS9UVx2UWuq3O9tKtVtgjO+o/NDbGHs5MkkNW6H+XpgmYbMgTQ7GuexWMHnKTazWOFYteB31
	NLvXmViODbaIBTX0JH8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotWJ-0002iB-I4; Wed, 30 Jan 2019 17:19:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotWG-0002hl-OZ; Wed, 30 Jan 2019 17:19:26 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E1B820855;
 Wed, 30 Jan 2019 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548868764;
 bh=Kw5xGxZUbt+DnJSyWLPGn/+zbIwFvAFXMz9o9p/6Me8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ot577WB3P9SZF/9xGZu/ILtuZhrdZtLhuMY3oaGzH6QB56bWpC/zO11B/f2hkqeOI
 iajAKeT0sDypMCtKqFsbmde+Ujhf1lavCoswwbzJnxMHrbfvBbUzEnY2fJ0Wmy+zrE
 v7HSZSMtvCNY/5ifKuwckZ9LLWSCf1Yc8gf6wX8g=
Date: Wed, 30 Jan 2019 18:19:14 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 3/9] spi: atmel-quadspi: fix naming scheme
Message-ID: <20190130181904.14094418@bbrezillon>
In-Reply-To: <20190130150818.24902-4-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-4-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_091924_830224_F990D22F 
X-CRM114-Status: GOOD (  19.65  )
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

On Wed, 30 Jan 2019 15:08:33 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Let general names to core drivers.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/spi/atmel-quadspi.c | 52 ++++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 64475ad16c83..e156c345705b 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -157,14 +157,14 @@ struct atmel_qspi {
>  	struct completion	cmd_completion;
>  };
>  
> -struct qspi_mode {
> +struct atmel_qspi_mode {
>  	u8 cmd_buswidth;
>  	u8 addr_buswidth;
>  	u8 data_buswidth;
>  	u32 config;
>  };
>  
> -static const struct qspi_mode sama5d2_qspi_modes[] = {
> +static const struct atmel_qspi_mode sama5d2_qspi_modes[] = {
>  	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
>  	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
>  	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
> @@ -175,18 +175,18 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
>  };
>  
>  /* Register access functions */
> -static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
> +static inline u32 atmel_qspi_readl(struct atmel_qspi *aq, u32 reg)
>  {
>  	return readl_relaxed(aq->regs + reg);
>  }
>  
> -static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
> +static inline void atmel_qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
>  {
>  	writel_relaxed(value, aq->regs + reg);
>  }

Can we get rid of these wrappers? I'm not a big fan of wrappers that
hide the fact that accesses are relaxed.

>  
> -static inline bool is_compatible(const struct spi_mem_op *op,
> -				 const struct qspi_mode *mode)
> +static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
> +					    const struct atmel_qspi_mode *mode)
>  {
>  	if (op->cmd.buswidth != mode->cmd_buswidth)
>  		return false;
> @@ -200,12 +200,12 @@ static inline bool is_compatible(const struct spi_mem_op *op,
>  	return true;
>  }
>  
> -static int find_mode(const struct spi_mem_op *op)
> +static int atmel_qspi_find_mode(const struct spi_mem_op *op)
>  {
>  	u32 i;
>  
>  	for (i = 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
> -		if (is_compatible(op, &sama5d2_qspi_modes[i]))
> +		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
>  			return i;
>  
>  	return -1;
> @@ -214,7 +214,7 @@ static int find_mode(const struct spi_mem_op *op)
>  static bool atmel_qspi_supports_op(struct spi_mem *mem,
>  				   const struct spi_mem_op *op)
>  {
> -	if (find_mode(op) < 0)
> +	if (atmel_qspi_find_mode(op) < 0)
>  		return false;
>  
>  	/* special case not supported by hardware */
> @@ -237,7 +237,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>  	ifr = QSPI_IFR_INSTEN;
>  
> -	mode = find_mode(op);
> +	mode = atmel_qspi_find_mode(op);
>  	if (mode < 0)
>  		return -ENOTSUPP;
>  
> @@ -293,17 +293,17 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
>  
>  	/* Clear pending interrupts */
> -	(void)qspi_readl(aq, QSPI_SR);
> +	(void)atmel_qspi_readl(aq, QSPI_SR);
>  
>  	/* Set QSPI Instruction Frame registers */
> -	qspi_writel(aq, QSPI_IAR, iar);
> -	qspi_writel(aq, QSPI_ICR, icr);
> -	qspi_writel(aq, QSPI_IFR, ifr);
> +	atmel_qspi_writel(aq, QSPI_IAR, iar);
> +	atmel_qspi_writel(aq, QSPI_ICR, icr);
> +	atmel_qspi_writel(aq, QSPI_IFR, ifr);
>  
>  	/* Skip to the final steps if there is no data */
>  	if (op->data.nbytes) {
>  		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
> -		(void)qspi_readl(aq, QSPI_IFR);
> +		(void)atmel_qspi_readl(aq, QSPI_IFR);
>  
>  		/* Send/Receive data */
>  		if (op->data.dir == SPI_MEM_DATA_IN)
> @@ -314,22 +314,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  				op->data.buf.out, op->data.nbytes);
>  
>  		/* Release the chip-select */
> -		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
> +		atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
>  	}
>  
>  	/* Poll INSTRuction End status */
> -	sr = qspi_readl(aq, QSPI_SR);
> +	sr = atmel_qspi_readl(aq, QSPI_SR);
>  	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
>  		return err;
>  
>  	/* Wait for INSTRuction End interrupt */
>  	reinit_completion(&aq->cmd_completion);
>  	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
> -	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
> +	atmel_qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
>  	if (!wait_for_completion_timeout(&aq->cmd_completion,
>  					 msecs_to_jiffies(1000)))
>  		err = -ETIMEDOUT;
> -	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
> +	atmel_qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
>  
>  	return err;
>  }
> @@ -368,7 +368,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  		scbr--;
>  
>  	scr = QSPI_SCR_SCBR(scbr);
> -	qspi_writel(aq, QSPI_SCR, scr);
> +	atmel_qspi_writel(aq, QSPI_SCR, scr);
>  
>  	return 0;
>  }
> @@ -376,13 +376,13 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  static int atmel_qspi_init(struct atmel_qspi *aq)
>  {
>  	/* Reset the QSPI controller */
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
> +	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
>  
>  	/* Set the QSPI controller in Serial Memory Mode */
> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +	atmel_qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
>  
>  	/* Enable the QSPI controller */
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
> +	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
>  
>  	return 0;
>  }
> @@ -392,8 +392,8 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
>  	struct atmel_qspi *aq = (struct atmel_qspi *)dev_id;
>  	u32 status, mask, pending;
>  
> -	status = qspi_readl(aq, QSPI_SR);
> -	mask = qspi_readl(aq, QSPI_IMR);
> +	status = atmel_qspi_readl(aq, QSPI_SR);
> +	mask = atmel_qspi_readl(aq, QSPI_IMR);
>  	pending = status & mask;
>  
>  	if (!pending)
> @@ -499,7 +499,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
>  
>  	spi_unregister_controller(ctrl);
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
> +	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
>  	clk_disable_unprepare(aq->clk);
>  	return 0;
>  }


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
