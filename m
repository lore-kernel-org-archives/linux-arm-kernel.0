From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Oct 2010 13:32:22 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <alpine.LFD.2.00.1010072121530.3107@xanadu.home>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<20101007212707.GI7558@atomide.com>
	<alpine.LFD.2.00.1010072121530.3107@xanadu.home>
Message-ID: <20101008203221.GM7558@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [101007 18:16]:
> On Thu, 7 Oct 2010, Tony Lindgren wrote:
> > 
> > Can you please pass the read and write functions to the driver
> > in platform_data? We are already booting kernels with both
> > ARMv6 and 7 compiled in.
> 
> No.  This has nothing to do with platform as this can be determined 
> within the driver itself.  Would be much better to simply determine 
> which flavor to use at driver init time and assign two function pointers.

In the long run some platform init code is needed for powering
up the JTAG interface and take care of pin multiplexing etc.

Also, isn't DCC (Debug Communications Channel) a JTAG standard? At least
the following does not say anything about DCC being ARM specific:

http://en.wikipedia.org/wiki/Joint_Test_Action_Group

BTW, we already have ETM (Embedded Trace Module) in arch/arm/kernel/etm.c.
That is set up as amba driver.

Regards,

Tony
