From: dushistov@mail.ru (Evgeniy Dushistov)
Date: Sat, 26 Jul 2014 21:12:53 +0400
Subject: [PATCH] fix for certain sequnce of request_irq can cause irq storm
In-Reply-To: <20140726165620.GA29269@lunn.ch>
References: <20140726155659.GA22977@fifteen> <20140726165620.GA29269@lunn.ch>
Message-ID: <20140726171253.GA10370@fifteen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 26, 2014 at 06:56:20PM +0200, Andrew Lunn wrote:
> On Sat, Jul 26, 2014 at 07:56:59PM +0400, Evgeniy Dushistov wrote:
> > The problem is that hardware handled by arm/plat-orion/gpio.c,
> > require ack for edge irq, and no ack for level irq.
> 
> Hi Evgeniy
> 
> Thanks for the problem report and patch. What device are you using?
> An Orion5x based board or mv78xx0? Those are the only two left using
> this code.
> 

I used custom board with mv78200 CPU.

-- 
/Evgeniy
