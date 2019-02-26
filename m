Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D340BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:38:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96348218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GSBQUSCG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH6GKCwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96348218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qyTcEn3xhXfWkJDBK4BwvlvGvQorVyhup1sNxVGhCZg=; b=GSBQUSCGs1Oyvf
	t3ZFh2+ucoz/Avv3UIdmlaEW4Amzo9D+nwyMNNrRCGa2RclGkT8hU/mnLf0Z7NZdE9/ZXA95FwTqO
	alJvweGH2m4xc/Djvu20F+hmx+lTImN3UbmVoAWwsq6eJt3zIHDAUo0mJMPR+iNXvoywdMUMmvZUL
	TaaUOtGoTBKECQsiqjxumGwQp0vDZF9WioV1Oa/F9dbwKYYtXqIlhull+LLr97vv5YgnThRw1Zwgu
	uK5XgFZferAiyC2T8W91jR5wxvUZTU3vRclahJi+qTylOhufgryzeK+9ECng9o/pQVNxo/cwvM1r1
	YVTwpI+hIRlW8NzUDb+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gylNG-0005Yj-2d; Tue, 26 Feb 2019 22:38:54 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gylNB-0005Y5-Ne
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 22:38:51 +0000
Received: by mail-pl1-x643.google.com with SMTP id k2so6934872plt.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zE584vdXVod6LF4NiPoZPNA+WBQp766PtiUs1WqQ1po=;
 b=QH6GKCwYjP9oq+xXXA3Lu4kKyqFlUVm6BRlFootih/UrJQy3emptRAWgtYUqft8mAq
 VvVq4T9f2Uv5CEQrqbnV6cDD74k8LNnw5sIDgEorTB0qd2eL4QsmlZJ3YkYcM3ooXRvQ
 nlJE1bdpj94unyZAVNONVlT6DrtsLz4BfWJYYNsaooB+OH8fj1pI/bUZo8Ss5eomCVwu
 ZdZa808GPbzmV6tCxdWdqB9NTdmsZcmubG1tivnUQvae1n3e/dZjhhsmyA9pgOcFH/sP
 Zp/5K7EHFWiZl+Azje7ob2QlH6U7O1sF/FWrYM4mLiC5RndreWmA1m/9XNKNhzxV7Uad
 XQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=zE584vdXVod6LF4NiPoZPNA+WBQp766PtiUs1WqQ1po=;
 b=HaFJKhsST686vQuNKOLjpNh3xA/lWQd9DOkx9r+QEbx0mZOxMFEz576FjUaHy2fmR9
 dwHgGpfhtl1qINkXSM00QxKSAk1XQ5AyyUQgqqrKsTjL/LoeMh8Nq9z8XKHet0xNUjPu
 wAxmvGqGyf7TREraU9ndtRvfpHnvUMzAAYfDA0/IZsLNUeuZsWDd8ag8RIsI9r0jjFsf
 /VoGtEWD2MywzJcqyWHj8eMb8T3hNzjx3XITQnMbqIxwu5lBzv+0NTfA91nVvPQmIi/k
 EglGU8ZV82qqTl5TF1PY4+4uVxL04YbNKUjvaZebxztXlvpoBYYPu/w7ne2cXGf0p4u7
 /MiQ==
X-Gm-Message-State: AHQUAubBkxsTSG0ERZHAIvMJq9bNtCRk7CIPEaJ30jHb68L0fNuF+B1p
 paqdPL6gYgu/vrhwIRsAs50=
X-Google-Smtp-Source: AHgI3IZI/rcdqwErHeuoUohbCmNoRmJVHdEEvmIE7/tO7EX5PRReElIXMDoakA2xzgdwL/rx0Zdi3w==
X-Received: by 2002:a17:902:801:: with SMTP id
 1mr13070017plk.299.1551220728639; 
 Tue, 26 Feb 2019 14:38:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id m3sm13045421pgp.85.2019.02.26.14.38.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 14:38:47 -0800 (PST)
