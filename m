Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2965BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 22:44:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA64A21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 22:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TfX+rDtb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHKOClCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA64A21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7xwK/t/n/u3H/mZIqg8fmKL+wNB2c2YfRd67iO22QtI=; b=TfX+rDtbJEc528
	1Yh+CrlVkyh3HFFYmkz6DCcvgJ7v1JuZVIpWUFiZGAdkcntvPVl5oHwt2tL0iMi6Pbc1l8+bczm1p
	dcRpqx4YKBb3bpBH/69CtKF2v4RZNOfggyBuaV0jV6eEsd2z2JD6JUGIsXHuvYACD2aFm2k7/JRZP
	sbTDYcG8Ssad2jdVs3+t4loMgX4fszc46AJa187NPJLyK1hKvMjdN+5rzDj7eMRGeGZKgctv9e5bO
	v0aV9iRbolkM4137NHw2h+hnwZY+TwBc4YEcsWv+fPcxK9GkHUzxgKk6Bi18L6gQUiX5vuUHvF0+a
	+yNNVbXXRAhCZXD/p3xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbvQb-0007EO-7W; Tue, 25 Dec 2018 22:43:57 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbvQX-0007Cq-19
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 22:43:54 +0000
Received: by mail-pl1-x641.google.com with SMTP id u6so6854255plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 14:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8GHQxmoLZs2G5pMsfkz3pDgeAFDkKLjxQ8PCh4j1qHs=;
 b=PHKOClCko0cl4dPg7qfflSxfOxbPCjdo+8AuHmaed75LRciA102OGnjgNFJZ3l+hk4
 0HbiSKpWDD4fa/9g3y1YNd20dj/OAP7rfmqR+/3eO29Wkhw8DaEIeNIm/0Pl+YI+Onae
 yueSDpRKpu3ukispSSpW6SS/vPt6Oymjt6A6rfBNrfyrNUF/bsaG1jQE9qgjPgdZY2p5
 MXfvdPnRbn8XMDYXFbof/uw6LfWBYTVPKXRO1IJGswf3hIAwPSSnxFyM+/3hhj4f2YnY
 UqdRDSeLV4hfJdH9Q13ua0o/dVfTl67LYVF9WHvkaYOzyIk3trav7BoeLlAjUmvBNshI
 pS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8GHQxmoLZs2G5pMsfkz3pDgeAFDkKLjxQ8PCh4j1qHs=;
 b=Y5oiV2OzD4XfpRnXt7dNvJVxJLjZi1IbQdEWfkB3q0UjFRpkILZZFuyoVDqucGEmvL
 pSfRCIDm33vq9fF4YP8bqxeNlhE71NkwZgDYAC8nVittrhBBcF6Hx+zjQi1lO2a0Bkiq
 DbAvcfSjpLW0nBnR9W7/4BicTj2a9TDLyR18XcAxzSvS5N1KDGwVTplLc2OfjOSvGHij
 oUiWzPcvQje+hozfV22it9gPbpLmN1iH+StcBkQPzW57HHlDq4+8mOSLg6P4cRt1SrKK
 GY0/s0MUIDHAYhmCYXsj6Ja5UM3bKQcwCyoy+9hmU+j4S65EuQli9Nt47V09pYh602Sr
 KlcQ==
X-Gm-Message-State: AJcUukfgrBx2axytiqhrHQJap5i5YImrPw6DYzlN7GKbEr+BfI6YgZzl
 S6W8l3zbARVzRLPcy+7oh80=
X-Google-Smtp-Source: ALg8bN5ySgdQDIQiOJjeYBeJk2BulL9Uz41lDhz5CRh4dPl9gZBkH35XR/saqRvn5g5mJfQ/h+6q9A==
X-Received: by 2002:a17:902:20e9:: with SMTP id
 v38mr16959547plg.250.1545777821783; 
 Tue, 25 Dec 2018 14:43:41 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
 by smtp.gmail.com with ESMTPSA id a195sm40311947pfa.7.2018.12.25.14.43.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Dec 2018 14:43:40 -0800 (PST)
Date: Tue, 25 Dec 2018 14:43:38 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V5 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Message-ID: <20181225224336.GA8220@localhost.localdomain>
References: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
 <1545296609-20477-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545296609-20477-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_144353_077112_15DBD602 
X-CRM114-Status: GOOD (  29.62  )
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
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 dl-linux-imx <linux-imx@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "ezequiel@collabora.com" <ezequiel@collabora.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 09:08:32AM +0000, Anson Huang wrote:
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
> ChangeLog since V4:
>     - Add driver dependency on IMX_SCU to avoid compile error when IMX_SCU is NOT selected;
>     - Remove unnecessary of different errors handle for imx_scu_get_handle, already included in API.
> ---
>  drivers/thermal/Kconfig          |  11 +++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/imx_sc_thermal.c | 200 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 drivers/thermal/imx_sc_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 0e69edc..8d4601d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -222,6 +222,17 @@ config IMX_THERMAL
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
> index 610344e..1b13f6a 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
>  obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
>  obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
>  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> +obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
>  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
>  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
>  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> new file mode 100644
> index 0000000..1030a31
> --- /dev/null
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP.
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
> +static int imx_sc_thermal_register_sensor(struct platform_device *pdev,
> +					  struct imx_sc_sensor *sensor)
> +{
> +	struct thermal_zone_device *tzd;
> +
> +	tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +						   sensor->resource_id,
> +						   sensor,
> +						   &imx_sc_thermal_ops);
> +	if (IS_ERR(tzd)) {
> +		dev_err(&pdev->dev, "failed to register sensor: %d\n",
> +			sensor->resource_id);
> +		return PTR_ERR(tzd);
> +	}
> +
> +	sensor->tzd = tzd;
> +
> +	return 0;
> +}
> +
> +static int imx_sc_thermal_get_sensor_id(struct device_node *sensor_np, u32 *id)
> +{
> +	struct of_phandle_args sensor_specs;
> +	int ret;
> +
> +	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> +			"#thermal-sensor-cells",
> +			0, &sensor_specs);
> +	if (ret)
> +		return ret;
> +
> +	if (sensor_specs.args_count >= 1) {
> +		*id = sensor_specs.args[0];
> +		WARN(sensor_specs.args_count > 1,
> +				"%pOFn: too many cells in sensor specifier %d\n",
> +				sensor_specs.np, sensor_specs.args_count);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +

So, there should be no need for doing a search of sensor ids. In fact,
if the amount of sensors or the type of sensors supported changes, i.e.
the sensor ids are do not match, you should have a different compatible, IMO.

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
> +		ret = imx_sc_thermal_get_sensor_id(sensor_np, &sensor->resource_id);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"failed to get valid sensor resource id: %d\n",
> +				ret);
> +			break;
> +		}
> +
> +		ret = imx_sc_thermal_register_sensor(pdev, sensor);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to register thermal sensor: %d\n",
> +				ret);
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
> +	{ .compatible = "fsl,imx8qxp-sc-thermal", },
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
