Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1CDC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:08:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3E320811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VxXCblzl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="es/DACIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3E320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A6XLWWLHc9iwjGnT4C1qnFVw2cjS4satC5xHA3IvuEY=; b=VxXCblzluJFGcTM4OSBgSVyf4
	z9QfbHJT8wRPzHq76xRuSjIi1XFVOMJ06RoYrYt4NsMVWUdmRJ/cvrFzwK6vLOx64RkhgRtkuA9Bw
	M9YVwBoAz73Z3K4D9bhO6hi5EJESNuSEaHYZe24IHkKsZ8MLNBk7Xd5C56XFVYm1ZQJloOyVg+HFo
	w9qfzv5yZLO2i6KBOXBxtSO0iKyPQAiFTr3oSdmI2LeFuW4ONIUCFyTpGpkZwoeT7vyxKrLL5lfaG
	ifeDnrGmNKduQIGrDErJ2XYy6HJ25XOpRAcjN6IVN0QIge/xjsxV/zbDWY2JuStYgx0jmIhGOo5di
	GX+90NIFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXhaE-0003Iw-Fl; Fri, 14 Dec 2018 07:08:26 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXhaB-0003Hp-CG
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 07:08:24 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1356d90000>; Thu, 13 Dec 2018 23:08:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 23:08:12 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 23:08:12 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 07:08:10 +0000
Subject: Re: [PATCH V2 06/21] clk: tegra: dfll: CVB calculation alignment with
 the regulator
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-7-josephl@nvidia.com>
 <ce41aec0-64a7-03ca-e6ce-80c0c58e5a7d@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <fce78385-f314-1cce-057d-97d8396be754@nvidia.com>
Date: Fri, 14 Dec 2018 15:08:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ce41aec0-64a7-03ca-e6ce-80c0c58e5a7d@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544771289; bh=+D84/SfILZdUzhXSJnRaqEq49gJT4tuXDbAsjNRMPE8=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=es/DACICJYhWx2r/PuTvWLb2RNK2K5LTjp55HsW+FoeQat1SqtLTj89hxzcG9q/Ur
 MHYUko0QTzvzzRxAEBkPsYpw1c9NkgEsUrLAH7cAJQ+X68c9ExyVEYkPlXmytciv87
 eIJ4f1DKZY8eNqEXT3P69rNNf133GQgjTAVHaHn6noWQnmeSdRQwROLTDGrOCEouID
 d/6c3L+kFf+nKqSbuWAPZ5scLjzCB8DmeBoyaXQx6Vl/vbdZhmciLMfR2GJb0ptvnd
 bkZduphp1beRZ7/SSUlw8WlLpG+qxHPMyNdDj6lyOvrdOyIygOl4yyIsk/N1ZshtHG
 tICpwyuTfGV0A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_230823_432164_55AEDA15 
X-CRM114-Status: GOOD (  19.24  )
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

On 12/13/18 7:18 PM, Jon Hunter wrote:
> 
> On 13/12/2018 09:34, Joseph Lo wrote:
>> The CVB table contains calibration data for the CPU DFLL based on
>> process characterization. The regulator step and offset parameters depend
>> on the regulator supplying vdd-cpu, not on the specific Tegra SKU.
>>
>> When using a PWM controlled regulator, the voltage step and offset are
>> determined by the regulator type in use. This is specified in DT. When
>> using an I2C controlled regulator, we can retrieve them from CPU regulator
>> Then pass this information to the CVB table calculation function.
>>
>> Based on the work done of "Peter De Schrijver <pdeschrijver@nvidia.com>"
>> and "Alex Frid <afrid@nvidia.com>".
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>> *V2:
>>   - use the updated DT binding string for parsing
>>   - update the mechanism for geting regulator data from DT (PWM mode) or
>>   regulator (I2C mode)
>> ---
>>   drivers/clk/tegra/clk-dfll.h               |  6 ++-
>>   drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 57 ++++++++++++++++++++--
>>   drivers/clk/tegra/cvb.c                    | 12 +++--
>>   drivers/clk/tegra/cvb.h                    |  6 +--
>>   4 files changed, 67 insertions(+), 14 deletions(-)
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
>> index 1a2cc113e5c8..189b5e20ee4e 100644
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
>>   		.speedo_scale = 100,
>>   		.voltage_scale = 1000,
>>   		.entries = {
>> @@ -105,11 +103,45 @@ static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
>>   	{ },
>>   };
>>   
>> +static void get_alignment_from_dt(struct device *dev,
>> +				  struct rail_alignment *align)
>> +{
>> +	align->step_uv = 0;
>> +	align->offset_uv = 0;
>> +
>> +	if (of_property_read_u32(dev->of_node,
>> +				 "nvidia,pwm-voltage-step-microvolts",
>> +				 &align->step_uv))
>> +		align->step_uv = 0;
> 
> Not sure why it is necessary to initialise this again on failure.

Indeed, it's not necessary. Will remove two lines above.

> 
>> +
>> +	if (of_property_read_u32(dev->of_node,
>> +				 "nvidia,pwm-min-microvolts",
>> +				 &align->offset_uv))
>> +		align->offset_uv = 0;
> 
> Same here.
> 
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
>> @@ -135,12 +167,27 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
>>   		return -ENODEV;
>>   	}
>>   
>> +	if (of_property_read_bool(pdev->dev.of_node, "nvidia,pwm-to-pmic")) {
>> +		get_alignment_from_dt(&pdev->dev, &align);
>> +	} else {
>> +		err = get_alignment_from_regulator(&pdev->dev, &align);
>> +		if (err == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
> 
> Why not return any error here? The print below maybe misleading.

Okay, that should be fine. Will fix. Thanks.

Joseph

> 
>> +	}
>> +
>> +	if (!align.step_uv) {
>> +		dev_err(&pdev->dev, "missing step uv\n");
>> +		return -EINVAL;
>> +	}
>> +
> 
> Cheers
> Jon
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
