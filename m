From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Jan 2011 10:11:59 +0000
Subject: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio
	irq chip
In-Reply-To: <20110107095609.GC6137@besouro.research.nokia.com>
References: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
	<20110105181918.GB8717@n2100.arm.linux.org.uk>
	<20110105192425.GA24729@besouro.research.nokia.com>
	<87aajfvstw.fsf@ti.com>
	<20110106062404.GA14141@besouro.research.nokia.com>
	<878vyxx697.fsf@ti.com>
	<20110107095609.GC6137@besouro.research.nokia.com>
Message-ID: <20110107101159.GP31708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 07, 2011 at 11:56:09AM +0200, Eduardo Valentin wrote:
> It is in wakeup-enable gpio. But the driver removes the wakeup
> flag from the gpio on its suspend function right after disabling the irq.
>  disable_irq(gpio_irq);
>  disable_irq_wake(gpio_irq);
> 
> In this case, the device uses gpio 61 as its irq line.

I think the solution to this is to have genirq synchronize the hardware
state with the lazy state on suspend transitions rather than trying to
fix this on a case-by-case basis.
