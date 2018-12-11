Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2103BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:37:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E335820672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OUyuIEZV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JtlxQ7J+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E335820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y989L0cZjgmqOZVlTtyezFRdEirGgpZQYXuJwFbwVws=; b=OUyuIEZVS2/cPGdd4wL0n/qkq
	7EExKNmIMCwR7xGsKIenA2qBtSsZZ4g5K84GajCTn1pzfpiuxF3/DTXnBxcxvlSBWpl4mT1bVe4fn
	QcxXP780buoYPuwJKSXzbw0vTLUCd/XSyGgO5EpMTRZqQNxrkTZZqAXXHMQZQhQR625PNWZvVy4Ua
	hM+ELgmlSRor0nbvuFc5zhLeGkyzz0N76CldOOt+tm/1Rzg0NlgZj1er7h+Y04tu4hCkXTA68+Qv7
	lHNYk8hmaLb5xu1OuDW0C1zG3Vui1w0H+XuklSX5Bp5BIHce4tVfXPMxPbQZQbiOR7ci/dZO9xU3O
	Vb///Fodw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWbfi-0002u1-Gf; Tue, 11 Dec 2018 06:37:34 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWbfd-0002tC-SJ
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 06:37:33 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0f5b1d0001>; Mon, 10 Dec 2018 22:37:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 10 Dec 2018 22:37:19 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 10 Dec 2018 22:37:19 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Dec
 2018 06:37:18 +0000
Subject: Re: [PATCH 07/19] clk: tegra: dfll: support PWM regulator control
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-8-josephl@nvidia.com>
 <3d0f52c6-770e-bae2-2396-87f32455b807@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <c92940a1-23a1-852e-72d5-7b8c7bcb948f@nvidia.com>
Date: Tue, 11 Dec 2018 14:37:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3d0f52c6-770e-bae2-2396-87f32455b807@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544510237; bh=kvVxqiPXAmX1CXgN96FYgaqT8E5pqr47GXEVLPCFyhQ=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=JtlxQ7J+lNbVaDb609o19mhXXxRISpIptQZjqGaJ1D3+6whH8FZ2F8dvYF2dXhaS8
 6e66M9fms+VRoZf1mjtkvbGpq26gnt/+xkMqe831VvvT8b7/N9D8PZFxj1bZZBCso+
 nkS0MCxZOaxStJY8gorHhVo5G/dhuSl0UYMARsQGLwmOMGbkd0vo9eVgE6ZtkFaTUp
 8L0UACxR+x7L15n/k6t+bkk1JjHrJNMU+yn7zuz8gkJc8PqOdQ2+ozarX155wOoh1h
 kYrUqDw7b647N5wNcod7dn4j164rvmdYtHIdbTuBfVJpa2MEFx109xV2iH4bCbul1y
 SEj/L2s2DdfUg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_223731_568646_9D07AEAA 
X-CRM114-Status: GOOD (  17.93  )
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

On 12/7/18 11:09 PM, Jon Hunter wrote:
> 
> On 04/12/2018 09:25, Joseph Lo wrote:
>> The DFLL hardware supports two modes (I2C and PWM) for voltage control
>> when requesting a frequency. In this patch, we introduce PWM mode support.
>>
>> To support that, we re-organize the LUT for unifying the table for both
>> cases of I2C and PWM mode. And generate that based on regulator info.
>> For the PWM-based regulator, we get this info from DT. And do the same as
>> the case of I2C LUT, which can help to map the PMIC voltage ID and voltages
>> that the regulator supported.
>>
>> The other parts are the support code for initializing the DFLL hardware
>> to support PWM mode. Also, the register debugfs file is slightly
>> reworked to only show the i2c registers when I2C mode is in use.
>>
>> Based on the work of Peter De Schrijver <pdeschrijver@nvidia.com>.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   drivers/clk/tegra/clk-dfll.c | 431 ++++++++++++++++++++++++++++++-----
>>   1 file changed, 368 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
>> index 609e363dabf8..c294a2989f31 100644
>> --- a/drivers/clk/tegra/clk-dfll.c
>> +++ b/drivers/clk/tegra/clk-dfll.c
>> @@ -1,7 +1,7 @@
>>   /*
>>    * clk-dfll.c - Tegra DFLL clock source common code
>>    *
>> - * Copyright (C) 2012-2014 NVIDIA Corporation. All rights reserved.
>> + * Copyright (C) 2012-2018 NVIDIA Corporation. All rights reserved.
>>    *
>>    * Aleksandr Frid <afrid@nvidia.com>
>>    * Paul Walmsley <pwalmsley@nvidia.com>
>> @@ -47,6 +47,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/pinctrl/consumer.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>> @@ -243,6 +244,12 @@ enum dfll_tune_range {
>>   	DFLL_TUNE_LOW = 1,
>>   };
>>   
>> +
>> +enum tegra_dfll_pmu_if {
>> +	TEGRA_DFLL_PMU_I2C = 0,
>> +	TEGRA_DFLL_PMU_PWM = 1,
>> +};
>> +
>>   /**
>>    * struct dfll_rate_req - target DFLL rate request data
>>    * @rate: target frequency, after the postscaling
>> @@ -294,16 +301,25 @@ struct tegra_dfll {
>>   	u32				ci;
>>   	u32				cg;
>>   	bool				cg_scale;
>> +	u32				reg_init_uV;
>>   
>>   	/* I2C interface parameters */
>>   	u32				i2c_fs_rate;
>>   	u32				i2c_reg;
>>   	u32				i2c_slave_addr;
>>   
>> -	/* i2c_lut array entries are regulator framework selectors */
>> -	unsigned			i2c_lut[MAX_DFLL_VOLTAGES];
>> -	int				i2c_lut_size;
>> -	u8				lut_min, lut_max, lut_safe;
>> +	/* lut array entries are regulator framework selectors or PWM values*/
>> +	unsigned			lut[MAX_DFLL_VOLTAGES];
>> +	unsigned			lut_uv[MAX_DFLL_VOLTAGES];
>> +	int				lut_size;
>> +	u8				lut_bottom, lut_min, lut_max, lut_safe;
>> +
>> +	/* PWM interface */
>> +	enum tegra_dfll_pmu_if		pmu_if;
>> +	unsigned long			pwm_rate;
>> +	struct pinctrl			*pwm_pin;
>> +	struct pinctrl_state		*pwm_enable_state;
>> +	struct pinctrl_state		*pwm_disable_state;
>>   };
>>   
>>   #define clk_hw_to_dfll(_hw) container_of(_hw, struct tegra_dfll, dfll_clk_hw)
>> @@ -489,6 +505,34 @@ static void dfll_set_mode(struct tegra_dfll *td,
>>   	dfll_wmb(td);
>>   }
>>   
>> +/*
>> + * DVCO rate control
>> + */
>> +
>> +static unsigned long get_dvco_rate_below(struct tegra_dfll *td, u8 out_min)
>> +{
>> +	struct dev_pm_opp *opp;
>> +	unsigned long rate, prev_rate;
>> +	int uv, min_uv;
>> +
>> +	min_uv = td->lut_uv[out_min];
>> +	for (rate = 0, prev_rate = 0; ; rate++) {
>> +		opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
>> +		if (IS_ERR(opp))
>> +			break;
>> +
>> +		uv = dev_pm_opp_get_voltage(opp);
> 
> Can you fix the type of 'uv' here? It should be unsigned long.

Okay, will fix it. Thanks.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
