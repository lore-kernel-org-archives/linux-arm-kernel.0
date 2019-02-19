Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E337C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:24:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F362F20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nUHdi3ox";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ycwVFAP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F362F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PWXO9JBVmXQBR4pgOLIJ8TmHQHYkW+5UKkDrD5HMUwQ=; b=nUHdi3oxkp3mrf
	EKaMKitjzgqim0r/a/9EesfJwVfSfgK/jratmKZ77MPg3h6OYByYOXbOlgE1SdE23HvsmcN/L8f83
	bl0DerHs/NfsaFIhCSPQRydCmB+NC/AVT+WgAZpskaZuEgzMBRNUTnrQw+ZpFXO0PwnYPC7VcMJ2X
	svQ9W1Q8dw2MfPPwHGT4PVeGyz6F4yLlaQUggrmT3SS8kN7bfFHJmeJSmO+7+GgFbtfSiLkWtSKQO
	mbk86lTJ1sW8BYhdPBckTF+HDjXLdPfPS1lS1E7Zejaasz7ntkTueT1AvoTalM04XijB82Z7bmck7
	OLv8hK0aOJe5k/dT4xKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvzl0-0002TC-75; Tue, 19 Feb 2019 07:23:58 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvzkq-0002LI-Db; Tue, 19 Feb 2019 07:23:50 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1J7Ndtg040491;
 Tue, 19 Feb 2019 01:23:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550561019;
 bh=RJ/ssE7i7ZV21iek2H9iOK7v6JGeQReTmBrQkJA9y4I=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=ycwVFAP/JYASxmbD/IrwNuQpQz+lJLsMROYj6egak0TkfWjoM1gzMLSqVtlIELNSj
 MG7EJ1SZkqXwBcOfKHIm4XzqNy5a+KCA8puX76zwE5ecKSiFtXuR6Ehes+2mhCZlvT
 YL7QVuIsxpwRBEHtgFQBxMZUVj5oDl5oXzMm7OdU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1J7NdvS055001
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Feb 2019 01:23:39 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 01:23:38 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 01:23:39 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1J7NXaG024750;
 Tue, 19 Feb 2019 01:23:34 -0600
Subject: Re: [RFC PATCH 0/5] MTD: Add Initial Hyperbus support
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris
 <computersforpeace@gmail.com>, Boris Brezillon <bbrezillon@kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <a843dbb2-054a-2afd-863f-2d1822b3ca33@ti.com>
Date: Tue, 19 Feb 2019 12:54:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-1-vigneshr@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_232348_536254_F84F269A 
X-CRM114-Status: GOOD (  21.95  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 tudor.ambarus@microchip.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 19/02/19 12:06 PM, Vignesh R wrote:
[...]
> 
> Tested on modified TI AM654 EVM with Cypress Hyperflash S26KS512 by
> creating a UBIFS partition and writing and reading files to it.
> Stress tested by writing/reading 16MB flash repeatedly at different
> offsets using dd commmand.
> 

Here is the enumeration log from dmesg:
https://pastebin.ubuntu.com/p/Vd5jYQT4FH/

> HyperBus specification can be found at[1]
> HyperFlash datasheet can be found at[2]
> TI's HBMC controller details at[3]
> 
> [1] https://www.cypress.com/file/213356/download
> [2] https://www.cypress.com/file/213346/download
> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>     Table 12-5741. HyperFlash Access Sequence
> 
> Vignesh R (5):
>   mtd: cfi_cmdset_0002: Add support for polling status register
>   dt-bindings: mtd: Add binding documentation for Hyperbus memory
>     devices
>   mtd: Add support for Hyperbus memory devices
>   dt-bindings: mtd: Add bindings for TI's AM654 Hyperbus memory
>     controller
>   mtd: hyperbus: Add driver for TI's Hyperbus memory controller
> 
>  .../bindings/mtd/cypress,hyperbus.txt         |   6 +
>  .../devicetree/bindings/mtd/ti,am654-hbmc.txt |  27 +++
>  MAINTAINERS                                   |   8 +
>  drivers/mtd/Kconfig                           |   2 +
>  drivers/mtd/Makefile                          |   1 +
>  drivers/mtd/chips/cfi_cmdset_0002.c           |  50 ++++++
>  drivers/mtd/hyperbus/Kconfig                  |  23 +++
>  drivers/mtd/hyperbus/Makefile                 |   4 +
>  drivers/mtd/hyperbus/core.c                   | 167 ++++++++++++++++++
>  drivers/mtd/hyperbus/hbmc_am654.c             | 105 +++++++++++
>  include/linux/mtd/cfi.h                       |   5 +
>  include/linux/mtd/hyperbus.h                  |  73 ++++++++
>  12 files changed, 471 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
>  create mode 100644 drivers/mtd/hyperbus/Kconfig
>  create mode 100644 drivers/mtd/hyperbus/Makefile
>  create mode 100644 drivers/mtd/hyperbus/core.c
>  create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
>  create mode 100644 include/linux/mtd/hyperbus.h
> 

-- 
Regards
Vignesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
