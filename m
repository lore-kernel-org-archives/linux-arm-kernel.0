From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 May 2011 17:09:44 +0100
Subject: [PATCH] ARM: fix missing 'cpu_relax()' declaration
In-Reply-To: <1306157607-18406-1-git-send-email-marc.zyngier@arm.com>
References: <1306157607-18406-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110523160944.GA15138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 02:33:27PM +0100, Marc Zyngier wrote:
> ARM build fails with the following symptom:
> 
>   CC      arch/arm/kernel/asm-offsets.s
> In file included from include/linux/seqlock.h:29,
>                  from include/linux/time.h:8,
>                  from include/linux/timex.h:56,
>                  from include/linux/sched.h:57,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/linux/spinlock.h: In function 'spin_unlock_wait':
> include/linux/spinlock.h:360: error: implicit declaration of function 'cpu_relax'
> make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
> 
> Fix it by including <asm/processor.h>.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Wonder why we haven't see this before.  Could you send this to the patch
system please?

Thanks.
