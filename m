Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A34C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:12:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78E121479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LA7KrpEu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg4JB9+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78E121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cnoxleBEoWLtOyGeGAD3P2lOYC7SHUd8lCYH1beG2OY=; b=LA7KrpEumVI7hZ
	VtfkvymGq4ASe3plsBbtTmJ40icYuLay9AgD1x4Up0V4qv+zWUX53sCCx/zAWvSvGMJwV0SBslxFN
	07dpiJYgaqQ6qFCXc6EzvE9idIjOwGn+QzB6Vu/o7EhoSZhVSun4BrYJyR+1uP0uXx7d225ZsEj5X
	R8e1qyKGM+W+1ikrOSIq/LNwFEmz6IdLcz7mCDQHhbmOoFqkknxv6Zr2VSiK1L9nsea9Ga6nUN3pN
	5Ucf/R92UWPY5hkEPnBReKBORrGMcvpxeFiDCXFz5N6rBQT36TxvrEQtYjET6M1m3kwuTRvTg//iP
	JulQIZ7Y7gv22jaoDn3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gppTZ-0000LK-1F; Sat, 02 Feb 2019 07:12:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gppTV-0000Ku-LU; Sat, 02 Feb 2019 07:12:26 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DA4A520863;
 Sat,  2 Feb 2019 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549091545;
 bh=1Mup6wsAELPhiC4u7D1TximLwIdAuHu1xQPH9DRuJeY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qg4JB9+AmCCK7hfjoFfJ4YFHkGC2dnYt86xFl/L/XjGN0141YAeMzAWCJnyilW+8k
 rNA5CzdKs+Cf2NKL+nh3AIftptLzj4srQqkqlSAn7pmOWXZWJjJrBJi0lUJOr0O9lF
 fX/CL83UD/bOh5gRsBMWUeQ6LSbepyeNmmQdUBU8=
Date: Sat, 2 Feb 2019 08:12:11 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 04/13] spi: atmel-quadspi: fix naming scheme
Message-ID: <20190202081211.51aabc1f@bbrezillon>
In-Reply-To: <20190202040653.1217-5-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-5-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_231225_731544_0FF54398 
X-CRM114-Status: GOOD (  16.59  )
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

On Sat, 2 Feb 2019 04:07:22 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Let general names to core drivers.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v3: no change
> v2: update after the removing of iomem access wrappers
> 
>  drivers/spi/atmel-quadspi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 131374db0db4..47ed751a91e7 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -158,14 +158,14 @@ struct atmel_qspi {
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
> @@ -175,8 +175,8 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
>  	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
>  };
>  
> -static inline bool is_compatible(const struct spi_mem_op *op,
> -				 const struct qspi_mode *mode)
> +static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
> +					    const struct atmel_qspi_mode *mode)
>  {
>  	if (op->cmd.buswidth != mode->cmd_buswidth)
>  		return false;
> @@ -190,12 +190,12 @@ static inline bool is_compatible(const struct spi_mem_op *op,
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
> @@ -204,7 +204,7 @@ static int find_mode(const struct spi_mem_op *op)
>  static bool atmel_qspi_supports_op(struct spi_mem *mem,
>  				   const struct spi_mem_op *op)
>  {
> -	if (find_mode(op) < 0)
> +	if (atmel_qspi_find_mode(op) < 0)
>  		return false;
>  
>  	/* special case not supported by hardware */
> @@ -234,7 +234,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		aq->smm = QSPI_MR_SMM;
>  	}
>  
> -	mode = find_mode(op);
> +	mode = atmel_qspi_find_mode(op);
>  	if (mode < 0)
>  		return -ENOTSUPP;
>  


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
