From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 18 Mar 2016 10:12:30 +0000
Subject: [RFC PATCH] arm64: Expose physical/virtual address bits through
 cpuinfo
In-Reply-To: <56EB966F.1030609@huawei.com>
References: <1458209283-44999-1-git-send-email-wangkefeng.wang@huawei.com>
 <56EA959C.8080005@arm.com> <56EB966F.1030609@huawei.com>
Message-ID: <56EBD48E.7090406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/16 05:47, Kefeng Wang wrote:
>
>
> On 2016/3/17 19:31, Suzuki K. Poulose wrote:
>> On 17/03/16 10:08, Kefeng Wang wrote:
>>> AArch64 support six types Physical Address range, permitted values
> [...]
>>> +static inline int id_aa64mmfr0_parange_bits(void)
>>
>> VA_BITS is an attribute of your running kernel and doesn't have anything to do with what
>> the CPU can support. (e.g, it is 48bit on 8.0, 8.1, but could go upto 52 in 8.2)
>
> After check the new id register id_aa64mmfr2 in armv8.2, I think we can use the LVA(larger
> virtual address) bit of id_aa64mmfr2 to get virtual address bits supported by cpu, what's
> opinion?

Thats the only way to do it.

>
> BTW, is it allowed to post patch by me to add more field of id_aa64mmfr2,

Of course. Also, since we use read_system_reg(), the values (pa and va width) won't change
across the CPUs. Hence, you may avoid multiple extraction routines and reuse the
results for one iteration.

Cheers
Suzuki
