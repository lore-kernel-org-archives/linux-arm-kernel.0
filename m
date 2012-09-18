From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 18 Sep 2012 11:05:13 -0400
Subject: [PATCH 02/15] ARM: Add page table and page defines needed by KVM
In-Reply-To: <CAHkRjk6aOHDPcMZt==8mN9R-vJQ+RYvZ-LzimQ+no4yibJdGkQ@mail.gmail.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153443.21241.37958.stgit@ubuntu>
 <20120918124724.GK32204@mudshark.cambridge.arm.com>
 <CAHkRjk6aOHDPcMZt==8mN9R-vJQ+RYvZ-LzimQ+no4yibJdGkQ@mail.gmail.com>
Message-ID: <CANM98q+_R4raAXX4upOjFOqOOBaFz3nXYXr9E2+OUP1CzD-vcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 10:06 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On 18 September 2012 13:47, Will Deacon <will.deacon@arm.com> wrote:
>> On Sat, Sep 15, 2012 at 04:34:43PM +0100, Christoffer Dall wrote:
>>> +#define L_PTE2_SHARED                L_PTE_SHARED
>>> +#define L_PTE2_READ          (_AT(pteval_t, 1) << 6) /* HAP[0] */
>>> +#define L_PTE2_WRITE         (_AT(pteval_t, 1) << 7) /* HAP[1] */
>>
>> This is actually HAP[2:1], not HAP[1:0]. Also, can you follow what we do for
>> stage 1 translation and name these RDONLY and WRONLY (do you even use
>> that?).
>
> We can't use RDONLY as this would have value 0 as the HAP attributes
> (stage 2 overriding stage 1 translation attributes). Unless you add 4
> definitions like NOACCESS, RDONLY, WRONLY and RDWR to cover all the
> bit combinations.
>
>>> +#define L_PTE2_NORM_WB               (_AT(pteval_t, 3) << 4) /* MemAttr[3:2] */
>>> +#define L_PTE2_INNER_WB              (_AT(pteval_t, 3) << 2) /* MemAttr[1:0] */
>>
>> Another minor nit: PTE2 looks awful. Maybe L_PTE_HYP_* instead?
>
> L_PTE_HYP may be confused with the Stage 1 Hyp translation which is
> different from the guest Stage 2.

exactly, it's misleading, how about L_PTE_STAGE2, a little verbose,
but clear...?

>
> But I have another minor nit - just write them in the ascending bit
> order as other definitions in this file.
>

ok, will fix.

Thanks,
-Christoffer
