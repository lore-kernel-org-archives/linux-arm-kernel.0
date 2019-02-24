Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA74C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:29:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A8820840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvrQklty";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/GCzRu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A8820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bHwFtdxrXQsrdQ3gjohcqr5WR13raFF9Q4rQnoNhB9k=; b=cvrQkltylP4+mdWaEfsBux3t9
	NV0g+g1nkxbYMHvTh3+fkDeJ2oD7qDZqG1jG4p6OaiR+GcR4vNSxAToY0uH8C/Y8Au1CYTgBf3MSa
	lVvWX+Ux91xMZGKYIkxNAtE5P/BdieI0VZmli5zWHuRhKUWVLll3dGTNdcQcuR1aDoP4M/MrckkCh
	KNNhKLtQAhqYEE1yUtTJFqRxD8NFhcILweCMmb8+EinOd6ow9DvP+NZahoGuI+v5iTh1SE+m+qi7P
	ZaOYawgmi48CGSr53P/xIL3SnMP/PWUfnyML5ksC6Z9EUbvjA633/bZyr6NGU/XL4uROYvD4LBcxC
	Ihl6c6jkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxkTT-0006c4-35; Sun, 24 Feb 2019 03:29:07 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxkTQ-0006bk-A0
 for linux-arm-kernel@lists.infradead.org; Sun, 24 Feb 2019 03:29:06 +0000
Received: by mail-pl1-x642.google.com with SMTP id s1so2884073plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 19:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v5R5LCGjAlFCGhFSnspcqiVvj2dc3luKtcjDkiR+PU0=;
 b=j/GCzRu2vT4DNYcV1gq9//xX1rrZz6vW+mwKXGLfS4MC3i8oCdIKHDpQHtkdKnGmGD
 Iod5ptSz6+/wE41F7vaQsMVSUZtmNHztdc2Ja3GiIrZ5TQos5pCxmWAytGcM3mYSVwVK
 bRcIVJCLdXeK9tACHp318Pt+pjCVWLdyApSC1AqI7TWQHz7nv9c9J9NMYTBo0sFkKiad
 xnylVj6/M3GF8YUNgHB3HR+cUcSlCTITTHVZmnt6ULVvrgvBASOWioGSYr/P7WFlYH3q
 ltTeKMvJkcKlCiQh0wpk4Glar2pcoxm+L4Jt+rUl+usi2HDaBSbfPZksA9jHf59Bi1+4
 6Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v5R5LCGjAlFCGhFSnspcqiVvj2dc3luKtcjDkiR+PU0=;
 b=e8QW6Re9I2aShP90k42CrcLurdnf2HhWNMTMZy8oFO+agEp8hB6784rftXpEXnDYZP
 w2toUj6tIhzLjNNHHAytawMQLDVglZvpnMXLaSMwVkBR71VW7N3mw/UkQGvIOToryWx5
 +pL+tINAb3bXSHkTRrYFtdEcUD0oOfdsrsFpEEAkx9cn7A/NaN4fQkPJr6YL4CrZ7bL0
 JCBn3VJkWKE0taspYFUhjsYoppZSxjBXM5E/3uhy7lsdah1JEwtwOGbaES+3DydkKYTn
 hRLWGxuTz3TBJrIXKeiHUumdSDarO7yRq1tgotFHoemRGtCoB/CR6X2OYEsTJqIoceGY
 Ulcw==
X-Gm-Message-State: AHQUAubkWl2JvLI6PSA9tlXM9DoytXZ0bWlykkDi7Tcxw5ja/1lgqkwt
 Ks2A/4RI7EWlegQQlgfN3U0=
X-Google-Smtp-Source: AHgI3Ia9R2c1ss7zYNae4m0mgNhPhwVQ+A4+cPZvVGiTV00jvwlajfrkhlfXrKdqtSJPvro/jjO1fg==
X-Received: by 2002:a17:902:298a:: with SMTP id
 h10mr12225949plb.312.1550978943359; 
 Sat, 23 Feb 2019 19:29:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 e63sm14631470pfc.47.2019.02.23.19.29.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 19:29:02 -0800 (PST)
Subject: Re: [PATCH RESEND V2 2/4] watchdog: imx_sc: Add i.MX system
 controller watchdog support
To: Anson Huang <anson.huang@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "heiko@sntech.de" <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "olof@lixom.net" <olof@lixom.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-3-git-send-email-Anson.Huang@nxp.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a66a3bcd-ceed-bc4b-1b66-c3ce2c7addeb@roeck-us.net>
Date: Sat, 23 Feb 2019 19:29:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550472539-16590-3-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_192904_372475_6C7B5D4A 
X-CRM114-Status: GOOD (  33.72  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/17/19 10:53 PM, Anson Huang wrote:
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

Sorry, but I have to take back my Reviewed-by: Comments below.
Sorry, I completely missed that earlier.

> ---
> Changes since V1:
>          - use watchdog_active() instead of comparing watchdog status directly;
>          - use devm_kzalloc instead of using static variable;
>          - remove unnecessary wdog set driver data in .probe;
>          - use watchdog_stop_on_unregister() instead of .remove callback;
>          - use watchdog_stop_on_reboot() instead of .shutdown callback;
>          - use SIMPLE_DEV_PM_OPS() to simply the PM code.
> ---
>   drivers/watchdog/Kconfig      |  13 +++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/imx_sc_wdt.c | 185 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 199 insertions(+)
>   create mode 100644 drivers/watchdog/imx_sc_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 65c3c42..5c5b8ba 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -625,6 +625,19 @@ config IMX2_WDT
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called imx2_wdt.
>   
> +config IMX_SC_WDT
> +	tristate "IMX SC Watchdog"
> +	depends on ARCH_MXC || COMPILE_TEST
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
>   config UX500_WATCHDOG
>   	tristate "ST-Ericsson Ux500 watchdog"
>   	depends on MFD_DB8500_PRCMU
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 4e78a8c..0c9da63 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
>   obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
>   obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>   obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
> +obj-$(CONFIG_IMX_SC_WDT) += imx_sc_wdt.o
>   obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
>   obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
>   obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
> diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
> new file mode 100644
> index 0000000..a234a0c
> --- /dev/null
> +++ b/drivers/watchdog/imx_sc_wdt.c
> @@ -0,0 +1,185 @@
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

Should not be initialized.

> +module_param(timeout, uint, 0000);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> +		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
> +

This suggests that you want to use that timeout. But that isn't the case.




> +static int imx_sc_wdt_ping(struct watchdog_device *wdog)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
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

	imx_sc_wdd->timeout = DEFAULT_TIMEOUT;

> +
> +	ret = watchdog_init_timeout(imx_sc_wdd, DEFAULT_TIMEOUT, &pdev->dev);

As written this doesn't make sense: It will set the timeout to the default,
which is always valid, making the error check unnecessary. I assume you meant
the above plus
	ret = watchdog_init_timeout(imx_sc_wdd, timeout, &pdev->dev);

By not pre=initializing 'timeout', the watchdog core will try to read the
configured timeout from devicetree. If it is not specified, it will keep
the default timeout which should be set explicitly as suggested above.

With that, the error check makes some sense, though it is unusual to
bail out if an out-of-range timeout was specified. But that is your call.

Again, sorry for not noticing this earlier.

Guenter

> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to init the wdog timeout:%d\n",
> +			ret);
> +		return ret;
> +	}
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
> +	{ .compatible = "fsl,imx8qxp-sc-wdt", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_sc_wdt_dt_ids);
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
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
