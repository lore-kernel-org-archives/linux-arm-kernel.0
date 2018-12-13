Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022D4C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:16:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11AE20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jdDsN3+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11AE20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q87IN7v3QWPH7oZ8EkQcPAHa4bwwequuErxsfYYM2nk=; b=jdDsN3+WYcuEGsGktTudDmIBq
	oFEHaB3oZkdi5eVQiXg+A82iNGhxAD9ZkyhAoDw+cXzjjcmLn/ES6fBqVvya4dH065G40Hy7stNri
	/RcafhnUuy5zmcdAWC4kUsfZ5Zkk3Z2iB8ajnfkt7gDUsHsVoRdIHFIinjENyPxeQS+vZyncHXh6n
	naJhIQbXZU2AfDRvafAdy5cejPJJxVJ6dcsV++BKlGXufleVNkp9GkNR3u71yI1N60Rh4QqIkv2i/
	XVRC0GgNYq6tXSME2HUAEtqruSFY7nWmsClFqhM0CGd5u/HyF49tlDZ/+y5bcNAVFrY3mAtXCC1qB
	JUb1VVDtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQqQ-0004Ci-Le; Thu, 13 Dec 2018 13:16:02 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQqM-0004By-31
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:16:00 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id BBCD8A1BB0612;
 Thu, 13 Dec 2018 21:15:44 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 21:15:38 +0800
Subject: Re: arm64 board boot pauses on linux-next (resend)
To: Will Deacon <will.deacon@arm.com>
References: <95b1b28c-da6d-fa1f-4b39-ed3c37c4bb9e@huawei.com>
 <8e1e38dd-70b0-a0ec-0687-581cc773b600@arm.com>
 <644bb3fa-20e5-9958-e3aa-67eb711289ce@huawei.com>
 <4f82e9c4-acfb-d36e-5a54-876fd0e22d69@arm.com>
 <eac9866b-3cb4-f7af-dc21-7f685bd3aa96@huawei.com>
 <20181213130210.GC31177@edgewater-inn.cambridge.arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <308ee07d-5734-b62e-fb8a-d754257bc7c7@huawei.com>
Date: Thu, 13 Dec 2018 13:15:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181213130210.GC31177@edgewater-inn.cambridge.arm.com>
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_051558_306886_48BE8F14 
X-CRM114-Status: GOOD (  17.19  )
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
Cc: ard.biesheuvel@linaro.org, Robin Murphy <robin.murphy@arm.com>,
 Linuxarm <linuxarm@huawei.com>, linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/12/2018 13:02, Will Deacon wrote:
> [+Ard]
>
> On Thu, Dec 13, 2018 at 11:27:09AM +0000, John Garry wrote:
>> On 12/12/2018 19:16, Suzuki K Poulose wrote:
>>> On 12/12/2018 06:07 PM, John Garry wrote:
>>>> On 12/12/2018 17:17, Robin Murphy wrote:
>>>>> On 12/12/2018 16:48, John Garry wrote:
>>>>>> I am finding our arm64 D05 board particularly slow to boot from
>>>>>> linux-next, specifically a 30+ second pause when setting up CPU
>>>>>> features.
>>>>>
>>>>> That does look like it's almost certainly spending the mystery time in
>>>>> setup_cpu_features() itself.
>>>>
>>>> Seems to be "Kernel page table isolation (KPTI)" feature which we hang
>>>> on, but I would not say that's conclusive.
>>>>
>>>
>>> I think I have an idea what could be happening. The cpu_enable()
>>> for KPTI, waits for all the secondary CPUs to enter a busy loop,
>>> before installing the non-global mapping. So, with the changes in
>>> -next, we batch the cpu_enabl() callbacks, which implies, the seconary
>>> CPUs end up in the "cpu_enable()" for KPTI at different times.
>>>
>>> Could you check if the following hack makes it any better ?
>>>
>>
>> Unfortunately it does not help:
>> [    5.502243] CPU63: Booted secondary processor 0x0000070303 [0x410fd082]
>> [    5.502329] smp: Brought up 4 nodes, 64 CPUs
>> [    7.442722] SMP: Total of 64 processors activated.
>> [    7.447567] CPU features: detected: GIC system register CPU interface
>> [    7.454098] CPU features: detected: 32-bit EL0 Support
>> [    7.459291] CPU features: detected: CRC32 instructions
>> [   40.236781] CPU: All CPU(s) started at EL2
>> [   40.241062] alternatives: patching kernel code
>> [   40.263213] devtmpfs: initialized
>> [   40.267140] clocksource: jiffies: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 7645041785100000 ns
>> [   40.277147] futex hash table entries: 16384 (order: 8, 1048576 bytes)
>> [   40.284424] pinctrl core: initialized pinctrl subsystem
>> [   40.290081] SMBIOS 3.0.0 present.
>>
>> BTW, If you guys know the reason for this delay and it is not going to be an
>> issue, then that's fine. I just wanted to raise awareness.
>
> I think I've managed to reproduce the issue locally and it appears to be
> because of the default rodata=full changes. One impact of the change is
> that the linear map is now mapped at page granularity, so the kpti work
> to convert everything to non-global takes considerably longer.
>
> Given that most machines are not affected by meltdown, I think we should
> probably look at expanding the whitelist we have, rather than pile more
> complexity into the early page table code.

OK, good to know.

This was my bisect log:
git bisect start
# bad: [606f8e7b27bfe30376348f8bc09cba17626dc24c] arm64: capabilities: 
Use linear array for detection and verification
git bisect bad 606f8e7b27bfe30376348f8bc09cba17626dc24c
# good: [40e020c129cfc991e8ab4736d2665351ffd1468d] Linux 4.20-rc6
git bisect good 40e020c129cfc991e8ab4736d2665351ffd1468d
# good: [9ff01193a20d391e8dbce4403dd5ef87c7eaaca6] Linux 4.20-rc3
git bisect good 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6
# bad: [ad697a1aecac19ec351063b5d8e6fc9d4bca7ee5] linkage: add generic 
GLOBAL() macro
git bisect bad ad697a1aecac19ec351063b5d8e6fc9d4bca7ee5
# skip: [9eb1c92b47c73249465d388eaa394fe436a3b489] arm64: acpi: Prepare 
for longer MADTs
git bisect skip 9eb1c92b47c73249465d388eaa394fe436a3b489
# skip: [d8797b125711f23d83f5a71e908d34dfcd1fc3e9] arm64: Use a raw 
spinlock in __install_bp_hardening_cb()
git bisect skip d8797b125711f23d83f5a71e908d34dfcd1fc3e9
# bad: [c8ebf64eab743130fe404dc6679c2ff0cbc01615] arm64/module: use plt 
section indices for relocations
git bisect bad c8ebf64eab743130fe404dc6679c2ff0cbc01615
# good: [b34d2ef0c60e4d9c2bb8a4d72d4519c67363d390] arm64: mm: purge 
lazily unmapped vm regions before changing permissions
git bisect good b34d2ef0c60e4d9c2bb8a4d72d4519c67363d390
# bad: [c55191e96caa9d787e8f682c5e525b7f8172a3b4] arm64: mm: apply r/o 
permissions of VM areas to its linear alias as well
git bisect bad c55191e96caa9d787e8f682c5e525b7f8172a3b4
# first bad commit: [c55191e96caa9d787e8f682c5e525b7f8172a3b4] arm64: 
mm: apply r/o permissions of VM areas to its linear alias as well

It was inconclusive from testing and I was getting tried of rerunning, 
so sent the mail...

Cheers,
John

>
> Will
>
> .
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
