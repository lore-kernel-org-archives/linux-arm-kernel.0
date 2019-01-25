Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED17C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:57:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA2621872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sxfFGREh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="J73g2hmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA2621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RHKiTbST8I6BmhOKbRo1SiL7Nlnj6skLSJ9Kl0B8KqQ=; b=sxfFGREhA3rEIWZyyZOOquTHW
	n8RDlYpdq+UXjBs519ATlhONqnPa/6jtlNf9dKwahnVUOChY8+fBMcA+8nApxa5oxKiwcsj0BN57u
	54AnzxHS1qu/1eIyPcl7YbsUKA8ntYlGrdXaaNl/7Yai8KsOjFDBjN1MXtENNOKBdvRncoP9Dp5yF
	ds2EcXc+HtJl2aGQrHuTOP7xIOpZtSHJoNq2qT/GW9q1iMkA5WxTjdRc63Mcsg6KTRzvMdIh7ISS5
	r8XDHhYAkXiVar7kUWwKRUQthcLHh05GhkCo8vWL8r7qzV+Kgp2R7rVwd3sjGfJm+RD1uwRntZPrV
	yJY4TNYZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmsbz-000578-1X; Fri, 25 Jan 2019 03:56:59 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmsbv-00056k-SC
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 03:56:57 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4a89070005>; Thu, 24 Jan 2019 19:56:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 24 Jan 2019 19:56:55 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 24 Jan 2019 19:56:55 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 03:56:54 +0000
Subject: Re: [PATCH 3/6] arm64: dts: tegra210: fix timer node
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-4-josephl@nvidia.com>
 <867b5168-e3cb-6423-b3d2-c075d1701c88@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <60b7e6b5-225b-b873-3aea-f81a2a658c9c@nvidia.com>
Date: Fri, 25 Jan 2019 11:56:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <867b5168-e3cb-6423-b3d2-c075d1701c88@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548388615; bh=u6xEaqIllTWZWwzmeuJG2pP0vnj6HylcW3Y1zSDRztM=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=J73g2hmVIkH4LIbpggnta3lK3WVfDIdhUMrndUBe7bsjvuPajMqbuQF/DFgYScVjn
 0meWTmOgo8WLBrjwuYNtto2tygnab1BLXGbxaR8B2rupBbiQHGFuHVN3e5CzKMAi21
 ZjgxTYQER6y/OX0hIP1Aj3fMbLPYkYxAEVihzSjEFSTYayiLo5hYfdV0HHECiA+kzA
 d8Xh0Hzzk7XtsDjW88vFh7S9y/EaKnYnxAogJ3lmAZ6B35uHrb6Ln0ccFg4aqlNR3D
 B3MvZqe+iMrL8QMmVS0JQHE+hB8zuts8sTmLALSJ92PayjjSt6qowLDRI4hxOahdzc
 Cv1SYSaFzGz6A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_195655_923551_0BA48F3D 
X-CRM114-Status: GOOD (  20.41  )
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

On 1/24/19 7:16 PM, Jon Hunter wrote:
> 
> On 07/01/2019 03:28, Joseph Lo wrote:
>> Fix timer node to make it work with Tegra210 timer driver. And backward
>> compatible with the Tegra watchdog driver.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra210.dtsi | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> index b5858b5ea052..143bd103c923 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> @@ -384,14 +384,12 @@
>>   	};
>>   
>>   	timer@60005000 {
>> -		compatible = "nvidia,tegra210-timer", "nvidia,tegra20-timer";
>> +		compatible = "nvidia,tegra210-timer", "nvidia,tegra30-timer";
>>   		reg = <0x0 0x60005000 0x0 0x400>;
>> -		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
>> -			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
>> -			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
>> -			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
>> -			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
>> -			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
>>   		clocks = <&tegra_car TEGRA210_CLK_TIMER>;
>>   		clock-names = "timer";
>>   	};
> 
> Hmmm ... I can't say I understand this. So now the timer devices are
> compatible with two different drivers?

The tegra210-timer is for clock event device and the tegra30-timer is 
for watchdog timer, that is the usage for Tegra platform before 
Tegra210. But... (see below)

> 
> Begs the question why did we not just extend the existing tegra20-timer
> rather than adding a new one?

The tegra20-timer was designed for very early stage that the arm-twd 
driver not ready yet. So it was the clock event device and sched timer 
for tegra20/30 at that stage. And I believe this driver was replaced and 
deprecated by arm-twd and armv7 timer for tegra20/30/114/124. So 
basically, I think we can remove this driver now.

So back to the question above, as we see the similar timer node binding 
in tegra20/30/114/124/132 dts file. It actually didn't use tegra20 timer 
driver at all but instead of arm-twd and armv7 timer. The binding only 
makes it work with the tegra-wdt driver, which is the compatible string 
of "nvidia,tegra30-timer". Maybe we should fix them all together.

> 
> Also you did not explain why we make them compatible with the watchdog
> driver? We have other watchdogs timer and so why do we need to make them
> compatible?
> 

The detail explanation is above. In here, I just follow the legacy 
binding convention that we used in other tegra dts files. This binding 
makes it work with TMR5, which is the watchdog timer that we used to use 
for Tegra.

If we don't prefer this way, I can remove that for now. And we need to 
find a different way to merge watchdog timer driver and timer driver 
into one driver.

Let me know which one is acceptable for now.

Thanks,
Joseph

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
