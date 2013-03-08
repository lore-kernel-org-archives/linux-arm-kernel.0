From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 8 Mar 2013 14:12:44 -0300
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308164832.GA4094@obsidianresearch.com>
References: <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307222004.GA2450@localhost>
 <20130307230516.GA28975@obsidianresearch.com>
 <1362758390.25161.17.camel@sakura.staff.proxad.net>
 <20130308164832.GA4094@obsidianresearch.com>
Message-ID: <20130308171243.GB8693@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 09:48:32AM -0700, Jason Gunthorpe wrote:
> > since you can probe the chip ONFI timings, why are you doing that ?
> 
> Hmm, very interesting idea, but there is no implementation of this for
> the Marvell NAND driver today.
> 
> Ezequiel - how would you forsee fitting something like this in? The
> process for NAND would be to set the slowest timings (which have to be
> computed based on the TClk frequency), do READID, determine the
> fastest supported timings, and then update the timings again.
> 
> This seems like something that belongs in the NAND interface driver,
> not the device bus driver??
> 

Mmm... adding NAND support is in my TODO list. But I'm not quite there yet,
so I'm not sure what's the most appropriate way to handle this.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
