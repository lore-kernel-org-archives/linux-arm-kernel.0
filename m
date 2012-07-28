From: dczarn@o2.pl (Damian Czarnecki)
Date: Sat, 28 Jul 2012 16:56:42 +0000 (UTC)
Subject: PXA 26x GPIO possible regression in kernel 3.3 and newer
References: <loom.20120727T164936-412@post.gmane.org>
 <1343484435.81739.YahooMailClassic@web171606.mail.ir2.yahoo.com>
Message-ID: <loom.20120728T185108-140@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Parsons <lost.distance <at> yahoo.com> writes:

> 
> Hello Damian,
> 
> That sounds familiar. In 3.3 the number of PXA builtin GPIOs
> (PXA_NR_BUILTIN_GPIO) was increased from 128 to 192.
> Consequently the board GPIO numbers all increased by 64.
> On the iPAQ hx4700 that had the effect of pushing EGPIO
> numbers from 192-199 to 256-263, beyond the 256 maximum.
> 
> The fix is to set ARCH_NR_GPIO in arch/arm/Kconfig to a
> higher maximum (for example, the iPAQ hx4700 sets 264).
> 
> Regards,
> Paul
> 

Thank you for taking your time to reply, Paul.
Yes, I remember reading about that change in kernel 3.3.
I tried almost every value that I thought may be correct
(but even the default 256 should be enough).
As I said, only the PXA GPIOs don't seem to work. 
Another strange thing is that I managed to read a line:
"NR_IRQS: 16 nr_irqs: 358" early on boot.
This is suspicious, because on kernel 3.2 and lower 
this is "NR_IRQS: 288 nr_irqs: 358".

I don't have any more ideas about that.
