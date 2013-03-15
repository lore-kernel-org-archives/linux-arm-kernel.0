From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 12:20:54 +0000
Subject: [PATCH v3 03/11] clocksource: sp804: add device tree support
In-Reply-To: <51408A71.9090501@gmail.com>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-4-git-send-email-haojian.zhuang@linaro.org>
 <1363172730.3100.17.camel@hornet> <51408A71.9090501@gmail.com>
Message-ID: <20130315122054.GI4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 09:17:21AM -0500, Rob Herring wrote:
> How about:
> 
> 1 irq - TIMINT1
> 2 irqs w/ same source # - TIMINTC
> 2 irqs w/ different source # - TIMINT1 and TIMINT2
> 
> I'm not completely sure if Linux and the irq domain code handles the
> same interrupt source repeated. It should because that is basically a
> shared irq line.

I think you're missing something here.  Any particular platform will
generally only wire either the common interrupt, or the individual
interrupts.  Very few, if any, will wire both.

It's just like stuff such as MMCI and the UARTs.  They have a combined
interrupt out, and individual interrupt outs.  However, they're all
written for the combined interrupt only, because practically no one
uses the individal interrupts.
