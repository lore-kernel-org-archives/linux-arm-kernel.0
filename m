From: Andrew.Pinski@caviumnetworks.com (Pinski, Andrew)
Date: Mon, 5 Oct 2015 21:00:33 +0000
Subject: [PATCH v5 00/23] ILP32 for ARM64
In-Reply-To: <20151005155857.GA5557@MBP.local>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
 <20151001191520.GA25295@yury-N73SV> <1708349.DFbfvHcnCR@wuerfel>
 <F6B719D8-1FC0-4B26-A926-40FB6953AAE3@caviumnetworks.com>
 <20151002093711.GA15803@localhost>
 <D23487FC.908DE%pkapoor@caviumnetworks.com>, <20151005155857.GA5557@MBP.local>
Message-ID: <8D6F4343-89AD-46A3-B7E7-15B8591CB020@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Oct 5, 2015, at 8:59 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
>> On Sat, Oct 03, 2015 at 02:18:57AM +0000, Kapoor, Prasun wrote:
>>> On 10/2/15, 2:37 AM, "Catalin Marinas" <catalin.marinas@arm.com> wrote:
>>> So, at the time, following x32 discussions, we thought of using the
>>> native ABI as much as possible. However, two important things happened
>>> since:
>>> 
>>> 1. libc community didn't like breaking the POSIX compliance
>>> 2. No-one seems desperate for ILP32 on AArch64
>>> 
>>> (1) is a fair point and I would rather be careful as we don't know the
>>> extent of the code affected. In the meantime, we've also had ongoing
>>> work for addressing the 2038 issue on 32-bit architectures.
>>> 
>>> The second point is equally important. The benchmarks I've seen didn't
>>> show a significant improvement and the messages I got on various
>>> channels pretty much labeled ILP32 as a transitional stage to full LP64.
>>> In this case, we need to balance the benefits of a close to native ABI
>>> (future proof, slightly higher performance) vs. the cost of maintaining
>>> such ABI in the kernel on the long term, especially if it's not widely
>>> used/tested.
>> 
>> For us ILP32  is not about putting this into our product flier at all, it
>> is about supporting real applications. We have an existing product line of
>> MIPS based SoCs where a large number of N32 (an exact equivalent of ILP32)
>> applications are currently in production. Our customers are looking to
>> bring those applications (mostly in Networking and Telecom space) over to
>> ARMv8. 
>> 
>> We think its an extremely risky strategy to say either future processors
>> should incur the additional cost (power and complexity) of implementing
>> Aarch32 instruction set or have no way of  supporting 32 bit applications
>> at all.
> 
> Well, given that Cavium posted only 3 versions of this series since
> September 2013, it doesn't seem critical at all.

We are going to post another version as soon as we finish the changes that you requested this time around. I am working on the glibc and yury (with my help) will doing the kernel side. 


> 
>> Apart from there being an installed base of 32 bit networking and telecom
>> applications, we have also seen non-trivial performance gains with ILP32
>> (for example, our SPECINT score goes up by 7% with ILP32 compared to
>> LP64).
> 
> It would be good to re-run the benchmarks with the latest gcc since
> LP64/AArch64 support has evolved in the meantime.

We are also rerunning the numbers with the latest released gcc (5.2) and will report results when we submit the next version of the patch set.  

Thanks,
Andrew

> 
> -- 
> Catalin
