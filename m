From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Oct 2013 08:18:39 -0700
Subject: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
In-Reply-To: <52580438.4040002@ti.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost>
 <5256AA7F.8030005@ti.com> <20131010160018.GA29913@atomide.com>
 <5257BB8C.5080001@ti.com> <52580438.4040002@ti.com>
Message-ID: <20131011151838.GM29913@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [131011 07:07]:
> On 10/11/2013 11:49 AM, Roger Quadros wrote:
> > On 10/10/2013 07:00 PM, Tony Lindgren wrote:
> >>
> >> Well the irq_set_wake() should only be needed for suspend and resume. For runtime PM
> >> the wake-events should be always enabled by default as pointed out by Alan Stern
> >> a while back.
> > 
> > Right, but we need to update the WAKEUP_EN bit in the pad control register for that
> > to work, no?. This is something we are not doing in the driver.
> 
> OK sorry, just figured out that we are doing it indeed in pcs_irq_set().
> Wasn't able to test it yet with USB. But I don't see any issues except that
> pcs_soc->rearm() needs to be called from pcs_irq_set() instead of from pcs_irq_unmask().

Hmm that sounds like a different behaviour compared to what I'm seeing
on omap3. Care to send a little fix on top of these patches so I can
test it with my set up too? 

It seems that the only difference would be that we're calling rearm()
after both masking and unmasking, which seemed unnecessary to me earlier.
 
> After that you can add my
> 
> Reviewed-by: Roger Quadros <rogerq@ti.com>

Thanks, for testing, sorry I already pushed them out after Kevin
ran his PM tests on them.

Regards,

Tony
