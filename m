From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Oct 2009 11:22:08 +0000
Subject: [PATCH] Add KZM-ARM11-01 support
In-Reply-To: <20091030110841.GF11014@pengutronix.de>
References: <20091030135343.b907e5de.yuasa@linux-mips.org>
	<20091030110841.GF11014@pengutronix.de>
Message-ID: <20091030112208.GA1185@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2009 at 12:08:41PM +0100, Sascha Hauer wrote:
> > +#include <asm/irq.h>
> 
> linux/irq.h

linux/irq.h isn't actually the equivalent of asm/irq.h.  linux/irq.h is
the generic irq header.  asm/irq.h is correct here.  This is one of the
exceptions to "use linux/FOO.h instead of asm/FOO.h" rules.

> > +#include <asm/mach-types.h>
> > +#include <asm/setup.h>
> > +#include <asm/mach/arch.h>
> > +#include <asm/mach/irq.h>
> > +#include <asm/mach/map.h>
> > +#include <asm/mach/time.h>
> > +
> > +#include <mach/board-kzmarm11.h>
> > +#include <mach/clock.h>
> > +#include <mach/common.h>
> > +#include <mach/gpio.h>

However, this should be linux/gpio.h
