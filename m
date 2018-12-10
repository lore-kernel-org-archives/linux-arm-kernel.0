Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428FEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:38:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A71020880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QIjkJ5gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A71020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T6jBXLdUwgMYzRJKNe5y9w1pZTLqXcQd3JYMV33gVWA=; b=QIjkJ5gEes0ipJ
	1OZphfgdJOOhUGFiKQJR62U2Hu4lpWr1CoLG1DyU0ZpAsrytnWyvbYwA8EHQwOe5EiR54lI4zlrop
	aeCz6X5K9lFKkfuxIZlITvrAziVQWHAWECHuqxuK1I7TWCeMHyyKfKmSdQZkeftE7LyEq2KXv0Nwg
	59oJDs1c/kRrPeFauMq/+cm9yyGH105xPZODGc1aeivZ0kmyTazfPJ6vX0jIRmVPVg/4/uhGsCh/K
	z3vrrMt+o+4NeUBej80IS7n3pnPB7eFa7XWpT0paLIPvsrdcQpB30Qk+wJg0kIn5UhT/yMwQv5unj
	VJLRkiFQkD9lVLp5v2tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKpM-0003mJ-3A; Mon, 10 Dec 2018 12:38:24 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKpI-0003lI-94
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:38:22 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBACaWuk010223; Mon, 10 Dec 2018 13:37:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p83yd2qpn-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 10 Dec 2018 13:37:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BD2D31;
 Mon, 10 Dec 2018 12:37:57 +0000 (GMT)
Received: from Webmail-eu.st.com (gpxdag3node6.st.com [10.75.127.73])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12C762B9A;
 Mon, 10 Dec 2018 12:37:57 +0000 (GMT)
Received: from GPXDAG3NODE5.st.com (10.75.127.72) by GPXDAG3NODE6.st.com
 (10.75.127.73) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Dec
 2018 13:37:56 +0100
Received: from GPXDAG3NODE5.st.com ([fe80::d995:abbc:5285:10c]) by
 GPXDAG3NODE5.st.com ([fe80::d995:abbc:5285:10c%19]) with mapi id
 15.00.1347.000; Mon, 10 Dec 2018 13:37:56 +0100
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: "cezary.gapinski@gmail.com" <cezary.gapinski@gmail.com>, Mark Brown
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add support for STM32F4 SPI
Thread-Topic: [PATCH 0/5] Add support for STM32F4 SPI
Thread-Index: AQHUj8azLFItfSiuXEO2Jd1SqFlrjaV32geA
Date: Mon, 10 Dec 2018 12:37:56 +0000
Message-ID: <ede8544f-c71d-0901-5522-e97215d23f85@st.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
In-Reply-To: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-ID: <3AC5027D79CC5B45A933F00D59740D08@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_03:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_043820_605255_0F66D5F9 
X-CRM114-Status: GOOD (  20.32  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Cezary,

On 12/9/18 2:53 PM, cezary.gapinski@gmail.com wrote:
> From: Cezary Gapinski <cezary.gapinski@gmail.com>
> 
> This series of patches adds support for first generation of SPI interface
> for STM32F4 family.
> 

First of all, thanks for adding STM32F4 SPI support.

> This version of driver is mostly different to STM32H7 one. Based on linux
> kernel I2C drivers for STM32 where drivers were splited into STM32F4 and
> STM32F7 family the same approach seems to be sufficient for SPI STM32
> drivers. Therefore STM32H7 driver was moved to spi-stm32h7.c file and
> register and functions were renamed to be more specific to STM32H7.
> 

You're right, STM32F4 SPI is slightly different from STM32H7 one: 
register map/bits offsets are different and STM32H7 has an RX and TX FIFO.
But if you have a look on STM32F7 SPI [1], you'll see that STM32F7 SPI 
is based on STM32F4 SPI with new features (data frames & FIFOs) also 
available on STM32H7 SPI.

That's why STM32H7 SPI driver was called spi-stm32. The goal was to use 
compatible & match data to differentiate each STM32Fx specificities.

You can have a look on how it is managed in drivers/rtc/rtc-stm32.c (the 
same driver covers 2 HW version of STM32 RTC), or in 
drivers/iio/dac/stm32-dac-core.c and stm32-dac.c (the same driver also 
covers 2 HW version of STM32 DAC).

As your spi-stm32f4.c file is highly based on the existing spi-stm32.c 
file, I think that common code could be factored and specificities could 
be handled with compatible and match data.

Regards,
Amelie


[1] 
https://www.st.com/content/ccc/resource/technical/document/reference_manual/c5/cf/ef/52/c0/f1/4b/fa/DM00124865.pdf/files/DM00124865.pdf/jcr:content/translations/en.DM00124865.pdf

> For current version master mode with full-duplex and 8/16 bit data frame
> format are supported. There is no TX and RX FIFOs like in STM32H7.
> DMA capabilility is supported for messages longer than arbitrary number
> of bytes (that is set already to 16 bytes) when TX and RX channels are
> set at the same time.
> 
> Cezary Gapinski (5):
>    spi: stm32: rename STM32 SPI registers and functions to STM32H7
>    spi: stm32: rename spi-stm32 to spi-stm32h7
>    spi: stm32: add driver for STM32F4 controller
>    ARM: dts: stm32: add SPI support on STM32F429 SoC
>    spi: stm32: add description about STM32F4 bindings
> 
>   .../devicetree/bindings/spi/spi-stm32.txt          |    9 +-
>   arch/arm/boot/dts/stm32f429.dtsi                   |   60 +
>   drivers/spi/Kconfig                                |   18 +-
>   drivers/spi/Makefile                               |    3 +-
>   drivers/spi/spi-stm32.c                            | 1322 -------------------
>   drivers/spi/spi-stm32f4.c                          | 1002 +++++++++++++++
>   drivers/spi/spi-stm32h7.c                          | 1340 ++++++++++++++++++++
>   7 files changed, 2424 insertions(+), 1330 deletions(-)
>   delete mode 100644 drivers/spi/spi-stm32.c
>   create mode 100644 drivers/spi/spi-stm32f4.c
>   create mode 100644 drivers/spi/spi-stm32h7.c
>
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
