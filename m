From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 19 Apr 2016 15:08:41 +0800
Subject: [PATCH v2 3/3] arm64: mm: Restrictive printing for modules and
 PCI I/O in memory layout
In-Reply-To: <5714C1CE.4090307@arm.com>
References: <1460533772-13314-1-git-send-email-wangkefeng.wang@huawei.com>
 <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
 <1460948988-7477-4-git-send-email-wangkefeng.wang@huawei.com>
 <5714C1CE.4090307@arm.com>
Message-ID: <5715D979.1040703@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/18 19:15, James Morse wrote:
> On 18/04/16 04:09, Kefeng Wang wrote:
>> The modules and PCI I/O informations in Virtual kernel memory layout
>> are inappropriate when corresponding config is not enabled, so don't
>> show them then.
> 
> I'm not sure about this, it looks like these areas are still reserved, so this
> is still useful debug information. mm/dump.c will still print any mappings in
> these ranges, its good to be consistent.

If the CONFIG is not enabled,  I think the areas will not be reserved and not mapped,
correct me if I am wrong. so it looks useless, but keeping them is ok for me.

BRs,
Kefeng

> 
> 
> Thanks,
> 
> James
> 
