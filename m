From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 25 Feb 2015 09:21:00 +0100
Subject: [BUG] ARM: socfpga: L2 cache init
In-Reply-To: <CADhT+wcpWcfca6JWLAfpQm_yPHOpTRRbCpiikUEs0ha1NHq3TQ@mail.gmail.com>
References: <20150206110557.GY8656@n2100.arm.linux.org.uk>
 <20150209155314.GA7994@pengutronix.de>
 <54D8E3BB.3060505@opensource.altera.com>
 <20150209185820.GB7994@pengutronix.de>
 <20150209213017.GC7994@pengutronix.de>
 <54DD2BB3.3090507@opensource.altera.com>
 <20150213080106.GD7994@pengutronix.de>
 <CADhT+wfbZb+u7a-aCi71rh9xFMuphOvqiyEgEYpmmTQtujLcVg@mail.gmail.com>
 <20150217222817.GS8656@n2100.arm.linux.org.uk>
 <CADhT+wcpWcfca6JWLAfpQm_yPHOpTRRbCpiikUEs0ha1NHq3TQ@mail.gmail.com>
Message-ID: <20150225082100.GO7994@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 05:55:05PM -0600, Dinh Nguyen wrote:
> On Tue, Feb 17, 2015 at 4:28 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 17, 2015 at 04:00:47PM -0600, Dinh Nguyen wrote:
> >> On Fri, Feb 13, 2015 at 2:01 AM, Steffen Trumtrar
> >> <s.trumtrar@pengutronix.de> wrote:
> >> > Yes, seems very likely that Russell is right.
> >>
> >> The bug doesn't happen if I disable the L2. Digging more...
> >
> > What ensures that the value written to socfpga_cpu1start_addr (by
> > of_property_read_u32() in socfpga_sysmgr_init(), called at .init_irq
> > time) is visible to the secondary CPU?
> 
> Yes, I was able use a JTAG debugger and can see that the
> secondary CPU is not seeing socfpga_cpu1start_addr correctly when the
> error occurs.
> 

\o/ very good. That sounds like the bug can be fixed soon.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
