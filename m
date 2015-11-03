From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Nov 2015 17:33:44 +0000
Subject: [PATCH] KVM/arm: kernel low level debug support for ARM32
 virtual platforms
In-Reply-To: <5638E1CD.8090006@codeaurora.org>
References: <1446508313-24404-1-git-send-email-m.smarduch@samsung.com>
 <5638E1CD.8090006@codeaurora.org>
Message-ID: <20151103173344.GC8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 11:33:17AM -0500, Christopher Covington wrote:
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index a2e16f9..d126bd4 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -1155,6 +1155,28 @@ choice
> >  		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
> >  		  devices, including VT8500, WM8505, WM8650 and WM8850.
> >  
> > +	config DEBUG_VIRT_UART_QEMU
> > +		bool "Kernel low-level debugging on QEMU Virtual Platform"
> > +		depends on ARCH_VIRT
> > +		select DEBUG_UART_PL01X
> > +		help
> > +		  Say Y here if you want the debug print routines to direct
> > +		  their output to PL011 UART port on QEMU Virtual Platform.
> > +		  Appropriate address values are:
> > +			PHYS		VIRT
> > +			0x9000000	0xf8090000
> 
> I thought the only guarantee the virt machine had about the memory map was
> that it would be described in the device tree.

This LL debug stuff is used prior to device tree being parsed.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
