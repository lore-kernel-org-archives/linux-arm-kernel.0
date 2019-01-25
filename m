Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B26AC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:58:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689DE21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CbNsg3ZH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NQUK7z3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689DE21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vhFTz5I765fEUhfIQh+np8hsVRXNXC1QcTaZuQ9YiQw=; b=CbNsg3ZHVdTCtCctTMduv5B9k
	EFQkUq30RQ6EQzuKUWxV/3NryFjePdjHf7G5HuHo13Ez77+vDyPc3Iap4868pJWoQVsr46O+fFs5k
	7KBCNvJfrwTGBzXHXv8GLi0h5HLbaoh5Hii6PvVdgq44KLRfT6twMRCrkAJ6nDbV6ym1GrjyDnnGQ
	vdsuAv9o16lMhs13QWVCXvIje+PysJal8FUq2ybm23YO/MDSnEz+XJ5n8qU/AfAfjDbnNQjvjsBPG
	jugIwgnXJQZuJOVnd/dpraCv+HGx2IkDSCav9rjPbPewAPiop7ImL8gMoH3rnUD1JlyiUW85pIX1e
	vEJPWIvZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmsdH-0005QM-0C; Fri, 25 Jan 2019 03:58:19 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmsdD-0005Q0-Oa
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 03:58:17 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4a89300008>; Thu, 24 Jan 2019 19:57:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 24 Jan 2019 19:58:12 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 24 Jan 2019 19:58:12 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 03:58:11 +0000
Subject: Re: [PATCH 4/6] arm64: dts: tegra210: add CPU idle states properties
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-5-josephl@nvidia.com>
 <ef99309d-4c03-0c9e-16f0-055059a355d4@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <dc12f759-d324-c696-26bc-30fde9c3a0b7@nvidia.com>
Date: Fri, 25 Jan 2019 11:58:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ef99309d-4c03-0c9e-16f0-055059a355d4@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548388656; bh=+iZrH+LF0lA/vqs7FFiCUpIaEIuJLng6yJDlQv0sp00=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=NQUK7z3GJwG3mUx+cJE0DSTRq2z+eX+Vji885Y8cZLjrksdrHwVK0y7ArjA3RGFLb
 DdoSrIq7Lhn34WxMbbkBXwTxSM68JJnuUcVvJSIvKlxuumLp/ZZdUvPHv4AYiQH0ad
 NjZcs/uacNFHmyEcRccf4TBkBufbJjhROUqg+3ScfaTQ0hNBKHzlLEEF+Gu3csoO6n
 kwecT6/PlMb0MJ7BisNuVeDmHa1vNeO/hhTbKmrKgW5VUlY+DMbQ696vYwYHtnMWAp
 G8tCywXen1cjNbux/ASDZpfZPsIU1srHsLQjfexGB1SM0EG52NjRVruyP5jUHzAk/n
 qD/5BTi+7w+QQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_195815_810221_43FBFA4A 
X-CRM114-Status: GOOD (  12.64  )
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

On 1/24/19 7:21 PM, Jon Hunter wrote:
> 
> On 07/01/2019 03:28, Joseph Lo wrote:
>> Add idle states properties for generic ARM CPU idle driver. This
>> includes a C7 state which is the power down state of CPU cores.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>> Note:
>> This dt patch depends on the DT changes in below series.
>> http://patchwork.ozlabs.org/project/linux-tegra/list/?series=84380
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra210.dtsi | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> index 143bd103c923..b583d3065946 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> @@ -1308,24 +1308,41 @@
>>   				 <&dfll>;
>>   			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
>>   			clock-latency = <300000>;
>> +			cpu-idle-states = <&C7>;
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
>> +				wakeup-latency-us = <130>;
>> +				min-residency-us = <1000>;
>> +				idle-state-name = "c7-cpu-powergated";
>> +				status = "disabled";
>> +			};
>>   		};
>>   	};
> 
> The binding doc says that both 'entry-latency-us' and 'exit-latency-us'
> properties are required. Are we able to populate these?
> 

Indeed, will fix that.

Thanks,
Joseph


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
