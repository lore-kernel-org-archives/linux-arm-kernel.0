Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EE1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:05:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D9221841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NqLxrfX7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EYcH0TY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D9221841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IOENyr0gQOZxBPnnESVRUN45TCWGQwpBrVlxxIgr/4M=; b=NqLxrfX7y9eIcswihenqScsp3
	DDwk+ZSfW68YgAOU2dEBpjfcbQ0MDZ40tV+AIELMFRnvy7xPC39PB8lv+nDIYIjA/XH5670cgCrtn
	36LqGgXUSI+xJxVfW5+Yg9lLha+YlzNi1O6FLMWKYbaUOQO12xpqgzE0NKQ5mq1sOHV0PmCBZZMpZ
	LI9bXZlifYhbZTDdnxG3etdpM0h1Wg714H/8NSbvQ272VXXZg+uZHpBPsPntJX5q4jb8X0pF0O8o9
	WwxQ1k9b74ti+zS2DZd329FV/XJvhiNEQRBY0oLq/qRiJ0sCrpGFscpFPbfI4lajAaUgzZrZ8dW6A
	v+0Iy7vmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZVum-0008QH-HD; Wed, 19 Dec 2018 07:05:08 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZVui-0007Yb-5l
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 07:05:05 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c19ed8f0001>; Tue, 18 Dec 2018 23:04:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 23:04:53 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 23:04:53 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 07:04:51 +0000
Subject: Re: [PATCH V3 01/20] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
To: Rob Herring <robh@kernel.org>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-2-josephl@nvidia.com> <20181218151934.GA10127@bogus>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <4e0cc6a8-02cf-0590-ec5c-d11412168219@nvidia.com>
Date: Wed, 19 Dec 2018 15:04:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218151934.GA10127@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545203087; bh=cWoDzzVYbK7Bxzk9vTyXbNk9Kw09tJ2FboKToDJwv2Y=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=EYcH0TY0nqrEqFCI43aKPVB+juslqE7r9k+8Z5oJ6LhJKh+xcIfO+Erl2hBXF3ywS
 lnltS3q6/qFXl4+UXAik8WjHyd36jpVXjpiDcP6aN9xCxGRbHZ8LOZ1mf1BLuDxDo4
 ME63+VJGhzNcCXQJ8CCiYVEVAEqqHvOTrfk8BR4EY4htRr8yYKFbOEtTYxlCnuaBN3
 OxP/Ju5A9sXLSHcfd/SEkKyTVLZH/POo+eXKQHqBKGS3tN1uXq8tFq8UiSOCDzVEQp
 ARbEBj9X4LcnRKvvj0EkaWMTmf2OBUbVfmo5AqeND+FcmEwA789KcoI6HFeWJCbAbb
 KMAEcg/zOKKiw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_230504_253650_558A6706 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: devicetree@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/18/18 11:19 PM, Rob Herring wrote:
> On Tue, Dec 18, 2018 at 05:12:13PM +0800, Joseph Lo wrote:
>> From: Peter De Schrijver <pdeschrijver@nvidia.com>
>>
>> Add new properties to configure the DFLL PWM regulator support.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>> *V3:
>>   - no change
>> *V2:
>>   - update the binding strings and descriptions for
>>   nvidia,pwm-tristate-microvolts
>>   nvidia,pwm-min-microvolts
>>   nvidia,pwm-voltage-step-microvolts
>> ---
>>   .../bindings/clock/nvidia,tegra124-dfll.txt   | 79 ++++++++++++++++++-
>>   1 file changed, 77 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>> index dff236f524a7..38e8cc8c70a8 100644
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
>> @@ -45,10 +44,31 @@ Required properties for the control loop parameters:
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
> 
> Needs unit suffix.
> 

Hi Rob,

Thanks for reviewing these DT binding patches, will fix it.

Joseph

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
