Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8274DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:36:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548A920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mttkj65z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UKbDX5Gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548A920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ori1kLpZNPGDXd5CLaqJTmtwtb79l5OWRHjYUkIQQvk=; b=Mttkj65znXZW7bN5WVVc4sJNi
	CNeRpCw8lvuZ6efwxwWjH+9XVtwsrN3P0Mgg8Qh9LDlPbGRjpwXI1PiHzGFl/OikIgofSfKtfwWVC
	evtwnALQ16HgDm9BCPT8Mi5RUE0YJc1m5pHCDLay1P+3+rcLooUhcGrkXfxZGEi5I0pYRxtPUbu7h
	Cm1iEcYo67DTX49vLh/zIe/5R61gUm7PbWd90uU0/+XmexU10jR0ZzvJvfG26/9M1imPnLi9axpmy
	yaBZ0x40Doi+gECPWeFeSbLARlArAw6UF5uDJ62bnY/9doxA+wkvIhnrvXlUVWNAWsEEA+UeaUTn2
	2YvCSbFvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWbeu-0002cz-1b; Tue, 11 Dec 2018 06:36:44 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWbeq-0002cT-G7
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 06:36:41 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0f5aeb0000>; Mon, 10 Dec 2018 22:36:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 10 Dec 2018 22:36:29 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 10 Dec 2018 22:36:29 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Dec
 2018 06:36:28 +0000
Subject: Re: [PATCH 07/19] clk: tegra: dfll: support PWM regulator control
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-8-josephl@nvidia.com>
 <6cdab503-e463-ddbb-2ce9-035c81da7058@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <f737d9e2-2888-6255-2872-cfc9dc0a6aa1@nvidia.com>
Date: Tue, 11 Dec 2018 14:36:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6cdab503-e463-ddbb-2ce9-035c81da7058@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544510187; bh=MLOYi/41hjvgZB/WNx6gkLkG8vQw5cFd2knJ2erxad4=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=UKbDX5GgIEV1CVZzNowdG+SlgSFXVejwmPkF5tq9G90eefZtns/L/xjv6vUIrVUDC
 G6DX7Um+a3ASVOtILtrmLHa3inYPY+1/Hx/+3mcNTjmvFNGfVHLyqFB71fKCqRy5k2
 1WcXA3mGhZ3FEapU34CDplzCifCDjZY2u7id8oH+zXqGJAcn8c2ZnkOaSSZjslEILg
 YvxXI7oVMiB+sKy6aZH8QU4dyfvdzfd/3qpnjY8olGZMc/GN0PDiksbykkYzoFCv2W
 3OAr8HZZ79j+kcEJrBu5qPcxVq/R+6F6y6sw9PKZ6kolshvvM+EusmiEFaI6FSJIGa
 aO2zrZEQlfbsQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_223640_548008_32FFD005 
X-CRM114-Status: GOOD (  17.10  )
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

On 12/7/18 10:26 PM, Jon Hunter wrote:
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
> 
> Doesn't this belong under PWM interface? Also being picky I dont' find
> init_uV very descriptive.

Yes, will move that to PWM interface section. Thanks.

> 
> Otherwise the change looks fine to me.
> 
> Cheers
> Jon
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
