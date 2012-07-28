From: lost.distance@yahoo.com (Paul Parsons)
Date: Sat, 28 Jul 2012 21:23:18 +0100 (BST)
Subject: PXA 26x GPIO possible regression in kernel 3.3 and newer
In-Reply-To: <loom.20120728T185108-140@post.gmane.org>
Message-ID: <1343506998.34469.YahooMailClassic@web171606.mail.ir2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Damian,

oops, although my notes say that the number of PXA builtin
GPIOs increased from 128 to 192 in 3.3, in fact the change
was much earlier. It was in 3.3 that ARCH_NR_GPIO was added,
allowing me to fix the hx4700 GPIO values that had been
broken since 2.6.32. Apologies for the misleading advice.

That said, your HTC Blue Angel sounds very similar to the
PXA270 based iPAQ hx4700. For example both include the asic3.
But the kernel sources make only one mention of the HTC Blue
Angel, so I'm wondering if it is a fully supported platform.

Regards,
Paul

--- On Sat, 28/7/12, Damian Czarnecki <dczarn@o2.pl> wrote:
> Thank you for taking your time to reply, Paul.
> Yes, I remember reading about that change in kernel 3.3.
> I tried almost every value that I thought may be correct
> (but even the default 256 should be enough).
> As I said, only the PXA GPIOs don't seem to work. 
> Another strange thing is that I managed to read a line:
> "NR_IRQS: 16 nr_irqs: 358" early on boot.
> This is suspicious, because on kernel 3.2 and lower 
> this is "NR_IRQS: 288 nr_irqs: 358".
> 
> I don't have any more ideas about that.
