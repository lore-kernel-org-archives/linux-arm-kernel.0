From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Mar 2011 11:21:38 +0000
Subject: [PATCH] ARM: S5PC210: add support for i2c PMICs on
	Universal_C210 board
In-Reply-To: <AANLkTimHPzbWpqFMXr2D46VXxLeHaAVTtpeCSaByweu8@mail.gmail.com>
References: <1297767555-13326-1-git-send-email-m.szyprowski@samsung.com>
	<20110215113504.GF4152@n2100.arm.linux.org.uk>
	<AANLkTimHPzbWpqFMXr2D46VXxLeHaAVTtpeCSaByweu8@mail.gmail.com>
Message-ID: <20110305112138.GB27468@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 11:40:26AM +0900, Kyungmin Park wrote:
> On Tue, Feb 15, 2011 at 8:35 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 15, 2011 at 11:59:15AM +0100, Marek Szyprowski wrote:
> >> ?#include <mach/map.h>
> >> +#include <mach/gpio.h>
> >
> > Need I say anything about this?
> 
> Hi Russell,
> 
> How about to prevent it as compiler error? It's frequent mistake.
> 
> At each mach/gpio.h
> 
> #ifndef __LINUX_GPIO_H
> #error "You should include <linux/gpio.h> instead of <mach/gpio.h>."
> #endif

It doesn't stop people including linux/gpio.h and then mach/gpio.h,
which is also a common mistake.  Besides, it's easy to catch when you
have a regexp setup in your mail reader to find them...
