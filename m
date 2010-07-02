From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 02 Jul 2010 20:17:42 +0200
Subject: pxa27x_udc: Oops on probe with usb cable connected.
In-Reply-To: <20100630115310.bcf967c1.ospite@studenti.unina.it> (Antonio
	Ospite's message of "Wed\, 30 Jun 2010 11\:53\:10 +0200")
References: <20100630115310.bcf967c1.ospite@studenti.unina.it>
Message-ID: <877hld7np5.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antonio Ospite <ospite@studenti.unina.it> writes:
> Note that using the original blob bootloader from Motorola there is no
> Oops but the UDC does not work at all, but maybe this is another
> issue, I mean: should pxa27x_udc probe consider the case when UDC is
> already active?
It was not designed for, but it actually works on my platform, when I launch
linux kernel from haret without disabling the UDC.

> Tell me how can i help debugging this, I've put the binary and the
> disassembled code in http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/
> plus some notes about old discussions on the same matter.
There are a few things I can do with a little more information.

 - Prevent gcc from being too smart by inlining functions : I think the right
   flag is -fno-inline. This will prevent irq_handle_data() and others to be
   inlined into pxa_udc_irq(), and ease the debugging.

 - add, on the first line of pxa27x_udc.c :
   #define DEBUG 1
   #define VERBOSE_DEBUG 1

Then, crash your device, and provide me with the very same traces as before :
 - the log
 - the module disassembly (which will contain irq_handle_data() and others

I will work from that.

Cheers.

--
Robert
