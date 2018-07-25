From: alex@ghiti.fr (Alexandre Ghiti)
Date: Wed, 25 Jul 2018 09:38:57 +0200
Subject: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
In-Reply-To: <20180725003428.jsklz7pj4m7lj3m4@pburton-laptop>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180725003428.jsklz7pj4m7lj3m4@pburton-laptop>
Message-ID: <7c187058-12c7-ee2d-3ceb-d17ba94875b8@ghiti.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Thanks for having tested it, I remove mips from my list.

Thanks again,

Alex


On 07/25/2018 02:34 AM, Paul Burton wrote:
> Hi Alexandre,
>
> On Thu, Jul 05, 2018 at 11:07:05AM +0000, Alexandre Ghiti wrote:
>> In order to reduce copy/paste of functions across architectures and then
>> make riscv hugetlb port (and future ports) simpler and smaller, this
>> patchset intends to factorize the numerous hugetlb primitives that are
>> defined across all the architectures.
>>
>> Except for prepare_hugepage_range, this patchset moves the versions that
>> are just pass-through to standard pte primitives into
>> asm-generic/hugetlb.h by using the same #ifdef semantic that can be
>> found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.
>>
>> s390 architecture has not been tackled in this serie since it does not
>> use asm-generic/hugetlb.h at all.
>> powerpc could be factorized a bit more (cf huge_ptep_set_wrprotect).
>>
>> This patchset has been compiled on x86 only.
> For MIPS these look good - I don't see any issues & they pass a build
> test (using cavium_octeon_defconfig which enables huge pages), so:
>
>      Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts
>
> Thanks,
>      Paul
