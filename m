From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Tue, 17 Jan 2017 20:02:30 +0800
Subject: [Question] A question about arm64 pte
In-Reply-To: <20170117114518.GF18923@e104818-lin.cambridge.arm.com>
References: <d284f510-f025-db84-f21e-a5b167d4bcd2@huawei.com>
 <20170116115606.GA6832@e104818-lin.cambridge.arm.com>
 <6b7a9bd2-37af-40cd-b723-9e648fbbc7c8@huawei.com>
 <20170116143601.GB6832@e104818-lin.cambridge.arm.com>
 <ecf2bd9f-9f96-0e6d-564d-93cff5bbf0cb@huawei.com>
 <20170117114518.GF18923@e104818-lin.cambridge.arm.com>
Message-ID: <c0bb0be5-c7fa-948b-62ed-122eb89562dc@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/1/17 19:45, Catalin Marinas wrote:
> On Tue, Jan 17, 2017 at 11:53:43AM +0800, Yisheng Xie wrote:
>> On 2017/1/16 22:36, Catalin Marinas wrote:
>>> On Mon, Jan 16, 2017 at 08:39:56PM +0800, Yisheng Xie wrote:
>>>> On 2017/1/16 19:56, Catalin Marinas wrote:
>>>>> On Mon, Jan 16, 2017 at 06:08:47PM +0800, Yisheng Xie wrote:
>>>>>
>>
>> Here is what I get when mmap a reserved memory region 0x39ef 0000~0x3a00 0000
>> use /dev/mem:
>> [  442.704228] pgd = ffff802785f14000
>> [  442.707641] [ffff86e4b000] *pgd=000000279080c003, *pud=0000002785f01003, *pmd=0000002783f5b003, *pte=0168000039ef0fd3
> 
> The pte seems to have bit 7 set: PTE_RDONLY. So you would get a fault on
> write (but not read). Since PTE_WRITE is also set, handle_pte_fault()
> will mark the entry as dirty (bit 55, cleared above) and clear
> PTE_RDONLY before restarting the access instruction. User space wouldn't
> notice, just a slight delay on the first access.
> 
Hi Catalin,
Really thank you for kindly explain, quite clear now.

Thanks
Yisheng Xie.