Date: Tue, 26 Feb 2019 14:38:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V3 2/4] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Message-ID: <20190226223846.GB30985@roeck-us.net>
References: <1551060850-22553-1-git-send-email-Anson.Huang@nxp.com>
 <1551060850-22553-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1551060850-22553-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_143849_770802_52294580 
X-CRM114-Status: GOOD (  32.95  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 02:19:10AM +0000, Anson Huang wrote:
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and watchdog etc..
> 
> This patch adds i.MX system controller watchdog driver support,
> watchdog operation needs to be done in secure EL3 mode via
> ARM-Trusted-Firmware, using SMC call, CPU will trap into
> ARM-Trusted-Firmware and then it will request system controller
> to do watchdog operation via IPC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- improve watchdog_init_timeout() operation and error check, setting it
> 	  via module parameter "timeout", if it is invalid, roll back to use defaul
> 	  timeout value DEFAULT_TIMEOUT;
> 	- change compatible string to "fsl,imx-sc-wdt" to make driver more generic
> 	  for all i.MX platforms with system controller watchdog inside.
> ---
>  drivers/watchdog/Kconfig      |  13 +++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/imx_sc_wdt.c | 183 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 197 insertions(+)
>  create mode 100644 drivers/watchdog/imx_sc_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 65c3c42..5c5b8ba 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -625,6 +625,19 @@ config IMX2_WDT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called imx2_wdt.
>  
> +config IMX_SC_WDT
> +	tristate "IMX SC Watchdog"
> +	depends on ARCH_MXC || COMPILE_TEST

Wondering: Did you test on other architectures ? The code calls
arm_smccc_smc(), which is unlikely to be available on non-ARM
platforms, and I don't see a dummy declaration for those.

> +	select WATCHDOG_CORE
> +	help
> +	  This is the driver for the system controller watchdog
> +	  on the NXP i.MX SoCs with system controller inside.
> +	  If you have one of these processors and wish to have
> +	  watchdog support enabled, say Y, otherwise say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called imx_sc_wdt.
> +
>  config UX500_WATCHDOG
>  	tristate "ST-Ericsson Ux500 watchdog"
>  	depends on MFD_DB8500_PRCMU
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 4e78a8c..0c9da63 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
>  obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
>  obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>  obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
> +obj-$(CONFIG_IMX_SC_WDT) += imx_sc_wdt.o
>  obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
>  obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
>  obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
> diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
> new file mode 100644
> index 0000000..7b22575
> --- /dev/null
> +++ b/drivers/watchdog/imx_sc_wdt.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018-2019 NXP.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/watchdog.h>
> +
> +#define DEFAULT_TIMEOUT 60
> +/*
> + * Software timer tick implemented in scfw side, support 10ms to 0xffffffff ms
> + * in theory, but for normal case, 1s~128s is enough, you can change this max
> + * value in case it's not enough.
> + */
> +#define MAX_TIMEOUT 128
> +
> +#define IMX_SIP_TIMER			0xC2000002
> +#define IMX_SIP_TIMER_START_WDOG		0x01
> +#define IMX_SIP_TIMER_STOP_WDOG		0x02
> +#define IMX_SIP_TIMER_SET_WDOG_ACT	0x03
> +#define IMX_SIP_TIMER_PING_WDOG		0x04
> +#define IMX_SIP_TIMER_SET_TIMEOUT_WDOG	0x05
> +#define IMX_SIP_TIMER_GET_WDOG_STAT	0x06
> +#define IMX_SIP_TIMER_SET_PRETIME_WDOG	0x07
> +
> +#define SC_TIMER_WDOG_ACTION_PARTITION	0
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0000);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static unsigned int timeout = DEFAULT_TIMEOUT;

I assume this means that you specifically do _not_ want to support
timeout configuration via devicetree (unless the user explicitly sets
the timeout to 0 here).

Not that it really matters, since it looks like Rob won't accept a
watchdog node anyway.

