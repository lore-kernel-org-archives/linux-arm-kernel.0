Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28310C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:01:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD852082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JNmqDlsb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKh2xoBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD852082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4yT13g2SyKrjzDkxHQXYzGqrVKYbUHQfoSdoWvQ2eTI=; b=JNmqDlsb2GJmA4
	LaG/+y/vIATuinyS9I471ABPBBIfAJi5ENIZKyinj7ifiReYvy7ypababwUJEiWbs/RiuvvmVI30L
	YDoU+W1J+Kt9XY4rh75EB3nxhVmtHq+vlKV6YcWYgRpdwXdY2bB7ezsUnlOQGAXwLThPS65sDZ7BD
	1ncElCKjZDRjfG4p+SluNqewhESsnN7j+YEBJpMR0TtwmB0b4goesG/frbjNmKkzu9VT0ZgpVueSL
	GGRv2+zii7GjTicgwWB1rGr8g/CoezSQ2YMBVEM20u4r43c+s9AJZl0VSCt9UsneAKA+pjPocFctE
	LJbauXsMm8xu5Qlfhp8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqeop-0000aO-UE; Mon, 04 Feb 2019 14:01:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqeog-0000Za-Ut; Mon, 04 Feb 2019 14:01:49 +0000
Received: from bbrezillon (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4BACA2082F;
 Mon,  4 Feb 2019 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549288902;
 bh=3KNwqHnHGZNCWkch9CrjOjSh+cKQ+OW5kIx/iou8hsk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EKh2xoBo4ZacXyPGZI9QCUvf4sv2duUHecD7SFeuuOMxbLdHBl0YrcDDjO+muuxGP
 Lel8MDvrwy5GqsX8Lyt+DrHPxiCkPhJoP9RwCAZqKU8fAkFHm5GVMd6B1KDiQpGVAy
 EU4EqBuw+nXxWOGdkcEyJInQGzIyG5N0Hn2COmus=
Date: Mon, 4 Feb 2019 15:01:36 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v4 08/13] spi: atmel-quadspi: rework transfer macros
Message-ID: <20190204150136.519060ff@bbrezillon>
In-Reply-To: <20190204100910.26701-9-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
 <20190204100910.26701-9-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_060143_732237_512F4EE6 
X-CRM114-Status: GOOD (  13.60  )
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

On Mon, 4 Feb 2019 10:09:53 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Split the TFRTYP_TRSFR_ bitfields in 2: one bit encoding the
> mem/reg transfer type and one bit encoding the direction of
> the transfer (read/write).
> 
> Remove NOP when setting read transfer type. Remove useless
> setting of write transfer type when
> op->data.dir == SPI_MEM_DATA_IN && !op->data.nbytes.
> 
> QSPI_IFR_TFRTYP_TRSFR_WRITE is specific just to sama5d2 qspi,
> rename it to QSPI_IFR_SAMA5D2_WRITE_TRSFR.
> 
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v4: introduce QSPI_IFR_TFRTYP_MEM, reword commit
> v3: new patch
> 
>  drivers/spi/atmel-quadspi.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index ce4f8a648f45..19a3980775ad 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -113,11 +113,8 @@
>  #define QSPI_IFR_OPTL_4BIT              (2 << 8)
>  #define QSPI_IFR_OPTL_8BIT              (3 << 8)
>  #define QSPI_IFR_ADDRL                  BIT(10)
> -#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
> -#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
> -#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
> +#define QSPI_IFR_TFRTYP_MEM		BIT(12)
> +#define QSPI_IFR_SAMA5D2_WRITE_TRSFR	BIT(13)
>  #define QSPI_IFR_CRM                    BIT(14)
>  #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
>  #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
> @@ -275,10 +272,8 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	if (op->data.nbytes)
>  		ifr |= QSPI_IFR_DATAEN;
>  
> -	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
> -		ifr |= QSPI_IFR_TFRTYP_TRSFR_READ;
> -	else
> -		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
>  
>  	/* Clear pending interrupts */
>  	(void)readl_relaxed(aq->regs + QSPI_SR);


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
