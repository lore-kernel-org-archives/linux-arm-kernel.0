From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 08 Oct 2010 17:28:54 -0400 (EDT)
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <20101008205855.GP7558@atomide.com>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<20101007212707.GI7558@atomide.com>
	<alpine.LFD.2.00.1010072121530.3107@xanadu.home>
	<20101008203221.GM7558@atomide.com> <20101008205855.GP7558@atomide.com>
Message-ID: <alpine.LFD.2.00.1010081727510.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Oct 2010, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [101008 13:24]:
> > * Nicolas Pitre <nico@fluxnic.net> [101007 18:16]:
> > > On Thu, 7 Oct 2010, Tony Lindgren wrote:
> > > > 
> > > > Can you please pass the read and write functions to the driver
> > > > in platform_data? We are already booting kernels with both
> > > > ARMv6 and 7 compiled in.
> > > 
> > > No.  This has nothing to do with platform as this can be determined 
> > > within the driver itself.  Would be much better to simply determine 
> > > which flavor to use at driver init time and assign two function pointers.
> > 
> > In the long run some platform init code is needed for powering
> > up the JTAG interface and take care of pin multiplexing etc.
> > 
> > Also, isn't DCC (Debug Communications Channel) a JTAG standard? At least
> > the following does not say anything about DCC being ARM specific:
> > 
> > http://en.wikipedia.org/wiki/Joint_Test_Action_Group
> > 
> > BTW, we already have ETM (Embedded Trace Module) in arch/arm/kernel/etm.c.
> > That is set up as amba driver.
> 
> Hmm, then again it says this about the scan chains:
> 
>   "SCAN_N ... ARM instruction to select the numbered scan chain used
>   with EXTEST or INTEST. There are six scan chains"
> 
> Which seems like these scan chains are ARM specific.

Or ETM specific even.


Nicolas
