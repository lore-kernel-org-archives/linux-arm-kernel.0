From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 16 Dec 2013 11:49:27 +0100
Subject: possible regression on 3.13 when calling flush_dcache_page
In-Reply-To: <20131212171322.GT4360@n2100.arm.linux.org.uk>
References: <20131212143149.GI12099@ldesroches-Latitude-E6320>
 <20131212171322.GT4360@n2100.arm.linux.org.uk>
Message-ID: <20131216104927.GA9627@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 05:13:22PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 12, 2013 at 03:31:50PM +0100, Ludovic Desroches wrote:
> > I'll investigate on atmel-mci driver side but if someone has also this
> > issue or see what is wrong in the driver, please tell me all about it.
> 
> I'm not entirely sure what's causing this, but calling flush_dcache_page()
> from an IRQ isn't the best idea, as one of its side effects will be to
> unmask IRQs at the CPU.
> 

Thans for pointing this point. Having a look to other mmc drivers, it
seems flush_dcache_page() is also called from an IRQ. Not sure that
deferring it is the way to go.

What should be the most proper solution?

> BTW, the faulting function seems to have been removed in more recent
> kernels.

Same error with rc4 and linux-next.
