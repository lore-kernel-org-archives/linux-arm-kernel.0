Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF0CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:30:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC0720870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MFaRtIli";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfzK9Mg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC0720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EAerrsxPxNeFRzE1tKHHrE83TUWUgfoi4YD8O2/RTB8=; b=MFaRtIligr1IxG
	JEim/6ptYxzPQ7SiMxf0AkdU+SgS5kztvl4QcHi3LvLJFluSdRkaVKJsKHDQVUcxm8bua2Fy0WPNp
	lWwx8IMj3Z3fzUgCG8XgC1Jn3DIsGDViQwC6NI/3vj1nboiqzxbsFilaenVbIbh1B4RsjwZ7OCfFF
	ZbEBVFQOQIG5vWxzIXUyIsopo5gskQ39QFkCynHTd/JQSBN2HjM3jHdn31cr0N+wNR4jraHjY4TQD
	8QEolCsscektlL5PSDtAgj8qJJn0Y9wHQq9UmQUCwL/BUL5z5TnPlgLDzKi9OUfvm0EwhkThINrRC
	u7rven9v69if4AuF2dGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotgs-0002i1-K6; Wed, 30 Jan 2019 17:30:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotgo-0002hO-K4; Wed, 30 Jan 2019 17:30:20 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5FA9620870;
 Wed, 30 Jan 2019 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548869418;
 bh=X+k6se5mM7OybB0Z+rwrzJjfKrDkE4WCdAx8r65m1ro=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VfzK9Mg2+gGrr75xRerVHWYGgzZCA5nTz7kXV8AH5fe6WFVSl81RTxYEFVT8JOd/C
 2mbanlJWdnXLEmxVD4RC5GMDu+ZKbVhTZ0kN0MMqC7Z2ZSWqjSumnEmsNsuSvgmrNl
 GC227Of/a7CyOsO+k5FqGxTCWcabMiaSC3TOgNos=
Date: Wed, 30 Jan 2019 18:30:07 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Message-ID: <20190130182958.528e5ac0@bbrezillon>
In-Reply-To: <20190130150818.24902-9-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-9-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_093018_698109_00C02782 
X-CRM114-Status: GOOD (  18.57  )
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

On Wed, 30 Jan 2019 15:08:45 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
> access, the other for the qspi core and phy. Both are mandatory.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .../devicetree/bindings/spi/atmel-quadspi.txt      | 28 ++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> index e9dae6264d89..e7b7f297c5d7 100644
> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> @@ -1,14 +1,22 @@
>  * Atmel Quad Serial Peripheral Interface (QSPI)
>  
>  Required properties:
> -- compatible:     Should be "atmel,sama5d2-qspi".
> +- compatible:     Should be one of the following
> +		  - "atmel,sama5d2-qspi"
> +		  - "microchip,sam9x60-qspi"
>  - reg:            Should contain the locations and lengths of the base registers
>                    and the mapped memory.
>  - reg-names:      Should contain the resource reg names:
>                    - qspi_base: configuration register address space
>                    - qspi_mmap: memory mapped address space
>  - interrupts:     Should contain the interrupt for the device.
> -- clocks:         The phandle of the clock needed by the QSPI controller.
> +- clocks:	  - "atmel,sama5d2-qspi": the phandle of the clock needed by the
> +		  QSPI controller.
> +		  - "microchip,sam9x60-qspi": should reference the peripheral
> +		  and system QSPI clocks.
> +- clock-names:    Only for sam9x60 - should contain two strigs:

							   ^strings

And I think naming clocks even for sama5d2 is a good practice, so I'd
suggest making "pclk" mandatory even if you support unnamed clk in the
driver to be backward compatible with old DTs.

> +		  - "pclk" for the peripheral clock
> +		  - "qspick" for the system clock
>  - #address-cells: Should be <1>.
>  - #size-cells:    Should be <0>.
>  
> @@ -29,3 +37,19 @@ spi@f0020000 {
>  		...
>  	};
>  };
> +
> +qspi@f0014000 {
> +	compatible = "microchip,sam9x60-qspi";
> +	reg = <0xf0014000 0x100>, <0x70000000 0x08000000>;
> +	reg-names = "qspi_base", "qspi_mmap";
> +	interrupts = <35 IRQ_TYPE_LEVEL_HIGH 7>;
> +	clocks =  <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_SYSTEM 19>;
> +	clock-names = "pclk", "qspick";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +
> +	flash@0 {
> +		...
> +	};
> +};

No need to add one example per compat, especially when all that
changes is the compat string and an extra clk. 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
