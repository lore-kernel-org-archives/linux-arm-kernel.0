Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0FFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:16:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC3B218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G8BgvPv6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0wYuFCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC3B218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nzPCppSEoJPmKr/2Dx0MYMASh0vW/L1BDcUQRIrbYfI=; b=G8BgvPv6ns6Bo8
	aXpE/lfApqN9yUzmpYCVZKmU44OqeYru0cYd4pieVMyVtWTTztKyaJeN4hWyaa4/17z4Zro3SeUV8
	8miTtLeDAqC/dca0Gy3L+XPwHACXrJZulVZKjfsNGK9GO9qpyMeEgJLAOCMiBMudXrL9R39e3/lZV
	/Y5nefSWVp53ww3/mnp7HnXVByQAKege+yhYTuacW6ScpKsOEWD8YuyQhsUwSQHr7eVtICBhCtUx4
	Tp9gIA/rRQSJLx1ITKM/HM78qymyTYsXFYDlO88rQorRZTbNBDJSndVRgAxGNF9hGgank8FMrhMMj
	CIwdhpvd/sC8zeJVPCFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvcDy-0006SF-49; Mon, 18 Feb 2019 06:16:18 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvcDu-0006Rk-GO
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 06:16:16 +0000
Received: by mail-pf1-x442.google.com with SMTP id b7so8002670pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 22:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7HmJzfmEj9xsQYL5N418Naa1i0UMoglBgv9NHMmbkso=;
 b=u0wYuFCrQ3JpIshn7VtaCh9AO/+vjnQRnM+3SBXbL8JssbeCcgD9IXKVyfNz0uGYPp
 xaB/Lfcy7QYOH83IZHbos0EmyCUxk6QgSfmMPuZsRjm4bQ53Y4zdOitf6ldq3i95szAl
 1AwUDn6PLT5h1ONdIx6wfmaVbff/yd8tX0E/P80cYejQbxByLKnf52GO3Z0ah2twOKTe
 ZWOYZcKq0nKFLH7oh85WY0razVknpZfGUXrIFp21GhSYgJgjbcjuD9JeOPDijvF+jWrW
 9Lrvigo3WkpIcDnyl7n8PODNGh70i8gklKtlo32G5H1a/3oHr2DcDbJLg+SUgmCMnC74
 GDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7HmJzfmEj9xsQYL5N418Naa1i0UMoglBgv9NHMmbkso=;
 b=HonPz/OS1vzaypN5IybytDK7m40GDcYNfAVscbUwVHp0B3VsJdYtN1r3pTuuTSl9DN
 M+bm0WLdKCqd5u9b+5dlfCWETIGpTfyZPMFhPInPuwin8vYGzk5FD9VJl+PcMOwZjX0B
 1XJrc0nc7LYrg1JD6zeXuIxMzU+fceTcXoNlKfYtXfvnxe5fuM3DkpsBg92IiuGtFQFK
 iUqnnWkW5X3n66gJj5Ii5+fo8zV3n1DasiFjM6U9QB1m9qAdXh+ymC/jxH0rRfts2ws3
 1bbRR5a/Mj2yV6SMBxGv+jdB+/F6DgqVf+iGaNlF7gj4Y5t4A3PI77ulCRRUpWJNzlsA
 lAkw==
X-Gm-Message-State: AHQUAubPKlQS8QzOVlen9mi3CXo/JSWRjfSdWZjPbWjJLO+/U/7tE55i
 f0p49gmd3LvRBKyfiM2FPLlXlPzdXSY=
X-Google-Smtp-Source: AHgI3IaFZ0aCjQk8ePhCtVb1GFZ4f398NUPYKnOhFYn5oY1LZ0Ma65w9Rcm9u7fs0oTIqzQWrf486g==
X-Received: by 2002:a62:b286:: with SMTP id z6mr22587501pfl.106.1550470573467; 
 Sun, 17 Feb 2019 22:16:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id o6sm5219529pgo.27.2019.02.17.22.16.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 22:16:12 -0800 (PST)
Date: Mon, 18 Feb 2019 11:46:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] cpufreq: davinci: move configuration to
 include/linux/platform_data
