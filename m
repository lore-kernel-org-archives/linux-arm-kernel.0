From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 May 2010 10:56:49 +0100
Subject: [PATCH V2] ST SPEAr: Adding support for shared irq layer
In-Reply-To: <4BDA716E.6010009@st.com>
References: <1272369611-20988-1-git-send-email-viresh.kumar@st.com>
	<4BDA716E.6010009@st.com>
Message-ID: <20100501095649.GD12172@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 30, 2010 at 11:28:06AM +0530, Viresh KUMAR wrote:
> On 4/27/2010 5:30 PM, Viresh KUMAR wrote:
> > Multiple peripherals in SPEAr share common hardware interrupt lines.
> > This patch adds support for a shared irq layer, which registers hardware
> > irqs by itself and exposes virtual irq numbers to peripherals.
> > 
> > Modifications in V2:
> > - use get_irq_data instead of get_irq_chip_data
> > - add support for enabling and clearing interrupt based on machine specific
> >   implementation. (i.e. It may be required to set/reset a bit in different
> >   machines for enabling/clearing interrupt.)
> > - Modified shirq related structures in spear320.c
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> 
> If this patch looks fine, can i send this to russell's patch system.

Patch looks fine - my only concern is that the IRQ subsystem isn't used
to decode things like serial status register interrupts.  It's supposed
to be used to decode the interrupt using the interrupt controllers only.
