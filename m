Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:50:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79FB2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cad9u1bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79FB2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d7RJs4uAcNjMf+Tt8ixIR08M+8Ee8LYSB7PLuJ/TSfs=; b=Cad9u1bJcTDi3WUQubPbUXFAa
	O5uflkDJLfGAU8mwC8JAC1TEftTJkcY+WzEt7jRSAddPWUnZLYuCnzO0zUophOLibESw0Zxi1IF+I
	wF1CpnBuBajyhlotkiZYDyVX41adVCpMWqwqpvh6CvEW4/XSozst7/2k80YeCadTXWqaeD6zHRLrC
	lUjQj1AWwzT1zqdmLlWMKl+Q/Rpcar/kdoub9tmIbYBUkbaYIlszJZUqdI5DPJGeVgpnHWFCcAG4/
	svrGtynXUc88FOQGEIdpmn3PKh8acPbsoacNu5UX/uAnoq+D6Mb8/PlBNcZRDtC8LMcLe4mRfsG7X
	iZno8puSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXRO6-0005tL-AJ; Thu, 13 Dec 2018 13:50:50 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXRO2-0005hO-Ts
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:50:48 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0CFA32627190E;
 Thu, 13 Dec 2018 21:50:29 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 21:50:22 +0800
Subject: Re: arm64 board boot pauses on linux-next (resend)
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon
 <will.deacon@arm.com>
References: <95b1b28c-da6d-fa1f-4b39-ed3c37c4bb9e@huawei.com>
 <8e1e38dd-70b0-a0ec-0687-581cc773b600@arm.com>
 <644bb3fa-20e5-9958-e3aa-67eb711289ce@huawei.com>
 <4f82e9c4-acfb-d36e-5a54-876fd0e22d69@arm.com>
 <eac9866b-3cb4-f7af-dc21-7f685bd3aa96@huawei.com>
 <20181213130210.GC31177@edgewater-inn.cambridge.arm.com>
 <CAKv+Gu8TTBws+wmXFc2GXjd0_eKDH2NP1Zh8XJL3yLzLFjT-4A@mail.gmail.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <b9efc948-ae6a-42e1-0d11-f720430a610e@huawei.com>
Date: Thu, 13 Dec 2018 13:50:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8TTBws+wmXFc2GXjd0_eKDH2NP1Zh8XJL3yLzLFjT-4A@mail.gmail.com>
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_055047_134730_CBA3A643 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: Robin Murphy <robin.murphy@arm.com>, Linuxarm <linuxarm@huawei.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/12/2018 13:12, Ard Biesheuvel wrote:
> On Thu, 13 Dec 2018 at 14:01, Will Deacon <will.deacon@arm.com> wrote:
>>
>> [+Ard]
>>
>> On Thu, Dec 13, 2018 at 11:27:09AM +0000, John Garry wrote:
>>> On 12/12/2018 19:16, Suzuki K Poulose wrote:
>>>> On 12/12/2018 06:07 PM, John Garry wrote:
>>>>> On 12/12/2018 17:17, Robin Murphy wrote:
>>>>>> On 12/12/2018 16:48, John Garry wrote:
>>>>>>> I am finding our arm64 D05 board particularly slow to boot from
>>>>>>> linux-next, specifically a 30+ second pause when setting up CPU
>>>>>>> features.
>>>>>>
>>>>>> That does look like it's almost certainly spending the mystery time in
>>>>>> setup_cpu_features() itself.
>>>>>
>>>>> Seems to be "Kernel page table isolation (KPTI)" feature which we hang
>>>>> on, but I would not say that's conclusive.
>>>>>
>>>>
>>>> I think I have an idea what could be happening. The cpu_enable()
>>>> for KPTI, waits for all the secondary CPUs to enter a busy loop,
>>>> before installing the non-global mapping. So, with the changes in
>>>> -next, we batch the cpu_enabl() callbacks, which implies, the seconary
>>>> CPUs end up in the "cpu_enable()" for KPTI at different times.
>>>>
>>>> Could you check if the following hack makes it any better ?
>>>>
>>>
>>> Unfortunately it does not help:
>>> [    5.502243] CPU63: Booted secondary processor 0x0000070303 [0x410fd082]
>>> [    5.502329] smp: Brought up 4 nodes, 64 CPUs
>>> [    7.442722] SMP: Total of 64 processors activated.
>>> [    7.447567] CPU features: detected: GIC system register CPU interface
>>> [    7.454098] CPU features: detected: 32-bit EL0 Support
>>> [    7.459291] CPU features: detected: CRC32 instructions
>>> [   40.236781] CPU: All CPU(s) started at EL2
>>> [   40.241062] alternatives: patching kernel code
>>> [   40.263213] devtmpfs: initialized
>>> [   40.267140] clocksource: jiffies: mask: 0xffffffff max_cycles:
>>> 0xffffffff, max_idle_ns: 7645041785100000 ns
>>> [   40.277147] futex hash table entries: 16384 (order: 8, 1048576 bytes)
>>> [   40.284424] pinctrl core: initialized pinctrl subsystem
>>> [   40.290081] SMBIOS 3.0.0 present.
>>>
>>> BTW, If you guys know the reason for this delay and it is not going to be an
>>> issue, then that's fine. I just wanted to raise awareness.
>>
>> I think I've managed to reproduce the issue locally and it appears to be
>> because of the default rodata=full changes. One impact of the change is
>> that the linear map is now mapped at page granularity, so the kpti work
>> to convert everything to non-global takes considerably longer.
>>
>
> Hmm. At least we can easily check if this causes the reporter's issue
> as well, by passing 'rodata=on' on the kernel command line

That fixed it.

John

>
>> Given that most machines are not affected by meltdown, I think we should
>> probably look at expanding the whitelist we have, rather than pile more
>> complexity into the early page table code.
>>
>
> Disabling KPTI also makes KASLR easily defeatable.
>
> .
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
