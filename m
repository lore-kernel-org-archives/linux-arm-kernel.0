From: giometti@enneenne.com (Rodolfo Giometti)
Date: Tue, 17 Nov 2009 13:37:21 +0100
Subject: [PATCH] arm pxa: remove "direction input" forcing for IRQ GPIOs
In-Reply-To: <20091117123422.GU14091@buzzloop.caiaq.de>
References: <1258456906-12338-1-git-send-email-giometti@linux.it>
	<20091117114429.GT14091@buzzloop.caiaq.de>
	<20091117120501.GC8008@gundam.enneenne.com>
	<20091117123422.GU14091@buzzloop.caiaq.de>
Message-ID: <20091117123721.GG8008@gundam.enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 01:34:22PM +0100, Daniel Mack wrote:
> On Tue, Nov 17, 2009 at 01:05:01PM +0100, Rodolfo Giometti wrote:
> > On Tue, Nov 17, 2009 at 12:44:29PM +0100, Daniel Mack wrote:
> > > On Tue, Nov 17, 2009 at 12:21:46PM +0100, Rodolfo Giometti wrote:
> > > > PXA CPUs may use their GPIOs as IRQ lines even if they are selected as
> > > > outputs (see for example figure 24-1 into PXA27x Processor Family
> > > > Developer's Manual). So forcing GPIOs IRQ lines as inputs is not
> > > > correct.
> > > > 
> > > > Programmers should set up GPIOs direction according to their usage and
> > > > the function pxa_gpio_irq_type() should simply enable the IRQ
> > > > detection.
> > > 
> > > Interesting. Is this an academic issue or do you actually use that?
> > > That would mean you externally drive the IO pin level to something else
> > > than the output driver provides, which isn't healthy at all.
> > 
> > It's a real configuration with no electrical drawbacks at all! Of
> > course the driver's output must be passive (I use it to detect a CARD
> > insert) but it's functional.
> 
> For such situations, the pullup/pulldown functions are normally used.
> Have you tried that?

Yes, the code has been tested on my board and it works perfectly.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
