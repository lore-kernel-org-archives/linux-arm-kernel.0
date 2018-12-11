Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A11C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:24:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DC22081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ig+K/h9G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BgBucgbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DC22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VRhlgIWoWLF91nvK7oAjgIq1OdCxQ3W4jzc3MTTGItA=; b=Ig+K/h9GowYmzYweLhJfPWq0b
	CBIxXpgtE3d30aoikcodB2Q8Kmsz51rgHiGlYLhYxEfzBzs9195Hgb9usSbj4V/DvoHp72He03VvP
	0ipvktuN5OSYw2J8Nx1LXXQ0I6jHJiUiMPfp5EJJ21BGCW3zpCRpI0LXPET5/8qkNreV7DlQKCTcK
	LtYhruq/5yaeBALobx5flDnRVBNMPTL9f6b3WWGdBIYNiSkJLZsqpj3LlCBwJbC102bjfl/4PLFC/
	nIf6l/5N7kVrRoS5kW3PrcXqJ4hsYAMjS4tCwOYj34Q+kbFGWC2SMZSWQsZAHCdF9bsMK7wqaX3pR
	X/hS2Bb2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWbSn-0006PX-Ro; Tue, 11 Dec 2018 06:24:13 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWbSk-0006P2-HF
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 06:24:12 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0f57fd0000>; Mon, 10 Dec 2018 22:23:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 10 Dec 2018 22:24:00 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 10 Dec 2018 22:24:00 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Dec
 2018 06:23:58 +0000
Subject: Re: [PATCH 06/19] clk: tegra: dfll: CVB calculation alignment with
 the regulator
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-7-josephl@nvidia.com>
 <8496868e-8e11-708a-8233-fefee59a79cd@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <bfa8b71d-2736-9982-094e-956bb1dfee7a@nvidia.com>
Date: Tue, 11 Dec 2018 14:23:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8496868e-8e11-708a-8233-fefee59a79cd@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544509437; bh=8X8gigElB2NLVhZ1GCCPhFCRkAsPjK2MqEMoV4Wm5ew=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=BgBucgbAKly8PbJFzxY59SM5kWNC910TMhUPwf8BFo/Z/spRFjp9ufICtH9/Bu4bi
 BBKJgBGbauM6faRApc23G0RdSUm/p17g0Ho5ehQUJwdkiEb3a3DEpe/5ucJBxAOqdd
 5uDW7i0sQGWddyzP+1vuS9BrHMcilAW2ATtoFlaR257SFCEuWNj42lySEjaTZ1aKpx
 oE98kDSC7uatArxYIirbA6QBAoaSo6o/fTJOIbi39H/UhDA12/RQQEjsGRpa3IYGrY
 fdJ6mXU4FN5D6/3Jui7AqMGppUEN6ht6aT9CpEReM3Y1xn+Tmh+tS1qbzOveF5LIRE
 nZAEJMkYp6B9w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_222410_587187_D415018D 
