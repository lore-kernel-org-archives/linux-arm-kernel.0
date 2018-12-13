Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DC6C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:34:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D0A20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TCwhS6pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D0A20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5KB/+m4g1QWYKVKYvex/EZN26khNCraBZVnGxh2S+T8=; b=TCwhS6plr1jzKs/lGIWwh/fGC
	x1OhFv6un82dASaPfbkMJQMLVjTwmgqx7JcAlDljK2j3WaVWMyFMej5lKppA9crOFWaj1ho7Luf6U
	43l8tQtIXy7k31celB8pXeYdAf3kx/lfBfx7eaRD6pFxGNsbagg8XX5tgUBam4mkN1ajMiGUIThVv
	P/h8p3r+44JLx3zcqqhnRxVki8KF0FnYUorzzdz5qUNMe/itghJEK0xztlRXkAs96GVfL6uLPtH/o
	GF6vzJmqKkGg13IfYMlNLXjbW1kAl86GQ7MJiqkt4PnWSoBvIdYb1YyLaLZy7HsiogeXba4sQ3jY2
	3zEvFSS+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPFg-00066H-AZ; Thu, 13 Dec 2018 11:34:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPFV-0005wf-Pr
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:33:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 049DDA78;
 Thu, 13 Dec 2018 03:33:39 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA7C13F575;
 Thu, 13 Dec 2018 03:33:36 -0800 (PST)
Subject: Re: arm64 board boot pauses on linux-next (resend)
To: John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <95b1b28c-da6d-fa1f-4b39-ed3c37c4bb9e@huawei.com>
 <8e1e38dd-70b0-a0ec-0687-581cc773b600@arm.com>
 <644bb3fa-20e5-9958-e3aa-67eb711289ce@huawei.com>
 <4f82e9c4-acfb-d36e-5a54-876fd0e22d69@arm.com>
 <eac9866b-3cb4-f7af-dc21-7f685bd3aa96@huawei.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f6888351-a573-ac16-bc90-e318d8e02f92@arm.com>
Date: Thu, 13 Dec 2018 11:33:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <eac9866b-3cb4-f7af-dc21-7f685bd3aa96@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_033349_845070_D593EEE7 
X-CRM114-Status: GOOD (  22.83  )
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
Cc: Linuxarm <linuxarm@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi John,

On 13/12/2018 11:27, John Garry wrote:
> On 12/12/2018 19:16, Suzuki K Poulose wrote:
>> Hi
>>
>> On 12/12/2018 06:07 PM, John Garry wrote:
>>> On 12/12/2018 17:17, Robin Murphy wrote:
>>>> [ +Suzuki ]
>>>>
>>>> Hi John,
>>>>
>>>
>>> Hi Robin,
>>>
>>>> On 12/12/2018 16:48, John Garry wrote:
>>>>> Hi all,
>>>>>
>>>>> I am finding our arm64 D05 board particularly slow to boot from
>>>>> linux-next, specifically a 30+ second pause when setting up CPU
>>>>> features.
>>>>
>>>> That does look like it's almost certainly spending the mystery time in
>>>> setup_cpu_features() itself.
>>>
>>> Seems to be "Kernel page table isolation (KPTI)" feature which we hang
>>> on, but I would not say that's conclusive.
>>>
>>
>> I think I have an idea what could be happening. The cpu_enable()
>> for KPTI, waits for all the secondary CPUs to enter a busy loop,
>> before installing the non-global mapping. So, with the changes in
>> -next, we batch the cpu_enabl() callbacks, which implies, the seconary
>> CPUs end up in the "cpu_enable()" for KPTI at different times.
>>
>> Could you check if the following hack makes it any better ?
>>
> 
> Hi,
> 
> Unfortunately it does not help:
> [    5.502243] CPU63: Booted secondary processor 0x0000070303 [0x410fd082]
> [    5.502329] smp: Brought up 4 nodes, 64 CPUs
> [    7.442722] SMP: Total of 64 processors activated.
> [    7.447567] CPU features: detected: GIC system register CPU interface
> [    7.454098] CPU features: detected: 32-bit EL0 Support
> [    7.459291] CPU features: detected: CRC32 instructions
> [   40.236781] CPU: All CPU(s) started at EL2

Thats strange.


> [   40.241062] alternatives: patching kernel code
> [   40.263213] devtmpfs: initialized
> [   40.267140] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 7645041785100000 ns
> [   40.277147] futex hash table entries: 16384 (order: 8, 1048576 bytes)
> [   40.284424] pinctrl core: initialized pinctrl subsystem
> [   40.290081] SMBIOS 3.0.0 present.
> 
> BTW, If you guys know the reason for this delay and it is not going to
> be an issue, then that's fine. I just wanted to raise awareness.
> 

It would be good to get to the bottom of it, given that it delays like 30+
seconds. Does reverting the following patch make any difference ?

"arm64: capabilities: Batch cpu_enable callbacks"

I will try to reproduce it locally, on a different platform though.

Cheers
Suzuki

> Cheers,
> John
> 
>> ---8>---
>>
>> hack: Reorder KPTI to the top
>>
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/cpucaps.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpucaps.h
>> b/arch/arm64/include/asm/cpucaps.h
>> index a89f587..1363e09 100644
>> --- a/arch/arm64/include/asm/cpucaps.h
>> +++ b/arch/arm64/include/asm/cpucaps.h
>> @@ -18,7 +18,7 @@
>>   #ifndef __ASM_CPUCAPS_H
>>   #define __ASM_CPUCAPS_H
>>
>> -#define ARM64_WORKAROUND_CLEAN_CACHE        0
>> +#define ARM64_UNMAP_KERNEL_AT_EL0        0
>>   #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE    1
>>   #define ARM64_WORKAROUND_845719            2
>>   #define ARM64_HAS_SYSREG_GIC_CPUIF        3
>> @@ -41,7 +41,7 @@
>>   #define ARM64_WORKAROUND_CAVIUM_30115        20
>>   #define ARM64_HAS_DCPOP                21
>>   #define ARM64_SVE                22
>> -#define ARM64_UNMAP_KERNEL_AT_EL0        23
>> +#define ARM64_WORKAROUND_CLEAN_CACHE        23
>>   #define ARM64_HARDEN_BRANCH_PREDICTOR        24
>>   #define ARM64_HAS_RAS_EXTN            25
>>   #define ARM64_WORKAROUND_843419            26
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
