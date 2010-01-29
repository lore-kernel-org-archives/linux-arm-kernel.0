From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 00:29:11 +0000
Subject: disable_irq() causes hang on AT91RM9200 targets?
In-Reply-To: <4B61C2C7.2000405@billgatliff.com>
References: <4B61C2C7.2000405@billgatliff.com>
Message-ID: <20100129002911.GN9153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 11:00:55AM -0600, Bill Gatliff wrote:
> Guys:
> 
> 
> Has anyone noticed that with 2.6.33-rc5 (at least) on AT91RM9200,
> disable_irq() seems to cause a lockup when the interrupt number is a
> GPIO line?  I'm calling disable_irq() from an interrupt handler on the
> same GPIO line.
> 
> I just saw this happen, and it seems to be repeatable.  Just wondering
> if this is a known issue before I start digging into it...

disable_irq_nosync(), disable_irq() has for a while waited for the IRQ
to clear before exiting. Now, guess what happens if you wait for the IRQ
to clear in the IRQ handler that is currently executing.
 
> 
> b.g.
> 
> -- 
> Bill Gatliff
> bgat at billgatliff.com
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