X-CRM114-Status: GOOD (  20.48  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/18 10:10 PM, Jon Hunter wrote:
> 
> On 04/12/2018 09:25, Joseph Lo wrote:
>> The CVB table contains calibration data for the CPU DFLL based on
>> process charaterization. The regulator step and offset parameters depend
>> on the regulator supplying vdd-cpu , not on the specific Tegra SKU.
>>
>> When using a PWM controlled regulator, the voltage step and offset are
>> determined by the regulator type in use. This is specified in DT. When
>> using an I2C controlled regulator, we can retrieve them from CPU regulator
>> or DT (if specified). Then pass this information to the CVB table
>> calculation function.
>>
>> Based on the work done of "Peter De Schrijver <pdeschrijver@nvidia.com>"
>> and "Alex Frid <afrid@nvidia.com>".
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   drivers/clk/tegra/clk-dfll.h               |  6 +-
>>   drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 65 ++++++++++++++++++++--
>>   drivers/clk/tegra/cvb.c                    | 12 ++--
>>   drivers/clk/tegra/cvb.h                    |  6 +-
>>   4 files changed, 75 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h
>> index 83352c8078f2..ecc43cb9b6f1 100644
>> --- a/drivers/clk/tegra/clk-dfll.h
>> +++ b/drivers/clk/tegra/clk-dfll.h
>> @@ -1,6 +1,6 @@
>>   /*
>>    * clk-dfll.h - prototypes and macros for the Tegra DFLL clocksource driver
>> - * Copyright (C) 2013 NVIDIA Corporation.  All rights reserved.
>> + * Copyright (C) 2013-2018 NVIDIA Corporation.  All rights reserved.
>>    *
>>    * Aleksandr Frid <afrid@nvidia.com>
>>    * Paul Walmsley <pwalmsley@nvidia.com>
>> @@ -22,11 +22,14 @@
>>   #include <linux/reset.h>
>>   #include <linux/types.h>
>>   
>> +#include "cvb.h"
>> +
>>   /**
>>    * struct tegra_dfll_soc_data - SoC-specific hooks/integration for the DFLL driver
>>    * @dev: struct device * that holds the OPP table for the DFLL
>>    * @max_freq: maximum frequency supported on this SoC
>>    * @cvb: CPU frequency table for this SoC
>> + * @alignment: parameters of the regulator step and offset
>>    * @init_clock_trimmers: callback to initialize clock trimmers
>>    * @set_clock_trimmers_high: callback to tune clock trimmers for high voltage
>>    * @set_clock_trimmers_low: callback to tune clock trimmers for low voltage
>> @@ -35,6 +38,7 @@ struct tegra_dfll_soc_data {
>>   	struct device *dev;
>>   	unsigned long max_freq;
>>   	const struct cvb_table *cvb;
>> +	struct rail_alignment alignment;
>>   
>>   	void (*init_clock_trimmers)(void);
>>   	void (*set_clock_trimmers_high)(void);
>> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
>> index 1a2cc113e5c8..071a5c674832 100644
>> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
>> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/init.h>
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>>   #include <soc/tegra/fuse.h>
>>   
>>   #include "clk.h"
>> @@ -50,9 +51,6 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
>>   		.process_id = -1,
>>   		.min_millivolts = 900,
>>   		.max_millivolts = 1260,
>> -		.alignment = {
>> -			.step_uv = 10000, /* 10mV */
>> -		},
> 
> What happens for tegra124-jetson-tk1 when we remove this?
Same as what we what to do with this patch. This data will be queried 
from regulator or DT. Because Jetson TK1 works on DFLL-I2C with the 
I2C-based regulator, it will be queried from the regulator.

> 
>>   		.speedo_scale = 100,
>>   		.voltage_scale = 1000,
>>   		.entries = {
>> @@ -105,11 +103,43 @@ static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
>>   	{ },
>>   };
>>   
>> +static void get_alignment_from_dt(struct device *dev,
>> +				  struct rail_alignment *align)
>> +{
>> +	align->step_uv = 0;
>> +	align->offset_uv = 0;
>> +
>> +	if (of_property_read_u32(dev->of_node, "nvidia,align-step-uv",
>> +				  &align->step_uv))
>> +		align->step_uv = 0;
>> +
>> +	if (of_property_read_u32(dev->of_node,
>> +				"nvidia,align-offset-uv", &align->offset_uv))
>> +		align->offset_uv = 0;
>> +}
>> +
>> +static int get_alignment_from_regulator(struct device *dev,
>> +					 struct rail_alignment *align)
>> +{
>> +	struct regulator *reg = devm_regulator_get(dev, "vdd-cpu");
>> +
>> +	if (IS_ERR(reg))
>> +		return PTR_ERR(reg);
>> +
>> +	align->offset_uv = regulator_list_voltage(reg, 0);
>> +	align->step_uv = regulator_get_linear_step(reg);
>> +
>> +	devm_regulator_put(reg);
>> +
>> +	return 0;
>> +}
>> +
>>   static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
>>   {
>>   	int process_id, speedo_id, speedo_value, err;
>>   	struct tegra_dfll_soc_data *soc;
>>   	const struct dfll_fcpu_data *fcpu_data;
>> +	struct rail_alignment align;
>>   
>>   	fcpu_data = of_device_get_match_data(&pdev->dev);
>>   	if (!fcpu_data)
>> @@ -135,12 +165,37 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
>>   		return -ENODEV;
>>   	}
>>   
>> +	get_alignment_from_dt(&pdev->dev, &align);
>> +	if (of_property_read_bool(pdev->dev.of_node, "nvidia,pwm-to-pmic")
>> +		 && (!align.step_uv || !align.offset_uv)) {
>> +		dev_info(&pdev->dev, "Missing required align data in DT");
>> +		return -EINVAL;
>> +	} else {
> 
> This 'else' clause is not necessary.
> 
>> +		if (!align.step_uv) {
>> +			dev_info(&pdev->dev,
>> +				 "no align data in DT, try from vdd-cpu\n");
>> +			err = get_alignment_from_regulator(&pdev->dev, &align);
> 
> dev_warn
> 
>> +			if (err == -EPROBE_DEFER) {
>> +				dev_info(&pdev->dev,
>> +					 "defer probe to get vdd-cpu\n");
> 
> This dev_info is not necessary.
> 
Will fix these comments above, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
