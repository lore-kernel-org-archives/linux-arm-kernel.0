From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Jun 2012 00:19:46 +0200
Subject: [RFC PATCHv1 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA Cyclone 5 HW
In-Reply-To: <20120627210600.GB26023@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-3-git-send-email-dinguyen@altera.com>
 <20120627162548.01adc769@skate> <20120627210600.GB26023@elf.ucw.cz>
Message-ID: <20120628001946.1d91e028@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 27 Jun 2012 23:06:00 +0200,
Pavel Machek <pavel@denx.de> a ?crit :

> > Just like the IRQ numbers, those defines for I/O registers are no
> > longer needed with the device tree.
> 
> Yep. It shows we have more DT-ization to do.
> 
> arch/arm/mach-socfpga/include/mach/uncompress.h needs UART0
> base... but device tree is not easily accessible at that point, right?

Yes, for those you still need fixed addresses, defined by #define, as
the DT is not accessible yet.

> > > +	}, {
> > > +		.virtual	= IO_ADDRESS(SOCFPGA_CLKMGR_BASE),
> > > +		.pfn		= __phys_to_pfn(SOCFPGA_CLKMGR_BASE),
> > > +		.length		= SZ_4K,
> > > +		.type		= MT_DEVICE,
> > > +	},
> > > +};
> > 
> > Most of those static mappings should instead be turned into dynamic
> > mappings created with ioremap(), at least for the timers.
> 
> Dynamic mappings so that we can use device tree -- not constants?

Yes, that's at least one of the reason. I think there are others, but
last time there was a discussion about static vs. dynamic mappings, I'm
not sure I understood exactly the arguments on which ones should be
used in which situation.

> Thanks for great review,

You're welcome!

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
