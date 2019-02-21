Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:08:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568CC2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ewYana+P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5Uj8oAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568CC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e5r76UlawvcMxMJnw8uHpCrknFJXpeVB06R/oUeL+Lk=; b=ewYana+PrWvIdX
	sySqRwWTNrPWBmHCBG4ZH+e3LvxyKh5XuVmqxsSMyTyXYGlKG2mFxE0SwxwCUa2fk5vny3a5K2+Tr
	YE06HsbUT0R0mNv5ebY719I+vUUOWXStS+RjG/m2X4y2LarguzMlDUXDS5NW1HnQY3qLAWQHzu74U
	0FF/bRf3uzuhskBZBXakFNlBAyPUybBqGUJ3ubRW8hbpeIc0ocXZZbMO2sHusWbUevSq8wDPJ6+Ru
	HUr8xTwfUYiNjr1kXZX+VHnJIwzyamFduTjy/l3SkQKXgvyYsTnDvI3PhNML3gvPAyh/Xtboiiy+v
	VZ76ObtlOatSmoDy3KSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwcqV-00045I-Pv; Thu, 21 Feb 2019 01:08:15 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwcqS-00044S-Ga
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 01:08:14 +0000
Received: by mail-pl1-x644.google.com with SMTP id bj4so13200206plb.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 17:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+MwAoYOpT9ux7AO6lENsVnVQ+WNftImlZm83B8lcQ5s=;
 b=u5Uj8oAmWT7xNcJbTmPd9RWDPuIji2eA9FcCsAPqKjzbW5iAay0Hrw78pjOxzXc5QA
 pGE862Mckauu8iVk1x0Rnq0Q8eRHwLhf+glSwwh0mbwpkNCkOgRgEscqA0iLIIagx2zs
 iMcvrqgQ8cY7n1aGJsUaoc7akhdruE9Dv0LnVFB4ezDAWX457S1xJmjbed78mRAFS+3K
 miAU8Z7prgz8hK/uwmG7HOldsToAybHCbNDj5QHN5zlXrGV47NVjWqvaIrNy15tCFdyI
 sGJcIot+J+79VUpUzOQkBmWEsbJmaFEQck1pSKTEhhm53kQbCOwTLiS1UpPe/DZQ4aFg
 J5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+MwAoYOpT9ux7AO6lENsVnVQ+WNftImlZm83B8lcQ5s=;
 b=k/yambWJIyjjPcGxRYw8yzDVh4vdeAAYM0VFh2XtYU3hFcYq4eXeWBg9k8WVthvNlX
 XtVt36eG0DMarmBP9eKNSEtE6LX0HdzFgVZlFvv21MnT2UgFB6purOwlqMo2KdFHKZdm
 VxZg8v1olC+GSx0DhzzcLcA7Hsac5o3GWaXHLp/yirI9e5eKIufGz0SeISBW3Ycqd3Bw
 yCnuJyeQl+0dPMLX652aEiKWNV0nzsLUxGfoeiET0T0r//1WPXTJkOckgTNPn1A/Je2c
 9k9r0Fy0qPr/Y8HvubzMuLS0ifFuddd6LKBlfKmOEr3NTKVWuOo6cMiR6wMNGy/mXKGe
 QQHw==
X-Gm-Message-State: AHQUAuYSCLX16E9luEYo3iFQ/ggcsq68HqKouzt9urba0n6eFFrLARAW
 eHBxMbbk0w5bHOxGUwVD0Hw=
X-Google-Smtp-Source: AHgI3IZJhQppPDFsjoqsua0hWRWz03cbw/guR705wqKsK4N7B3qYdevBdTZFbfa8EU5ExuetFAQ89w==
X-Received: by 2002:a17:902:a40d:: with SMTP id
 p13mr29445166plq.144.1550711291137; 
 Wed, 20 Feb 2019 17:08:11 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
 by smtp.gmail.com with ESMTPSA id 33sm20959989pgs.81.2019.02.20.17.08.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 17:08:10 -0800 (PST)
Date: Wed, 20 Feb 2019 17:08:07 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V7 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Message-ID: <20190221010805.GE31479@localhost.localdomain>
References: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
 <1550645332-2907-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550645332-2907-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_170812_554753_0DB7847B 
