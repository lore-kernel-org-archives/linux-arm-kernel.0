From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 11:05:35 +0100
Subject: [PATCH 1/2] n2100: support assigning XINT1 to UART
In-Reply-To: <20090928095813.GJ1773@mail.wantstofly.org>
References: <19134.28977.5491.323804@pilspetsen.it.uu.se>
	<20090928095813.GJ1773@mail.wantstofly.org>
Message-ID: <20090928100535.GE6715@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 11:58:13AM +0200, Lennert Buytenhek wrote:
> Can't you detect whether the 8250 IRQ is routed at boot?  E.g. cause
> the UART to throw an interrupt, check the XINT, clear the interrupt,
> and check the XINT again, and see if the 8250 interrupt status
> corresponds to the XINT or not?  (And then printk the result of the
> detection.)

8250 already has support for auto-probing its interrupt.
