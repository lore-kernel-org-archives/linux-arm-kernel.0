From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 17 Nov 2009 12:00:04 -0500
Subject: [PATCH] arm pxa: remove "direction input" forcing for IRQ GPIOs
In-Reply-To: <20091117114429.GT14091@buzzloop.caiaq.de>
References: <1258456906-12338-1-git-send-email-giometti@linux.it>
	<20091117114429.GT14091@buzzloop.caiaq.de>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE552D@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 17, 2009 4:44 AM, Daniel Mack wrote:
> On Tue, Nov 17, 2009 at 12:21:46PM +0100, Rodolfo Giometti wrote:
>> PXA CPUs may use their GPIOs as IRQ lines even if they are selected as
>> outputs (see for example figure 24-1 into PXA27x Processor Family
>> Developer's Manual). So forcing GPIOs IRQ lines as inputs is not
>> correct.
>> 
>> Programmers should set up GPIOs direction according to their usage and
>> the function pxa_gpio_irq_type() should simply enable the IRQ
>> detection.
>
> Interesting. Is this an academic issue or do you actually use that?
> That would mean you externally drive the IO pin level to something else
> than the output driver provides, which isn't healthy at all.

Actually, it appears this is a way of generating a software interrupt.

If the GPIO IRQ line is set as an output you could drive the pin to the
appropriate level to generate an interrupt.

Regards,
Hartley
