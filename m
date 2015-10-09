From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Oct 2015 16:18:50 +0100
Subject: [PATCH v5 3/4] arm64, numa, dt: adding dt based numa support
 using dt node property arm, associativity
In-Reply-To: <1439570374-4079-4-git-send-email-gkulkarni@caviumnetworks.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-4-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <20151009151850.GX17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 10:09:33PM +0530, Ganapatrao Kulkarni wrote:
> Adding dt node pasring for numa topology using property arm,associativity.
> arm,associativity property can be used to map memory, cpu and
> io devices to numa node.
> 
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> ---
>  arch/arm64/Kconfig            |   6 +
>  arch/arm64/include/asm/numa.h |   7 +
>  arch/arm64/kernel/Makefile    |   1 +
>  arch/arm64/kernel/dt_numa.c   | 316 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/smp.c       |   1 +
>  arch/arm64/mm/numa.c          |  13 ++

Since a lot of code here is very similar to powerpc, any chance of
making it common, especially if we try to use the same bindings (maybe
with a different prefix ("arm," vs "ibm,")? See
https://members.openpowerfoundation.org/document/dl/469.

Also, since this series is from August, any chance to post another and
incorporate the feedback provided so far?

-- 
Catalin
