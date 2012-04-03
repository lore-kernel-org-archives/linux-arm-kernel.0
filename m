From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Apr 2012 10:26:12 -0700
Subject: [PATCH 05/12] Add dummy smsc911x regulators to cm-t35.
In-Reply-To: <4F75CFD8.7050809@compulab.co.il>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
 <1332494504-10251-6-git-send-email-Russ.Dill@ti.com>
 <4F71E290.2050403@compulab.co.il>
 <20120327172819.GQ9859@atomide.com> <4F72B0D0.70703@compulab.co.il>
 <20120328170316.GR9859@atomide.com>
 <4F75CFD8.7050809@compulab.co.il>
Message-ID: <20120403172611.GD8240@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [120330 08:26]:
> On 03/28/12 19:03, Tony Lindgren wrote:
> > 
> > ..care to see if you have OMAP_GPIO_IRQ entry for your board? If so, we're
> > still waiting for the cleanup-fixes branch to get merged that changes
> > things to use gpio_to_irq() instead.
> 
> Nope, no OMAP_GPIO_IRQ in the board code.
> Also, the GPIO -> IRQ mapping for the smsc911x is done in gpmc-smsc911x.c
> and it uses gpio_to_irq() already.

OK, maybe it's caused by spurious interrupts? Have you
checked the GPIO interrupt edge/level setup is correct?

Regards,

Tony
