From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Mar 2013 00:00:17 +0000
Subject: omap: IORESOURCE_IRQ flags not set when defining a GPIO-IRQ
 from DT
In-Reply-To: <51312EA1.8000600@ti.com>
References: <CAAwP0s3ZzGf+_diZiQ7DSfWj74Sh=E9F+j=4UGnw8meHDR2AZQ@mail.gmail.com>
 <20130301173001.GC30923@n2100.arm.linux.org.uk> <51312EA1.8000600@ti.com>
Message-ID: <20130302000017.GD30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 04:41:37PM -0600, Jon Hunter wrote:
> Thanks for the history. For OMAP I see SMC_IRQ_FLAGS getting defined as
> follows in smc91x.h ...
> 
> #ifndef SMC_IRQ_FLAGS
> #define SMC_IRQ_FLAGS           IRQF_TRIGGER_RISING
> #endif
> 
> And so for OMAP devices using smc91x, it is always being configured as
> rising-edge. So it would be good to move OMAP to use a dynamic
> configuration too.

Yep.  I think that was requested back when I did the work from those
which remained...
