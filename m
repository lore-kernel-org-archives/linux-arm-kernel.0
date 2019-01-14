Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974DDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:20:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5981720657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rdl6iZpd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kaAtUj/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5981720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CBRCv22XM/7qv737HF9D/oHZAjmTIwVqmxMeEg7j+ZE=; b=Rdl6iZpd8uc0KR
	Ufn4hOG5pW4YzVlllG/h+4XyLvv3cHbNLnbibTWIr0pvyBE5tPrPj2n4LcW04/5MnUdJYvY36xyFr
	JMZcsnFTfLHtx/zAojtXYHUg6xMfloYCjcwZ9O4Cr5N2o1Fz0q3e3RxCucA4LkL+o4PpbhiCXk9mi
	7mpsFQUhKgXpi//0KVIDqam24t3tbijTuq2MKiCrrRrN9PjmuJmzR2DtJGlRRyKjMLU/BH2nfYXLq
	YX7tqBRVsKVL1gtMUDJqYCaWOqC31Zr6LahjxfxbVa+1clV9ChBjZqpjlpeutBEI9E3YOl8UsRJ7l
	uUOsy1t0V80tMhzmAMDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj1EW-0007jR-Ct; Mon, 14 Jan 2019 12:20:48 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj1ES-0007j0-8j
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 12:20:45 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ECKM4e022252;
 Mon, 14 Jan 2019 06:20:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547468422;
 bh=GzkmGAiWWkPJQ7bMtad2a06xNmlSZxETzpgQ/xgJNu0=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=kaAtUj/lGHgCNyz+EiqdEcSwGvE1w7Fc0tfwiorBUFwtcmZLQ9YL4VB7sUE/6ozX0
 KdFnaOBfGHsU8tRPBSdF2afglCIH86vkwB6RzQ2y6Nru7UyGjYrwjXklmCvbsv+3n5
 CK62SSy3keRZQ0gdh7N2MxdH+JT2AFxB6rcv/b0M=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ECKMFV082326
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 06:20:22 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 06:20:21 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 06:20:21 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ECKIij009512;
 Mon, 14 Jan 2019 06:20:19 -0600
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-3-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <08200de1-fde5-c525-c874-c7872259067b@ti.com>
Date: Mon, 14 Jan 2019 17:50:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111172134.30147-3-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_042044_410024_247E7A4C 
X-CRM114-Status: GOOD (  22.20  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bartosz,

On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently the clocksource and clockevent support for davinci platforms
> lives in mach-davinci. It hard-codes many things, used global variables,
> implements functionalities unused by any platform and has code fragments
> scattered across many (often unrelated) files.
> 
> Implement a new, modern and simplified timer driver and put it into
> drivers/clocksource. We still need to support legacy board files so
> export a config structure and a function that allows machine code to
> register the timer.
> 
> We don't check the return values of regmap reads and writes since with
> mmio it's only likely to fail due to programmer's errors.
> 
> We also don't bother freeing resources on errors in
> davinci_timer_register() as the system won't boot without a timer anyway.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

With this series, DA830 fails to boot. Rest of the devices are okay from
boot perspective.

DA830 is pretty unique because it uses the same timer-half for both
clocksource and clockevent. May be you can set the same configuration on
your DA850 to see the same issue? Else, I will enable low-level debug
and try to provide more debug data.

Some minor comments below from quick look:

> diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
> new file mode 100644
> index 000000000000..7282a1fda80f
> --- /dev/null
> +++ b/drivers/clocksource/timer-davinci.c
> @@ -0,0 +1,415 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * TI DaVinci clocksource driver
> + *
> + * Copyright (C) 2019 Texas Instruments
> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> + * (with some parts adopted from code by Kevin Hilman <khilman@baylibre.com>)

Did you really intend GPL v2 or later? The original code referred to
above is marked 2.0 only.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/regmap.h>
> +#include <linux/sched_clock.h>
> +
> +#include <clocksource/timer-davinci.h>
> +
> +#define DAVINCI_TIMER_REG_TIM12			0x10
> +#define DAVINCI_TIMER_REG_TIM34			0x14
> +#define DAVINCI_TIMER_REG_PRD12			0x18
> +#define DAVINCI_TIMER_REG_PRD34			0x1c
> +#define DAVINCI_TIMER_REG_TCR			0x20
> +#define DAVINCI_TIMER_REG_TGCR			0x24
> +
> +#define DAVINCI_TIMER_TIMMODE_MASK		0x0000000c
> +#define DAVINCI_TIMER_RESET_MASK		0x00000003
> +#define DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED	0x00000004
> +#define DAVINCI_TIMER_UNRESET			0x00000003

I think these are more readable if using BIT() and GENMASK()

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
