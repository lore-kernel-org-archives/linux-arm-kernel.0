From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Mon, 15 Mar 2010 19:23:18 +0530
Subject: QUERY: How to handle sharing of interrupt between
	different	peripherals.
In-Reply-To: <20100315111100.GC700@n2100.arm.linux.org.uk>
References: <4B9DB99A.5040104@st.com>
	<20100315111100.GC700@n2100.arm.linux.org.uk>
Message-ID: <4B9E3BCE.1060809@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2010 4:41 PM, Russell King - ARM Linux wrote:
> We do have a system for having a multi-level approach to interrupt decoding.
> Since you have a register which allows you to identify the source of the
> interrupt, I'd recommend for maximum system performance that you use it.
> 
> Shared interrupts have the disadvantage that you need to run each handler
> every time a device on the shared interrupt signals, which can be very
> wasteful both in terms of instruction cache lines and IO accesses.
> 
> Search arch/arm/ for set_irq_chained_handler to find examples of who to
> deal with multi-level handling of IRQs.

OK. So we need to create virtual irqs (defined by s/w), for shared irqs
which are mapped on to the real irq (defined by the H/W) through
set_irq_chained_handler, right?
thanks for your help.

regards
Shiraz
