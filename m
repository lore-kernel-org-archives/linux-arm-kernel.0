Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51DDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A510F2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YW7wYj13";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeEY0/95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A510F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XOLBS5cwp0OA6WxKpsyaZ97TDbcATk+FC02fCsLIJXc=; b=YW7wYj13SOCLJ2
	3m9gO/9FRmTVfqLOfncpBiLjOQb/q07hMutWuDDxdb4k29D+BrU4550dmn1VvLICFrwpzPecs9v2H
	zCKXpkuHco2El41E8NjET5KHjr0/8gi8mdzlGrApZcl44fmHqT2Ki3QI91jm1GdIrFwla83nAFBsH
	kqw8+TetleiWzNw4HbLq/2VMXCAJawdwhwefj/HiSw3stuMHVoZ/5KQamPPjH3Yor7GI3BPQ446lN
	YLUBI11Px++r++Y0iLmwmwQ8NYG/0FMadSF6kj1io2lnmk8DiuXFoExfnj94Ao3Pcjtkhh7luwFOU
	9Q8InNoI/2FjrP2iCX8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4nV-0004NL-2M; Thu, 17 Jan 2019 10:21:17 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4nP-0004M5-D6
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 10:21:13 +0000
Received: by mail-pf1-x443.google.com with SMTP id u6so4611405pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 02:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oqgQwgs6rpK2rfGYhVxoq0wejotpg6+UVg0B/eSnCeE=;
 b=jeEY0/959wN0YxccsGI/CTJT2VzDCV/l6S1FQ8sSHUBi48H+rBqDrdX7nCbGHbVfMB
 wb0w9wJ27i4ZPLv8Q9Pn9Z5jcuwVrrBg+UmYLSahDRnCpr4jH05BIs4fEFXW3ZJ8KNYc
 Mdyq3wYjtMaNpOWyhvEw2tLuBKZsUd3Bc0vDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oqgQwgs6rpK2rfGYhVxoq0wejotpg6+UVg0B/eSnCeE=;
 b=jN1qjV78rGyyDvuuDm2H5AERCWTVTLYlMhyRTr9lAKpBXWY4PHcn+Dpy2lSwgSYc9F
 Dj38b+lXndo2VS4geueEHPxsKohSdL7ZVZ0xgVoGI/y6c5cQzqJPybIW340dD1YbFKXW
 x9z/hdA34Ogh9fjkDQ1OgQlWpEey/nw4IfbN1ZubTjZDHM3VTi2mXfvIsyYXtFMD6zb4
 5TVGxPR+QN7uojfhJVVGnmqEcEN+jMKUtd1EBeWky0fsKNrQimeTCJ3nMG4HzCmZreU5
 cYlke9o6LdFjyehja0QkhbmsTMrSCuAARq36mazd9BAKs9gyhcPwnHaZL8324Xf2YXC6
 uVpA==
X-Gm-Message-State: AJcUuke2Hy6kXeIO3cLq3FH7Ak5OP9xeh0K3tbhB93vRjPAgvo/aGHX5
 w0wODOwkKxJsuUXyZ9DjaD2iNw==
X-Google-Smtp-Source: ALg8bN6MTC7thPoTs7+Xox6pv36amOnDc5uTXBe37RUBTUz9BctIb26+Ih9VFUT9liltJE2q3pUeRA==
X-Received: by 2002:a62:d885:: with SMTP id
 e127mr14258586pfg.197.1547720470387; 
 Thu, 17 Jan 2019 02:21:10 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id r66sm2754116pfk.157.2019.01.17.02.21.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 02:21:09 -0800 (PST)
Date: Thu, 17 Jan 2019 15:51:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
Message-ID: <20190117102107.2n5liu325alisxhd@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7>
 <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_022111_501288_E868CD7D 
X-CRM114-Status: GOOD (  18.31  )
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
Cc: "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eduardo Valentin <edubezval@gmail.com>, Matthias Kaehlcke <mka@chromium.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Stephen Boyd <swboyd@chromium.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17-01-19, 11:08, Rafael J. Wysocki wrote:
> On Thu, Jan 17, 2019 at 6:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > 1. Have following for CONFIG_CPU_FREQ
> >        depends on !CPU_THERMAL || THERMAL
> 
> Sorry, but this makes my teeth hurt.

I knew it :)

> >    The platforms which don't need CPU_THERMAL (like x86) should not
> >    enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.
> >
> >    @amit: If this gets accepted, please update the Kconfig entries for
> >    all those drivers to not have above lines anymore.
> >
> > - Change CONFIG_THERMAL to bool instead of tristate ?
> >
> > - Anything else ?
> 
> The design in the thermal subsystem seems to be upside-down.
> Non-modular code should never be made depend on anything only defined
> in a module.
> 
> Would an explicit "select THERMAL" under CPU_THERMAL cause THERMAL to be 'y'?

That causes recursive-dependency issues:

drivers/thermal/Kconfig:5:error: recursive dependency detected!
drivers/thermal/Kconfig:5:      symbol THERMAL is selected by CPU_THERMAL
drivers/thermal/Kconfig:16:     symbol CPU_THERMAL depends on THERMAL_OF
drivers/thermal/Kconfig:70:     symbol THERMAL_OF depends on THERMAL
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"

something like this works though:

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 30323426902e..ee9f9f2a795b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -13,6 +13,20 @@ menuconfig THERMAL
          All platforms with ACPI thermal support can use this driver.
          If you want this support, you should say Y or M here.
 
+config CPU_THERMAL
+       bool "generic cpu cooling support"
+       depends on CPU_FREQ
+       select THERMAL_OF
+       select THERMAL
+       help
+         This implements the generic cpu cooling mechanism through frequency
+         reduction. An ACPI version of this already exists
+         (drivers/acpi/processor_thermal.c).
+         This will be useful for platforms using the generic thermal interface
+         and not the ACPI interface.
+
+         If you want this support, you should say Y here.
+
 if THERMAL
 
 config THERMAL_STATISTICS
@@ -148,19 +162,6 @@ config THERMAL_GOV_POWER_ALLOCATOR
          Enable this to manage platform thermals by dynamically
          allocating and limiting power to devices.
 
-config CPU_THERMAL
-       bool "generic cpu cooling support"
-       depends on CPU_FREQ
-       depends on THERMAL_OF
-       help
-         This implements the generic cpu cooling mechanism through frequency
-         reduction. An ACPI version of this already exists
-         (drivers/acpi/processor_thermal.c).
-         This will be useful for platforms using the generic thermal interface
-         and not the ACPI interface.
-
-         If you want this support, you should say Y here.
-
 config CLOCK_THERMAL
        bool "Generic clock cooling support"
        depends on COMMON_CLK


What about make CONFIG_THERMAL bool instead ? Who wants it to be a module ?

$ git grep "CONFIG_THERMAL=m"
arch/arm/configs/mini2440_defconfig:CONFIG_THERMAL=m
arch/arm/configs/omap2plus_defconfig:CONFIG_THERMAL=m
arch/arm/configs/pxa_defconfig:CONFIG_THERMAL=m
arch/mips/configs/ip22_defconfig:CONFIG_THERMAL=m
arch/mips/configs/ip27_defconfig:CONFIG_THERMAL=m
arch/unicore32/configs/unicore32_defconfig:#CONFIG_THERMAL=m

Not sure if they really want this code out :(

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
