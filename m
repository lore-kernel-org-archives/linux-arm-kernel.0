From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 15 Mar 2017 14:10:01 +0800
Subject: [PATCH] serial: 8250: 8250_core: Use dev_name() during
 request_irq()
In-Reply-To: <CAHp75Vc0Ap53s=6SU2o5QjgdaBDWKC24bym7HUt6jQ69HrpdCg@mail.gmail.com>
References: <20170308121943.29340-1-vigneshr@ti.com>
 <CAHp75VeFKSbk9hvoJXdK6uOz+JYATD8D057iNv0JDuEnBFS=yw@mail.gmail.com>
 <2a0cf043-6e3f-6807-0794-d9d6f46b77f5@ti.com>
 <CAHp75Vc0Ap53s=6SU2o5QjgdaBDWKC24bym7HUt6jQ69HrpdCg@mail.gmail.com>
Message-ID: <20170315141001.62c4fc67@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Mar 2017 17:59:01 +0200 Andy Shevchenko wrote:

> On Tue, Mar 14, 2017 at 3:44 PM, Vignesh R <vigneshr@ti.com> wrote:
> > On Monday 13 March 2017 01:35 AM, Andy Shevchenko wrote:  
> >> On Wed, Mar 8, 2017 at 2:19 PM, Vignesh R <vigneshr@ti.com> wrote:  
> >>> Passing "serial" as name during request_irq() results in all serial port
> >>> irqs have same name. This does not help much to easily identify which
> >>> irq belongs to which serial port instance. Therefore pass dev_name()
> >>> during request_irq() so that better identifiable name is listed for
> >>> serial ports in cat /proc/interrupts output.
> >>>
> >>> Output of cat /proc/interrupts
> >>> Before this patch:
> >>>  26:        689          0     GICv2 309 Edge      serial
> >>> After this patch:
> >>>  26:        696          0     GICv2 309 Edge      2530c00.serial  
> 
> >  But, this change is making interrupt name more descriptive  
> 
> It doesn't in PCI case, it makes it worse.

indeed, in PCI case, I see 

4: ... 00:03.3

what about "dev_driver_string(up->port.dev)[dev_name(up->port.dev)]" as
we did for ahci case?

Thanks
