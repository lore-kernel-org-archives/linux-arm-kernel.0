From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 15 Aug 2013 08:57:30 +1000
Subject: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
In-Reply-To: <520B8468.7050307@arm.com>
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com> <520A7B00.8060405@arm.com>
 <1376428024.4255.14.camel@pasglop> <520B5584.7030608@arm.com>
 <1376480227.4255.66.camel@pasglop> <520B8468.7050307@arm.com>
Message-ID: <1376521050.4255.82.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-14 at 14:21 +0100, Sudeep KarkadaNagesha wrote:
> IMO moving of handling ibm,ppc-interrupt-server#s to generic code
> under
> #ifdef CONFIG_PPC seems to be cleaner approach than weak definitation.
> 
> As per my understanding each thread is a different logical cpu.
> Each logical cpu is mapped to unique physical id(either present in reg
> field or legacy ibm,ppc-interrupt-server#s field). So given a logical
> cpu id we can get the cpu node corresponding to it.
> Looking @ smp_setup_cpu_maps in arch/powerpc/kernel/setup-common.c
> and the comment in the same file: "This implementation only supports
> power of 2 number of threads.." the thread id id is implicit in the
> logical cpu id. Do we need to fetch that from DT ?

I don't want those parsing routines to make those assumptions. We have
changed our logical numbering in the past and may again.

Cheers,
Ben.
