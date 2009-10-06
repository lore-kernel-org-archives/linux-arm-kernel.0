From: bgat@billgatliff.com (Bill Gatliff)
Date: Tue, 06 Oct 2009 10:43:26 -0500
Subject: i.MX31 kernel panic and irq
In-Reply-To: <87077C4F48609F4392621D9F99DDE20901202E0E@tesla.star.galaxy.io>
References: <87077C4F48609F4392621D9F99DDE20901202E0E@tesla.star.galaxy.io>
Message-ID: <4ACB659E.3000206@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolf, Rene, HRO-GP wrote:
> Hi @ all :-)
>
> This is about a kernel panic I'm experiencing / causing.
> Setup: The system is a DENX QONG EVB-Light. I consists of an i.MX31
> (ARM11) + some flash and an FPGA doing eth. I use a rootfs over NFS
> and the kernel is loaded from tftp. Version 2.6.31 (pulled from
> DENX, which should be equal to the one from kernel.org)
> So inside my kernel module I do that:
>   

The OOPS messages suggest that the machine has run off into stuff that 
isn't code, which would be consistent with the stack pointer getting 
blown out of the stack memory.

I don't know if the i.mx31 kernel does any low-level throttling of 
incoming interrupts, but if it doesn't then a reason why your hand 
gripping the wire might trigger the OOPS is because you are holding the 
pin at an invalid signal level, thereby causing a burst of interrupt 
events that blow up the stack.  I would ignore the results of this test 
case.

I would expect bursts of 100kHz interrupts to be manageable, but not 
sustainable.  So the failure there might be for the same reasons as 
above.  Do you see problems with 10kHz inputs?

This is all speculation, of course...


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
