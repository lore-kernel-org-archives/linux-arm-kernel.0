From: mst@redhat.com (Michael S. Tsirkin)
Date: Fri, 18 Oct 2013 17:12:02 +0300
Subject: Build error for nommu if CONFIG_DEBUG_ATOMIC_SLEEP is selected
In-Reply-To: <1382088475.16935.4.camel@phoenix>
References: <1382088475.16935.4.camel@phoenix>
Message-ID: <20131018141202.GA24660@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 05:27:55PM +0800, Axel Lin wrote:
> Hi Michael,
> 
> I got below build error for nommu if CONFIG_DEBUG_ATOMIC_SLEEP is selected.
> Also got the same build error if CONFIG_PROVE_LOCKING is selected.
> 
> Seems this issue is introduced by commit 662bbcb2747c2
> "mm, sched: Allow uaccess in atomic with pagefault_disable()".
> 
> arch/arm/kernel/built-in.o: In function `arch_ptrace':
> arch/arm/kernel/ptrace.c:852: undefined reference to `might_fault'
> arch/arm/kernel/built-in.o: In function `restore_sigframe':
> arch/arm/kernel/signal.c:173: undefined reference to `might_fault'
> arch/arm/kernel/signal.c:174: undefined reference to `might_fault'
> arch/arm/kernel/signal.c:175: undefined reference to `might_fault'
> arch/arm/kernel/signal.c:176: undefined reference to `might_fault'
> arch/arm/kernel/built-in.o:arch/arm/kernel/signal.c:177: more undefined references to `might_fault' follow
> make: *** [vmlinux] Error 1
> 
> Regards,
> Axel

Can you send/upload your full .config please?