X-CRM114-Status: GOOD (  28.10  )
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
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 06:53:40AM +0000, Anson Huang wrote:
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and thermal sensors etc..
> 
> This patch adds i.MX system controller thermal driver support,
> Linux kernel has to communicate with system controller via MU
> (message unit) IPC to get each thermal sensor's temperature,
> it supports multiple sensors which are passed from device tree,
> please see the binding doc for details.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V6:
> 	- use "fsl,imx-sc-thermal" compatible to make SC thermal driver more generic for other i.MX8 SoCs
> 	  with system controller inside.
> ---
>  drivers/thermal/Kconfig          |  11 +++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/imx_sc_thermal.c | 161 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 173 insertions(+)
>  create mode 100644 drivers/thermal/imx_sc_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 58bb7d7..fec0ef5 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -223,6 +223,17 @@ config IMX_THERMAL
>  	  cpufreq is used as the cooling device to throttle CPUs when the
>  	  passive trip is crossed.
>  
> +config IMX_SC_THERMAL
> +	tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
> +	depends on (ARCH_MXC && IMX_SCU) || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
> +	  system controller inside, Linux kernel has to communicate with system
> +	  controller via MU (message unit) IPC to get temperature from thermal
> +	  sensor. It supports one critical trip point and one
> +	  passive trip point for each thermal sensor.
> +
>  config MAX77620_THERMAL
>  	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
>  	depends on MFD_MAX77620
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 486d682..4062627 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
>  obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
>  obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
>  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> +obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
>  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
>  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
>  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> new file mode 100644
> index 0000000..1a8b978
> --- /dev/null
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018-2019 NXP.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#include "thermal_core.h"
> +
> +#define IMX_SC_MISC_FUNC_GET_TEMP	13
> +#define IMX_SC_C_TEMP			0
> +
> +static struct imx_sc_ipc *thermal_ipc_handle;
> +
> +struct imx_sc_sensor {
> +	struct thermal_zone_device *tzd;
> +	u32 resource_id;
> +};
> +
> +struct imx_sc_thermal_data {
> +	struct imx_sc_sensor *sensor;
> +};
> +
> +struct req_get_temp {
> +	u16 resource_id;
> +	u8 type;
> +} __packed;
> +
> +struct resp_get_temp {
> +	u16 celsius;
> +	u8 tenths;
> +} __packed;
> +
> +struct imx_sc_msg_misc_get_temp {
> +	struct imx_sc_rpc_msg hdr;
> +	union {
> +		struct req_get_temp req;
> +		struct resp_get_temp resp;
> +	} data;
> +} __packed;
> +
> +static int imx_sc_thermal_get_temp(void *data, int *temp)
> +{
> +	struct imx_sc_msg_misc_get_temp msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	struct imx_sc_sensor *sensor = data;
> +	int ret;
> +
> +	msg.data.req.resource_id = sensor->resource_id;
> +	msg.data.req.type = IMX_SC_C_TEMP;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_MISC;
> +	hdr->func = IMX_SC_MISC_FUNC_GET_TEMP;
> +	hdr->size = 2;
> +
> +	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> +	if (ret) {
> +		pr_err("read temp sensor %d failed, ret %d\n",
> +			sensor->resource_id, ret);
> +		return ret;
> +	}
> +
> +	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops imx_sc_thermal_ops = {
> +	.get_temp = imx_sc_thermal_get_temp,
> +};
> +
> +static int imx_sc_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *sensor_np = NULL;
> +	struct imx_sc_thermal_data *data;
> +	struct imx_sc_sensor *sensors;
> +	u32 sensor_num;
> +	int ret, i;
> +
> +	ret = imx_scu_get_handle(&thermal_ipc_handle);
> +	if (ret)
> +		return ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32(np, "tsens-num", &sensor_num);
> +	if (ret || !sensor_num) {
> +		dev_err(&pdev->dev, "failed to get valid temp sensor number!\n");
> +		return -EINVAL;
> +	}
> +
> +	sensors = devm_kzalloc(&pdev->dev, sizeof(*data->sensor) * sensor_num,
> +			       GFP_KERNEL);
> +	if (!sensors)
> +		return -ENOMEM;
> +
> +	data->sensor = sensors;
> +
> +	np = of_find_node_by_name(NULL, "thermal-zones");
> +	if (!np)
> +		return -ENODEV;
> +
> +	for (i = 0; i < sensor_num; i++) {
> +		struct imx_sc_sensor *sensor = &data->sensor[i];
> +
> +		sensor_np = of_get_next_child(np, sensor_np);
> +		ret = of_property_read_u32(sensor_np, "imx,sensor-resource-id",

I think the idea here is to have imx,sensor-resource-id part of the
tsens node, not part of the thermal-zone node.

> +			&sensor->resource_id);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"failed to get valid sensor resource id: %d\n",
> +				ret);
> +			break;
> +		}
> +
> +		sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +								   i,
> +								   sensor,
> +								   &imx_sc_thermal_ops);
> +		if (IS_ERR(sensor->tzd)) {
> +			dev_err(&pdev->dev, "failed to register thermal zone\n");
> +			ret = PTR_ERR(sensor->tzd);
> +			break;
> +		}
> +	}
> +
> +	of_node_put(np);
> +	of_node_put(sensor_np);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id imx_sc_thermal_table[] = {
> +	{ .compatible = "fsl,imx-sc-thermal", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
> +
> +static struct platform_driver imx_sc_thermal_driver = {
> +		.probe = imx_sc_thermal_probe,
> +		.driver = {
> +			.name = "imx-sc-thermal",
> +			.of_match_table = imx_sc_thermal_table,
> +		},
> +};
> +module_platform_driver(imx_sc_thermal_driver);
> +
> +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> +MODULE_DESCRIPTION("Thermal driver for NXP i.MX SoCs with system controller");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
