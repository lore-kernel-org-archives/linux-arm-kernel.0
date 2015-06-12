From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 12 Jun 2015 11:19:59 -0700
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <1434069014.28544.1.camel@ellerman.id.au> (Michael Ellerman's
 message of "Fri, 12 Jun 2015 10:30:14 +1000")
References: <1434069014.28544.1.camel@ellerman.id.au>
Message-ID: <7hlhfobxgw.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Ellerman <mpe@ellerman.id.au> writes:

> Hi all,
>
> After merging the arm-soc tree, today's linux-next build (arm_multi_v7_defconfig)
> failed like this:
>
>   scripts/Makefile.build:258: recipe for target 'arch/arm/mach-socfpga/platsmp.o' failed
>   arch/arm/mach-socfpga/platsmp.c:66:23: error: 'socfpga_secondary_startup' undeclared (first use in this function)
>      writel(virt_to_phys(socfpga_secondary_startup),
>                        ^
>
> Caused by the interaction of commits 45be0cdb5323 "ARM: socfpga: add
> CPU_METHOD_OF_DECLARE for Arria 10" and 02b4e2756e01 "ARM: v7 setup function
> should invalidate L1 cache".

I found this as well, unfortunately after it was already pulled for -next.

> I applied the following fix for today.

Yes, that's the right fix, and arm-soc now has the equivalent fix as
well.

Thanks,

Kevin