> +module_param(timeout, uint, 0000);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> +		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
> +
> +static int imx_sc_wdt_ping(struct watchdog_device *wdog)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;

I didn't comment on this before, but I am wondering: Does the 
system controller code return Linux error codes ? Is this
documented somewhere ?

> +}
> +
> +static int imx_sc_wdt_start(struct watchdog_device *wdog)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_START_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0)
> +		return res.a0;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_WDOG_ACT,
> +		      SC_TIMER_WDOG_ACTION_PARTITION,
> +		      0, 0, 0, 0, 0, &res);
> +	return res.a0;
> +}
> +
> +static int imx_sc_wdt_stop(struct watchdog_device *wdog)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_STOP_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +static int imx_sc_wdt_set_timeout(struct watchdog_device *wdog,
> +				unsigned int timeout)
> +{
> +	struct arm_smccc_res res;
> +
> +	wdog->timeout = timeout;
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_TIMEOUT_WDOG,
> +		      timeout * 1000, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +static const struct watchdog_ops imx_sc_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = imx_sc_wdt_start,
> +	.stop  = imx_sc_wdt_stop,
> +	.ping  = imx_sc_wdt_ping,
> +	.set_timeout = imx_sc_wdt_set_timeout,
> +};
> +
> +static const struct watchdog_info imx_sc_wdt_info = {
> +	.identity	= "i.MX SC watchdog timer",
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> +			  WDIOF_MAGICCLOSE | WDIOF_PRETIMEOUT,
> +};
> +
> +static int imx_sc_wdt_probe(struct platform_device *pdev)
> +{
> +	struct watchdog_device *imx_sc_wdd;
> +	int ret;
> +
> +	imx_sc_wdd = devm_kzalloc(&pdev->dev, sizeof(*imx_sc_wdd), GFP_KERNEL);
> +	if (!imx_sc_wdd)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, imx_sc_wdd);
> +
> +	imx_sc_wdd->info = &imx_sc_wdt_info;
> +	imx_sc_wdd->ops = &imx_sc_wdt_ops;
> +	imx_sc_wdd->min_timeout = 1;
> +	imx_sc_wdd->max_timeout = MAX_TIMEOUT;
> +	imx_sc_wdd->parent = &pdev->dev;
> +	imx_sc_wdd->timeout = DEFAULT_TIMEOUT;
> +
> +	ret = watchdog_init_timeout(imx_sc_wdd, timeout, &pdev->dev);
> +	if (ret)
> +		dev_warn(&pdev->dev, "Failed to set timeout value, using default\n");
> +
> +	watchdog_stop_on_reboot(imx_sc_wdd);
> +	watchdog_stop_on_unregister(imx_sc_wdd);
> +
> +	ret = devm_watchdog_register_device(&pdev->dev, imx_sc_wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx_sc_wdt_dt_ids[] = {
> +	{ .compatible = "fsl,imx-sc-wdt", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_sc_wdt_dt_ids);

I assume this will be dropped and replaced with platform code,
per feedback from Rob.

> +
> +static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
> +{
> +	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(imx_sc_wdd))
> +		imx_sc_wdt_stop(imx_sc_wdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imx_sc_wdt_resume(struct device *dev)
> +{
> +	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(imx_sc_wdd))
> +		imx_sc_wdt_start(imx_sc_wdd);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(imx_sc_wdt_pm_ops,
> +			 imx_sc_wdt_suspend, imx_sc_wdt_resume);
> +
> +static struct platform_driver imx_sc_wdt_driver = {
> +	.probe		= imx_sc_wdt_probe,
> +	.driver		= {
> +		.name	= "imx-sc-wdt",
> +		.of_match_table = imx_sc_wdt_dt_ids,
> +		.pm	= &imx_sc_wdt_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(imx_sc_wdt_driver);
> +
> +MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
> +MODULE_LICENSE("GPL v2");

The module license conflicts with the SPDX license which says 2.0+.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
