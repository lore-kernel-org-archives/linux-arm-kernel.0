From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 17 Nov 2009 12:44:29 +0100
Subject: [PATCH] arm pxa: remove "direction input" forcing for IRQ GPIOs
In-Reply-To: <1258456906-12338-1-git-send-email-giometti@linux.it>
References: <1258456906-12338-1-git-send-email-giometti@linux.it>
Message-ID: <20091117114429.GT14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 12:21:46PM +0100, Rodolfo Giometti wrote:
> PXA CPUs may use their GPIOs as IRQ lines even if they are selected as
> outputs (see for example figure 24-1 into PXA27x Processor Family
> Developer's Manual). So forcing GPIOs IRQ lines as inputs is not
> correct.
> 
> Programmers should set up GPIOs direction according to their usage and
> the function pxa_gpio_irq_type() should simply enable the IRQ
> detection.

Interesting. Is this an academic issue or do you actually use that?
That would mean you externally drive the IO pin level to something else
than the output driver provides, which isn't healthy at all.

Daniel
