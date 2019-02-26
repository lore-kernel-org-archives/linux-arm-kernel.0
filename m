Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB147C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:28:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97812173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O+cT2N/N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Y3JgxTQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97812173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bCqnrKwKqky5OsnpZx5u/OCAG6EpWiNc1h5It4C8WDU=; b=O+cT2N/Nb7ykgS
	LtcwjoNrI8BaiCDr4QB57frVttObILg86OO0d0q3y9d9UYVnNaEK6AoyA5hntVIwjuBt9gCW+yTB+
	kstuyJg11hBMQCVZMnoC6a+EEq8N5wx4uikBcwW7S9Va/i3K77qhBe9O8vnGMgXIY+On3xxaZlQnI
	KMT9JuLUtU4wUNOm9OG+XQQ5/4Ava2ojlRbpQ3ukM7911CVaBgyENVsN9C+FZ55hZ2jRKUzNP5gu3
	0kWAu1yUPMByZT3twH31TeQl/S9SMwBxRnmH49sBFv6MGMBVd4fMPpZsMeI+H8nZvVfhYhxFplzvh
	bagCgz/TvQKLP4WI07tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyhSy-0002io-Tf; Tue, 26 Feb 2019 18:28:32 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyhSo-0002ZC-7h
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 18:28:23 +0000
Received: by mail-lj1-x241.google.com with SMTP id z20so11647682ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 10:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bLpnNHAsXYeTMUo78HRM2QnmksqH5fmT7cGzmEMRAOI=;
 b=Y3JgxTQHu9gHW/Gn4f+FyhRmBRRVr5YeaJ1hu+s+XHpndpcvccBgy+HntzAob+cbq7
 oXJ437K+PAgR75PEj4GBYHd9UeTgh69NoKGkZhdwoIWQoHWNtMEckokK7YY1WOH1svJt
 CrGj/Ezhmh/s0v3UGbGMaxDT8mxHe7FTEGDuu9/vSahRs1snt5CnwfsnmfNXizHC67aC
 NsrZGKf/zkyoKYzzK339ZHuIXzWjmgdrG9almFsUx7wuJBSO847kIVCTDqYnw0C5apHx
 1OdHF2HUH6Mi9O3L++NeH8Mu3z1qWihxhAhsiVOzgECnJ/1zwl7nQiDgGuYb/SR57tp+
 4Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bLpnNHAsXYeTMUo78HRM2QnmksqH5fmT7cGzmEMRAOI=;
 b=iauSw6xByDGtSg5i4WbVrmCiNViMKzoXxdgbGrOh3EhFt9ieknu5ARv6D8gCXrIzYI
 yEwOpVA0bel0bCYuDk73VsAShmCQhNS50jgLr0s9zXmeR8GVcxdjWVODoJgCePBmMmhZ
 OWChLOCTm4LG3V4cu+GitxZHnPB4BseqGdty7bOhd/uydPYPr+v/2KyibeIkZneN/UxB
 wl63Khi5CSzxOkGOanUHK+4q3WHjdlqxIYjNNbNvR8F5JIj8Vd/WBh0y429z6ibLSrFA
 G2VY4glAlMWbQSsAxT6JdSXgPtFDuS2hxGYyqVM2ALn17/tgeg9XEFmVYymmkxYfrwuc
 vGFQ==
X-Gm-Message-State: AHQUAuZBsGmaPIWoMwvFfjPG/t+a2nM5S/DyqK9id1HQVTs+a9QVTOKF
 AoKav7XGDNWvlWVL7w0gBuyhzjzRo9U=
X-Google-Smtp-Source: AHgI3IZENB2wSiagUzwcZqG0Fd7+YIzsH6UcxiSQ6DwQ4zPeLlqHuDiNNUXmGASynfjHrC5gtR5dUQ==
X-Received: by 2002:a2e:3807:: with SMTP id f7mr14223743lja.9.1551205699070;
 Tue, 26 Feb 2019 10:28:19 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.110])
 by smtp.gmail.com with ESMTPSA id d25sm3413914lji.9.2019.02.26.10.28.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 10:28:18 -0800 (PST)
Subject: Re: [RFC PATCH 5/5] mtd: hyperbus: Add driver for TI's Hyperbus
 memory controller
To: "Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>)"
 <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Marek Vasut
 <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Rob Herring <robh+dt@kernel.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-6-vigneshr@ti.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <4d2e31e3-0130-14a1-ab06-e6ffeae1cd22@cogentembedded.com>
Date: Tue, 26 Feb 2019 21:28:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-6-vigneshr@ti.com>
Content-Language: en-MW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_102822_272596_853E8401 
X-CRM114-Status: GOOD (  22.30  )
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

On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:

> Add driver for Hyperbus memory controller on TI's AM654 SoC. Programming
> IP is pretty simple and provides direct memory mapped access to
> connected Flash devices.
> 
> Add basic support for the IP without DMA. Second ChipSelect is not
> supported for now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mtd/hyperbus/hbmc_am654.c | 105 ++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
> 
> diff --git a/drivers/mtd/hyperbus/hbmc_am654.c b/drivers/mtd/hyperbus/hbmc_am654.c
> new file mode 100644
> index 000000000000..1f0d2dc52f9f
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/hbmc_am654.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +// Author: Vignesh R <vigneshr@ti.com>
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mtd/hyperbus.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/types.h>
> +
> +struct am654_hbmc_priv {
> +	struct hb_device hbdev;
> +	void __iomem	*regbase;

   Isn't regbase a controller's data, not a slave device's?

[...]

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
