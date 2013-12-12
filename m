From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Dec 2013 17:13:22 +0000
Subject: possible regression on 3.13 when calling flush_dcache_page
In-Reply-To: <20131212143149.GI12099@ldesroches-Latitude-E6320>
References: <20131212143149.GI12099@ldesroches-Latitude-E6320>
Message-ID: <20131212171322.GT4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:31:50PM +0100, Ludovic Desroches wrote:
> I'll investigate on atmel-mci driver side but if someone has also this
> issue or see what is wrong in the driver, please tell me all about it.

I'm not entirely sure what's causing this, but calling flush_dcache_page()
from an IRQ isn't the best idea, as one of its side effects will be to
unmask IRQs at the CPU.

BTW, the faulting function seems to have been removed in more recent
kernels.