Message-ID: <20190218061610.cwvwij7aoemi2gbe@vireshk-i7>
References: <20190214170505.27251-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190214170505.27251-1-brgl@bgdev.pl>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_221614_552035_95EF46DA 
X-CRM114-Status: GOOD (  22.47  )
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
Cc: linux-pm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14-02-19, 18:05, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The header containing the configuration structure for davinci cpufreq
> driver lives in mach-davinci/include/mach/. This is fine for now but
> if we want to make davinci part of the multi_v5 build, no code external
> to mach-davinci should include machine-specific headers.
> 
> Move the configuration structure to include/linux/platform_data.
> 
> While we're at it: convert the GPL-2.0 boilerplate to a proper SPDX
> license identifier.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/da850.c                 |  2 +-
>  arch/arm/mach-davinci/include/mach/cpufreq.h  | 26 -------------------
>  drivers/cpufreq/davinci-cpufreq.c             |  5 +---
>  include/linux/platform_data/davinci-cpufreq.h | 19 ++++++++++++++
>  4 files changed, 21 insertions(+), 31 deletions(-)
>  delete mode 100644 arch/arm/mach-davinci/include/mach/cpufreq.h
>  create mode 100644 include/linux/platform_data/davinci-cpufreq.h
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index e7b78df2bfef..a02ff431ba47 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -21,6 +21,7 @@
>  #include <linux/mfd/da8xx-cfgchip.h>
>  #include <linux/platform_data/clk-da8xx-cfgchip.h>
>  #include <linux/platform_data/clk-davinci-pll.h>
> +#include <linux/platform_data/davinci-cpufreq.h>
>  #include <linux/platform_data/gpio-davinci.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -29,7 +30,6 @@
>  #include <asm/mach/map.h>
>  
>  #include <mach/common.h>
> -#include <mach/cpufreq.h>
>  #include <mach/cputype.h>
>  #include <mach/da8xx.h>
>  #include <mach/irqs.h>
> diff --git a/arch/arm/mach-davinci/include/mach/cpufreq.h b/arch/arm/mach-davinci/include/mach/cpufreq.h
> deleted file mode 100644
> index 3c089cfb6cd6..000000000000
> --- a/arch/arm/mach-davinci/include/mach/cpufreq.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/*
> - * TI DaVinci CPUFreq platform support.
> - *
> - * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -#ifndef _MACH_DAVINCI_CPUFREQ_H
> -#define _MACH_DAVINCI_CPUFREQ_H
> -
> -#include <linux/cpufreq.h>
> -
> -struct davinci_cpufreq_config {
> -	struct cpufreq_frequency_table *freq_table;
> -	int (*set_voltage) (unsigned int index);
> -	int (*init) (void);
> -};
> -
> -#endif
> diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
> index d54a27c99121..940fe85db97a 100644
> --- a/drivers/cpufreq/davinci-cpufreq.c
> +++ b/drivers/cpufreq/davinci-cpufreq.c
> @@ -23,13 +23,10 @@
>  #include <linux/init.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> +#include <linux/platform_data/davinci-cpufreq.h>
>  #include <linux/platform_device.h>
>  #include <linux/export.h>
>  
> -#include <mach/hardware.h>
> -#include <mach/cpufreq.h>
> -#include <mach/common.h>
> -
>  struct davinci_cpufreq {
>  	struct device *dev;
>  	struct clk *armclk;
> diff --git a/include/linux/platform_data/davinci-cpufreq.h b/include/linux/platform_data/davinci-cpufreq.h
> new file mode 100644
> index 000000000000..3fbf9f2793b5
> --- /dev/null
> +++ b/include/linux/platform_data/davinci-cpufreq.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * TI DaVinci CPUFreq platform support.
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
> + */
> +
> +#ifndef _MACH_DAVINCI_CPUFREQ_H
> +#define _MACH_DAVINCI_CPUFREQ_H
> +
> +#include <linux/cpufreq.h>
> +
> +struct davinci_cpufreq_config {
> +	struct cpufreq_frequency_table *freq_table;
> +	int (*set_voltage)(unsigned int index);
> +	int (*init)(void);
> +};
> +
> +#endif /* _MACH_DAVINCI_CPUFREQ_H */

Applied. Thanks.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
