From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Jul 2010 12:08:37 -0400 (EDT)
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <4C31FC27.4010102@stericsson.com>
References: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
	<4C2DE024.8060308@stericsson.com>
	<20100705082835.GA32178@gw.healthdatacare.com>
	<4C31AD62.6070805@stericsson.com>
	<20100705101852.GA19338@n2100.arm.linux.org.uk>
	<4C31B527.8060401@stericsson.com>
	<20100705135552.GB19338@n2100.arm.linux.org.uk>
	<4C31E6C4.8030200@stericsson.com>
	<20100705141926.GA23860@n2100.arm.linux.org.uk>
	<4C31FC27.4010102@stericsson.com>
Message-ID: <alpine.LFD.2.00.1007051204320.6020@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jul 2010, Per Fransson wrote:

> On 07/05/2010 04:19 PM, Russell King - ARM Linux wrote:
> > On Mon, Jul 05, 2010 at 04:05:56PM +0200, Per Fransson wrote:
> >> Well, I had another suggestion in my last mail.
> > 
> > Which is going to need per-CPU type support in order to achieve.  Do
> > we really want to implement relocate_new_kernel for each of the 24
> > CPU types which we currently support?
> > 
> 
> Perhaps not. Couldn't the variable delay be macrofied then, i.e. a 
> macro like
> 
> MMU_DISABLED_DELAY_AND_EXEC(<asm instr>)
> 
> which would do nothing for an appropriate amount of time and put the 
> instruction in the last MMU mapped slot?

This delay is not the same across various ARM implementations, and I 
don't think it is even reliably predictable and stable on some 
implementations.


Nicolas
