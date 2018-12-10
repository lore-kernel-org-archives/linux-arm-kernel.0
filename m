Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D017C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:49:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEEA20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Es4pM/Bd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C8S23qU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEEA20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NvYYhUtxSazUoJDPuDjx2De6iRH2Xvh7nXwdATSRr54=; b=Es4pM/Bdc/9cIMRaQ3NHuoOl/
	JEcYBdtcsJEoFcYdlqp5jSTL+6ZhnBSIClEq0PmJOE/4BYbiT1+lFNc9btttCioVAtGBiHhEhp0vT
	i/pCNnUPSgjq35PxkBSPbuCW6yM3IF8R7vFq3cu96xhaAmLsruPGeLcICAbsoYvA6d5RmH0tMIFxz
	jf3q9Na3Lbrq1vshEI+VwN0UcVgxlN3VPJy+bkIjIEZFUqC0zu4Zs007TjChDDJGhAlPNrhc86/h6
	OdY1rT5ARmSHPmgHOUozNS/s6H8cnt8S4asfXOwIYhc7uwe+Ze7Y3cC+gyzCawuBv+8ty11S0Pf77
	lc5FahB1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHGF-0005PD-AU; Mon, 10 Dec 2018 08:49:55 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHGB-0005OL-Qs
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:49:53 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0e28a00000>; Mon, 10 Dec 2018 00:49:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 10 Dec 2018 00:49:38 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 10 Dec 2018 00:49:38 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 10 Dec
 2018 08:49:36 +0000
Subject: Re: [PATCH 01/19] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-2-josephl@nvidia.com>
 <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <46b5eafa-00a0-1d91-1f4d-97ab119fcf21@nvidia.com>
Date: Mon, 10 Dec 2018 16:49:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544431776; bh=/8es+HqIGumkG4qa5ZQx6dp7cZ/iDs5ea8Yz0Ds/OyY=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=C8S23qU2WkmtVSbQohBS/bgTh56uzBbm6TgptIyVMMTTtZpOtF1NRCAW7faojhQKB
 lhRxZtYFo0c1B5ZaNgZXNa/HqE47Jjq2GALYbg0uJ39kHaGsJRYwd9EI1UeM7rmwTN
 xHJhRf5yS7yfAGfOeDtOe048pJVCY2zT8XcqL1mPXtwdgvO7eWBYotmfkfwOfFEprW
 zL8hMaGaejPgj/6Mdkw+MUmIiUV4MxQmE0E5LwXmaYFSTf6ZviizqGqVzTMpGON2Z1
 hRopSxQ+aoTNp1jbL6f+nsOURmnYQNM9opMYNINv8TxsO43HeTnJtTUoOJd0N/SOKP
 37HmNrRrtPI8w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_004951_886051_73D6A53C 
X-CRM114-Status: GOOD (  20.99  )
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
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jon,

Thanks for reviewing this series.

On 12/7/18 9:41 PM, Jon Hunter wrote:
> 
> On 04/12/2018 09:25, Joseph Lo wrote:
>> From: Peter De Schrijver <pdeschrijver@nvidia.com>
>>
>> Add new properties to configure the DFLL PWM regulator support. Also
>> add an example and make the I2C clock only required when I2C support is
>> used.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   .../bindings/clock/nvidia,tegra124-dfll.txt   | 73 ++++++++++++++++++-
>>   1 file changed, 71 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>> index dff236f524a7..8c97600d2bad 100644
>> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>> @@ -8,7 +8,6 @@ the fast CPU cluster. It consists of a free-running voltage controlled
>>   oscillator connected to the CPU voltage rail (VDD_CPU), and a closed loop
>>   control module that will automatically adjust the VDD_CPU voltage by
>>   communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
>> -Currently only the I2C mode is supported by these bindings.
>>   
>>   Required properties:
>>   - compatible : should be "nvidia,tegra124-dfll"
>> @@ -45,10 +44,28 @@ Required properties for the control loop parameters:
>>   Optional properties for the control loop parameters:
>>   - nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in the TRM.
>>   
>> +Optional properties for mode selection:
>> +- nvidia,pwm-to-pmic: Use PWM to control regulator rather then I2C.
>> +
>>   Required properties for I2C mode:
>>   - nvidia,i2c-fs-rate: I2C transfer rate, if using full speed mode.
>>   
>> -Example:
>> +Required properties for PWM mode:
>> +- nvidia,pwm-period: period of PWM square wave in microseconds.
>> +- nvidia,init-uv: Regulator voltage in micro volts when PWM control is disabled.
> 
> Maybe consider 'pwm-inactive-voltage-microvolt'.
Ah, I think I need to refine the description here. It should be 
something like below.
  - nvidia,pwm-init-microvolt : Regulator voltage in micro volts when 
PWM control is initialized

This is the initial voltage that when we just initialize the DFLL 
hardware for PWM output. And before we switch the CPU clock from PLLX to 
DFLL, we will enable DFLL hardware in closed loop mode which will aplly 
the DVFS table that was calculated from CVB table.

The original description maybe make you think that it's the working 
voltage when it's under open-loop mode. But it's not. Sorry.

When we working on open-loop mode which will switch to low voltage range 
which also follows the DVFS table. Not this one.

> 
>> +- nvidia,align-offset-uv: Regulator voltage in micro volts when PWM control is
>> +			  enabled and PWM output is low.
> 
> Would this be considered the minimum pwm active voltage?
This would be used for minimum voltage for LUT table, which is the table 
that PMIC can output. The real minimum voltage in PWM mode still depends 
on the CVB table.

So maybe change this one to 'nvidia,pwm-offset-uv'.

> 
>> +- nvidia,align-step-uv: Voltage increase in micro volts corresponding to a
>> +			1/33th increase in duty cycle. Eg the voltage for 2/33th
>> +			duty cycle would be:
> 
> Maybe consider 'pwm-voltage-step-microvolt'.
Okay.

> 
>> +			nvidia,align-offset-uv + nvidia,align-step-uv * 2.
>> +- pinctrl-0: I/O pad configuration when PWM control is enabled.
>> +- pinctrl-1: I/O pad configuration when PWM control is disabled.
>> +- pinctrl-names: must include the following entries:
>> +  - dvfs_pwm_enable: I/O pad configuration when PWM control is enabled.
>> +  - dvfs_pwm_disable: I/O pad configuration when PWM control is disabled.
> 
> Please see Rob's feedback on the above [0].
Yes, I did refer that comments in this patch. And fixed that in 
description but missed for bindings ...

Thanks,
Joseph

> 
> Cheers
> Jon
> 
> [0] https://lore.kernel.org/patchwork/patch/885328/
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
