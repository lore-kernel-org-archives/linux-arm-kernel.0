Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BDAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:30:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685812054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aV1NGk3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685812054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oBLLInckEBiEhWWOCZA1e6r7L7w0Q578JbZKJsJkpVw=; b=aV1NGk3uFvrVg2
	OvsMcPkcO4K6MIgERjhPzViaulIX/6YK37Q7B/gnq4juVHxCe0CxPFcpaRqRBiwknHWlR8mPps/xK
	XLjivVS7gJu1bMrBG79aOx00VSZwRPLAQaNk+Yl1rllA6q/vrhhHAJJNot+PfC40z+ee00mCI9epX
	qBDTOxPHqw6OW+UuyGCHJvj22/DUAopyq0KJAq3sJP9mU59HOKxRuzyDIM4Ag2Jp64omLsaX6au3Q
	kqivgNTtgR2MkQUKkgyJ+JUwCSdXRhQi/dIMllv+8niGD6pmVi6t3YQYFTxOAnYYB3s6d6wT8370q
	6rZmDGQCsE7LTtyaExeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4w6-00081M-LK; Thu, 17 Jan 2019 10:30:10 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4w0-0007A2-FO; Thu, 17 Jan 2019 10:30:09 +0000
Received: by mail-oi1-f193.google.com with SMTP id j21so5726168oii.8;
 Thu, 17 Jan 2019 02:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YqqRphGnJzsRzdaLJuldaRmPzGoWSZOWhc9427yChCc=;
 b=ldXN4APWiTufJ2NuE4Y0jIb+FAH9OBVSw+YAT9SpwQfl+oIoEsRRRXswcYw6Gn4c8q
 MGmF7oa6FADDUxOPwQgIuLPxmYaPdz7GiRCxWG4QWNchdTcWzIexlNVwdRy6S8hWec28
 BmqSKuMVMMyBagBdWecz496doE1oTUyqHZeiw4EW/1WjQXHCb9v1ExiB7geeYQhjcRyL
 PcUCb1nChSL4kORCrjuXzbFZR912mPsoxZqBFuxU7R0Wyw4nk5WRviC/Yia6KisN++fG
 B+fe22xW+1IC6/b1+Nm+6f7Luqmq4z7GwFefS+F05y9YYmrrTpMSfJUPiASKRX81tpgO
 QIlw==
X-Gm-Message-State: AJcUukfB5WjHf9V3HnpMLEqh0MPvkzx3nmOEUQMoZFMWUUMrkX6zoOvp
 JhNucIQDSwoPt7NzT7XoUx22hh9hkNZ0NlsVAIh5Bt/g
X-Google-Smtp-Source: ALg8bN5Pl7GIKi+AiDGRjGctjfB8HID90yS5d/N2wvoKiOq24u5Ay2ooDoEFuWRNrgDdaWEb4MYrNi24M3v/yHQ84AI=
X-Received: by 2002:aca:368a:: with SMTP id d132mr1150780oia.193.1547721003197; 
 Thu, 17 Jan 2019 02:30:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7>
 <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
 <20190117102107.2n5liu325alisxhd@vireshk-i7>
In-Reply-To: <20190117102107.2n5liu325alisxhd@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jan 2019 11:29:52 +0100
Message-ID: <CAJZ5v0hU_y=PG94_58ELdwUzk9CzvJqiuQ7GjvfFh23KxXj6fQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_023004_522182_9AE2A6D4 
X-CRM114-Status: GOOD (  25.16  )
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
Cc: Doug Anderson <dianders@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, Stephen Boyd <swboyd@chromium.org>,
 Eduardo Valentin <edubezval@gmail.com>, Matthias Kaehlcke <mka@chromium.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 11:21 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-01-19, 11:08, Rafael J. Wysocki wrote:
> > On Thu, Jan 17, 2019 at 6:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > 1. Have following for CONFIG_CPU_FREQ
> > >        depends on !CPU_THERMAL || THERMAL
> >
> > Sorry, but this makes my teeth hurt.
>
> I knew it :)
>
> > >    The platforms which don't need CPU_THERMAL (like x86) should not
> > >    enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.
> > >
> > >    @amit: If this gets accepted, please update the Kconfig entries for
> > >    all those drivers to not have above lines anymore.
> > >
> > > - Change CONFIG_THERMAL to bool instead of tristate ?
> > >
> > > - Anything else ?
> >
> > The design in the thermal subsystem seems to be upside-down.
> > Non-modular code should never be made depend on anything only defined
> > in a module.
> >
> > Would an explicit "select THERMAL" under CPU_THERMAL cause THERMAL to be 'y'?
>
> That causes recursive-dependency issues:
>
> drivers/thermal/Kconfig:5:error: recursive dependency detected!
> drivers/thermal/Kconfig:5:      symbol THERMAL is selected by CPU_THERMAL
> drivers/thermal/Kconfig:16:     symbol CPU_THERMAL depends on THERMAL_OF
> drivers/thermal/Kconfig:70:     symbol THERMAL_OF depends on THERMAL
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
>
> something like this works though:
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 30323426902e..ee9f9f2a795b 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -13,6 +13,20 @@ menuconfig THERMAL
>           All platforms with ACPI thermal support can use this driver.
>           If you want this support, you should say Y or M here.
>
> +config CPU_THERMAL
> +       bool "generic cpu cooling support"
> +       depends on CPU_FREQ
> +       select THERMAL_OF
> +       select THERMAL
> +       help
> +         This implements the generic cpu cooling mechanism through frequency
> +         reduction. An ACPI version of this already exists
> +         (drivers/acpi/processor_thermal.c).
> +         This will be useful for platforms using the generic thermal interface
> +         and not the ACPI interface.
> +
> +         If you want this support, you should say Y here.
> +

My sort of educated guess is that it is under the "if THERMAL" so that
it doesn't show up at all when THERMAL is unset.

>  if THERMAL
>
>  config THERMAL_STATISTICS
> @@ -148,19 +162,6 @@ config THERMAL_GOV_POWER_ALLOCATOR
>           Enable this to manage platform thermals by dynamically
>           allocating and limiting power to devices.
>
> -config CPU_THERMAL
> -       bool "generic cpu cooling support"
> -       depends on CPU_FREQ

But what about adding

      depends on THERMAL=y

here as I said in the other message?

> -       depends on THERMAL_OF
> -       help
> -         This implements the generic cpu cooling mechanism through frequency
> -         reduction. An ACPI version of this already exists
> -         (drivers/acpi/processor_thermal.c).
> -         This will be useful for platforms using the generic thermal interface
> -         and not the ACPI interface.
> -
> -         If you want this support, you should say Y here.
> -
>  config CLOCK_THERMAL
>         bool "Generic clock cooling support"
>         depends on COMMON_CLK
>
>
> What about make CONFIG_THERMAL bool instead ? Who wants it to be a module ?
>
> $ git grep "CONFIG_THERMAL=m"
> arch/arm/configs/mini2440_defconfig:CONFIG_THERMAL=m
> arch/arm/configs/omap2plus_defconfig:CONFIG_THERMAL=m
> arch/arm/configs/pxa_defconfig:CONFIG_THERMAL=m
> arch/mips/configs/ip22_defconfig:CONFIG_THERMAL=m
> arch/mips/configs/ip27_defconfig:CONFIG_THERMAL=m
> arch/unicore32/configs/unicore32_defconfig:#CONFIG_THERMAL=m
>
> Not sure if they really want this code out :(

Me neither.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
