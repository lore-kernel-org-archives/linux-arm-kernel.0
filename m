From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Jan 2011 18:14:02 +0000
Subject: [PATCH v2 04/28] ARM: mm: cache-l2x0: Add support for
	re-enabling l2x0
In-Reply-To: <20110125154133.GB17280@n2100.arm.linux.org.uk>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-5-git-send-email-ccross@android.com>
	<1295968464.10109.264.camel@e102109-lin.cambridge.arm.com>
	<20110125154133.GB17280@n2100.arm.linux.org.uk>
Message-ID: <1295979242.10109.308.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-25 at 15:41 +0000, Russell King - ARM Linux wrote:
> I think we need to come up with some proper way to deal with cpuidle
> which doesn't involve adding lots of globally visible functions to all
> sorts of bits of code and having platforms call them individually,
> otherwise this is going to get _really_ messy in the future.
> 
> Maybe we need a notifier list which can be told when cpuidle events
> happen, so that parts of the system such as VFP and L2 cache support
> can do the right thing without having platforms add lots of stuff like
> 
>         gic_secondary_init();
>         gic_restore_interrupt_types();
>         vfp_enable();
>         l2x0_enable();
>         twd_enable();
>         ... etc ...
> 
> in their SoC specific code.

But do we need a strict order between such operations? The notifier call
chain isn't too flexible.

-- 
Catalin
