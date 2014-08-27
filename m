From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Aug 2014 10:16:59 +0100
Subject: [PATCH V2] setup: Move unmask of async interrupts after possible
 earlycon setup
In-Reply-To: <1409084618-14693-1-git-send-email-jcm@redhat.com>
References: <1409084618-14693-1-git-send-email-jcm@redhat.com>
Message-ID: <20140827091659.GF6968@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 09:23:38PM +0100, Jon Masters wrote:
> The kernel wants to enable reporting of asynchronous interrupts (i.e.
> System Errors) as early as possible. But if this happens too early then
> any pending System Error on initial entry into the kernel may never be
> reported where a user can see it. This situation will occur if the kernel
> is configured with CONFIG_PANIC_ON_OOPS set and (default or command line)
> enabled, in which case the kernel will panic as intended, however the
> associated logging messages indicating this failure condition will remain
> only in the kernel ring buffer and never be flushed out to the (not yet
> configured) console. Therefore, this patch moves the enabling of
> asynchronous interrupts during early setup to as early as reasonable,
> but after parsing any possible earlycon parameters setting up earlycon.
> 
> Signed-off-by: Jon Masters <jcm@redhat.com>

The patch looks fine, we'll pick it up. We initially didn't have this at
all and it was only showing when it got to user space. But I moved it
too early afterwards.

Thanks.

-- 
Catalin
