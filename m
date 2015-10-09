From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Fri, 9 Oct 2015 22:21:01 +0530
Subject: [PATCH v5 3/4] arm64, numa, dt: adding dt based numa support
 using dt node property arm, associativity
In-Reply-To: <20151009151850.GX17192@e104818-lin.cambridge.arm.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-4-git-send-email-gkulkarni@caviumnetworks.com>
 <20151009151850.GX17192@e104818-lin.cambridge.arm.com>
Message-ID: <CAFpQJXVMCktgza1JgrctMC9vdVkCrMEL2WENQPTVc-o1bR_5kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,


On Fri, Oct 9, 2015 at 8:48 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Aug 14, 2015 at 10:09:33PM +0530, Ganapatrao Kulkarni wrote:
>> Adding dt node pasring for numa topology using property arm,associativity.
>> arm,associativity property can be used to map memory, cpu and
>> io devices to numa node.
>>
>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>> ---
>>  arch/arm64/Kconfig            |   6 +
>>  arch/arm64/include/asm/numa.h |   7 +
>>  arch/arm64/kernel/Makefile    |   1 +
>>  arch/arm64/kernel/dt_numa.c   | 316 ++++++++++++++++++++++++++++++++++++++++++
>>  arch/arm64/kernel/smp.c       |   1 +
>>  arch/arm64/mm/numa.c          |  13 ++
>
> Since a lot of code here is very similar to powerpc, any chance of
> making it common, especially if we try to use the same bindings (maybe
> with a different prefix ("arm," vs "ibm,")? See
> https://members.openpowerfoundation.org/document/dl/469.
there is discussion happened in Documentation patch (PATCH 2/4),
whether to go with associativity based dt binding or not.
https://patchwork.ozlabs.org/patch/507536/
it seems this binding may not map or will be complex representation
for  numa topologies like mesh, ring topologies
which are used in upcoming arm64 numa platforms(as Mark Rutland pointed out).
in this regard, i  have proposed new binding, which will be based on
associativity and acpi.
This binding will serve wide range of arm64 platforms.
i am waiting for review comments for the proposal, however i can post
next version of patchset with new proposal implemented.

>
> Also, since this series is from August, any chance to post another and
> incorporate the feedback provided so far?
>
> --
> Catalin

thanks
Ganapat
