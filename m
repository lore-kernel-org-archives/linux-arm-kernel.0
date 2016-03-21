From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 21 Mar 2016 19:58:42 +0800
Subject: [RFC PATCH] arm64: Expose physical/virtual address bits through
 cpuinfo
In-Reply-To: <20160318121325.GB4645@e104818-lin.cambridge.arm.com>
References: <1458209283-44999-1-git-send-email-wangkefeng.wang@huawei.com>
 <20160318121325.GB4645@e104818-lin.cambridge.arm.com>
Message-ID: <56EFE1F2.8080409@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/18 20:13, Catalin Marinas wrote:
> On Thu, Mar 17, 2016 at 06:08:03PM +0800, Kefeng Wang wrote:
>> AArch64 support six types Physical Address range, permitted values
>> in ID_AA64MMFR0_EL1 are:
>> 0000  32 bits, 4GB.
>> 0001  36 bits, 64GB.
>> 0010  40 bits, 1TB.
>> 0011  42 bits, 4TB.
>> 0100  44 bits, 16TB.
>> 0101  48 bits, 256TB.
>> All other values are reserved.
>>
>> Meanwhile, AArch64 allows 36-bit, 39-bit, 42-bit, 47-bit and 48-bit
>> virtual addresses.
>>
>> Exposing the physical and virtual address bits to userspace through
>> procfs like x86, then it is easy to check them from cpuinfo.
> 
> So, what does user space need such information for?

For now, no user app use this, it just shows the physical/virtual address size
that is supported by cpu.

AArch64 supports several different types of physical/virtual address bits(up to 52bit
in ARMv8.2 especially), I think it's better to expose it, and cpuinfo is proper space.
