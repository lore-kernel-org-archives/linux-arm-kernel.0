From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Apr 2012 19:02:35 +0100
Subject: [PATCH] ARM:mfd: fix ezx-pcap build failure
In-Reply-To: <2732324.Os5djSkuuZ@yow-masselst-d1>
References: <1335366163-12920-1-git-send-email-mark.asselstine@windriver.com>
 <20120426215258.GG24211@n2100.arm.linux.org.uk>
 <2732324.Os5djSkuuZ@yow-masselst-d1>
Message-ID: <20120427180235.GA19778@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 11:28:28AM -0400, Mark Asselstine wrote:
> On April 26, 2012 22:52:58 Russell King - ARM Linux wrote:

> > What is the effect when the supplied IRQ does not have a mapping to a
> > GPIO - or it _does_ by way of a badly coded irq_to_gpio() function
> > but that GPIO is not the correct one.

> > There is no prevention against endlessly looping, so it could cause a
> > system lockup.

> Unfortunately the commit [b1148fd4 mfd: fix pcap irq bottom handler
> ] which modified things to loop as long as the interrupt is asserted didn't 
> supply much information regarding the behavior they were trying to achieve/fix 
> nor what would be the consequence of bailing earlier.

The usual reason for this pattern is to simulate level triggered IRQs on
an edge triggered interrupt controller.
