Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE3DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:21:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6E92184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HAdbtuz/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZEA+UkoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6E92184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IxKsequMDWsacZkAG5fm1OeQMa3YS0C1NOjPMW/9oxs=; b=HAdbtuz/Jt2NCw9+5pXtP6xUG
	kxbFUOnSQ0UN1qpuScihLLrAXW2RCPUG4HmBvUmJr2jC/PngBukk0SZIkewNHL2Kp6wdh/nv8xi4i
	sJvjXEyRcqXCI9OcyhUbP6kHv/cAR2YCYUEDj3eNtc8hj/zMBTMra7bHZPc4kpQvRKJLvxMQTuNXg
	/YGzUOsUx0or3zjmeM+NlG7Q+QzF5yObyy0QMMTLOrwD4zMUQm0NmuoeOMscQ20wH3aPQ4woQWpHJ
	BElv5n94Xa6Q/9OfMsvNya/33pyHbY4oX+pmFKnvcW5YofTD0yxyJ9fWtzgLwRMRi91aTSPaE2MXU
	wzReMXZbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvf79-0004cr-1p; Mon, 18 Feb 2019 09:21:27 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvf76-0004cX-Cx
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:21:25 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c6a791a0000>; Mon, 18 Feb 2019 01:21:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 18 Feb 2019 01:21:23 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 18 Feb 2019 01:21:23 -0800
Received: from DRHQMAIL101.nvidia.com (10.27.9.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 09:21:23 +0000
Received: from [10.19.108.132] (10.124.1.5) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 09:21:21 +0000
Subject: Re: [PATCH V6 5/7] arm64: dts: tegra210: add CPU idle states
 properties
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
References: <20190201161654.18315-1-josephl@nvidia.com>
 <20190201161654.18315-6-josephl@nvidia.com>
 <d98266b3-f0a4-cebe-174a-2ab5c4051fde@linaro.org>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <b6f7b1d2-5d7e-dbb2-9b43-f9bd727442d3@nvidia.com>
Date: Mon, 18 Feb 2019 17:21:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d98266b3-f0a4-cebe-174a-2ab5c4051fde@linaro.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL101.nvidia.com (10.27.9.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1550481690; bh=ENS4HhqjAUg8pvS47aAvOALLqBo8dmuR1+IPPOVUF3Q=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ZEA+UkoUB4rDtsDXqnIuQ7+TmNSp7ZFJ4m7wg/9Fk02rv80RJI/2PmeX1WBEq7U+1
 YA2bRtiJq9uWBO+oiSQY5iE6AjEWLt+NjWnNVOIFTfVMPNaPw5r79irtfowTBkvrkD
 +4JfeHEp6oQO6ozDTJCmyrTEBkAka98uC2/bLUwM9oA5fx+wl9hpljrvHLBsgbBf9X
 SRPRQdyn3qOhlVH1B8MJzS3Zg6Z+kAF8nDBp0VwcAPUG7UVXwRjNq5TzeDC28lNIF9
 NZEAMiJzTcLWR8ZmvTMWUswwX950r3gvEqw0stgIcZ1j4hij75WvjS61apOoKt9zNH
 90XIdgBaYUjMQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_012124_450435_DCF2D9EF 
X-CRM114-Status: GOOD (  15.76  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/15/19 11:47 PM, Daniel Lezcano wrote:
> On 01/02/2019 17:16, Joseph Lo wrote:
>> Add idle states properties for generic ARM CPU idle driver. This
>> includes a C7 state which is the power down state of CPU cores.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>> v6:
>>   * add ack tag from Jon.
>> v5:
>>   * no change
>> v4:
>>   * no change
>> v3:
>>   * no change
>> v2:
>>   * add entry-latency-us and exit-latency-us properties
>>
>> Note:
>> This dt patch depends on the DT changes in below series.
>> http://patchwork.ozlabs.org/project/linux-tegra/list/?series=84380
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> index 2b387364afc3..75534692604c 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> @@ -1318,24 +1318,43 @@
>>   				 <&dfll>;
>>   			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
>>   			clock-latency = <300000>;
>> +			cpu-idle-states = <&C7>;
> 
> Please change the C7 name, that will be confusing with the C-state.
> 
> CPU_SLEEP would be nice and consistent with other drivers.
> 
>>   		};
>>   
>>   		cpu@1 {
>>   			device_type = "cpu";
>>   			compatible = "arm,cortex-a57";
>>   			reg = <1>;
>> +			cpu-idle-states = <&C7>;
>>   		};
>>   
>>   		cpu@2 {
>>   			device_type = "cpu";
>>   			compatible = "arm,cortex-a57";
>>   			reg = <2>;
>> +			cpu-idle-states = <&C7>;
>>   		};
>>   
>>   		cpu@3 {
>>   			device_type = "cpu";
>>   			compatible = "arm,cortex-a57";
>>   			reg = <3>;
>> +			cpu-idle-states = <&C7>;
>> +		};
>> +
>> +		idle-states {
>> +			entry-method = "psci";
>> +
>> +			C7: c7 {
>> +				compatible = "arm,idle-state";
>> +				arm,psci-suspend-param = <0x40000007>;
>> +				entry-latency-us = <250>;
>> +				exit-latency-us = <100>;
>> +				min-residency-us = <1000>;
>> +				wakeup-latency-us = <130>;
> 
> Regarding the entry and the exit latency, the wakeup latency sounds a
> bit small.
> 
> ./devicetree/bindings/arm/idle-states.txt
> 
>> +				idle-state-name = "c7-cpu-powergated";
> 
> "cpu-sleep"
> 

Will fix them.

Thanks for reviewing,
Joseph

>> +				status = "disabled";
>> +			};
>>   		};
>>   	};
>>   
>>
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
