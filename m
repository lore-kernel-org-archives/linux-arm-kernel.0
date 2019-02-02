Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB5C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:17:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E69A20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HGcZAw5M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtn6KXj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E69A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bq012NbrOxzy9MdzeMdiFKo7VIh0MY/zkN4++kJv5JA=; b=HGcZAw5MWDkvmB
	tQsrjQE6MKxHeMpg3O8zC93yrEnIjcsfsntBclydjoSdc+okvAp3BCqPBYkJTpZbDoPGc887f6/pw
	vC3BFNX/aljU6BhUL4+q20ThChLi9sZBanQbFaetLt9r8ITiXwBfVUVriC70VmFq3E/YQNHYKpAdD
	gQP1rfruT98P+AjwRttOEdwQoXV+zR6FcGbDafSbLY96utKfkqdWolMB0Bo9PuFvhEYUZUrN2BwgI
	IBa3/6q8vE8nAaVKLOGXDWdD5xoSIx0+aRSyQ7274r5A18hdxwsjA1uxW+dMOlV5cDdZzueLTUkq8
	u1Hbn3TkSZ69Qes1s0aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gppYc-00046t-20; Sat, 02 Feb 2019 07:17:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gppYY-00046T-HL; Sat, 02 Feb 2019 07:17:39 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AAF7E20869;
 Sat,  2 Feb 2019 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549091858;
 bh=Sm2sNfK0Px+6ifmL2BMseCNQTGFB1pCiTCawVraGZE0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mtn6KXj3BXUp6FrM3PIVdIDzcOl5e2wv9+w5HjFtL/MLVGJtnMZrcYejQckmwxdzw
 mz+9LjNZhuRPuRlIOh8SSsux5Y/kZu25oMF72uuQhH35EOjnp9mr0gXQPPU9JynnH2
 WnZSL35j5lli5duk5BN0xihnUmTPjEiIUd0b16Uc=
Date: Sat, 2 Feb 2019 08:17:23 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI
 driver for Microchip SAM9X60
Message-ID: <20190202081723.30645d03@bbrezillon>
In-Reply-To: <20190202040653.1217-13-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-13-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_231738_593152_7D210C9B 
X-CRM114-Status: GOOD (  16.44  )
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

On Sat, 2 Feb 2019 04:07:44 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
> access, the other for the qspi core and phy. Both are mandatory.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v3: "pclk" was made mandatory in previous patch. Reword clock
> descriptions.
> v2:
> - make "pclk" mandatory even for sama5d2. Unnamed clk will be
> supported in the driver.
> - drop unneeded example
> 
>  Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> index 1de54e87f5d6..fc7e83adab36 100644
> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> @@ -1,15 +1,19 @@
>  * Atmel Quad Serial Peripheral Interface (QSPI)
>  
>  Required properties:
> -- compatible:     Should be "atmel,sama5d2-qspi".
> +- compatible:     Should be one of the following:
> +		  - "atmel,sama5d2-qspi"
> +		  - "microchip,sam9x60-qspi"
>  - reg:            Should contain the locations and lengths of the base registers
>                    and the mapped memory.
>  - reg-names:      Should contain the resource reg names:
>                    - qspi_base: configuration register address space
>                    - qspi_mmap: memory mapped address space
>  - interrupts:     Should contain the interrupt for the device.
> -- clocks:         The phandle of the clock needed by the QSPI controller.
> -- clock-names:    Should contain "pclk" for the peripheral clock.
> +- clocks:         Should reference the peripheral clock and the QSPI system
> +                  clock if available.
> +- clock-names:    Should contain "pclk" for the peripheral clock and "qspick"
> +                  for the system clock when available.
>  - #address-cells: Should be <1>.
>  - #size-cells:    Should be <0>.
>  


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
