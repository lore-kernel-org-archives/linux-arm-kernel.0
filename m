From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jan 2014 11:55:18 +0100
Subject: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding
 information
In-Reply-To: <20140108105244.GA21607@earth.universe>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com>
 <52CD23E0.8030400@ti.com> <20140108105244.GA21607@earth.universe>
Message-ID: <3761842.HRY1CDBF4z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014 11:52:44 Sebastian Reichel wrote:
> 
> On Wed, Jan 08, 2014 at 03:39:36PM +0530, Roger Quadros wrote:
> > > What about the other clocks acquired in drivers/mfd/omap-usb-host.c? Shouldn't
> > > all of those be provided by via the DT phandle?
> > 
> > All those clocks are identically named across the OMAP SoCs and are unique for each
> > SoC, so providing DT phandle for all of them is not required.
> > 
> > The init_60m_fclk was renamed to l3init_60m_fclk in OMAP5, and hence the need for
> > this binding.
> 
> I understand the intention of this patch. I was just wondering if
> all the clocks should be referenced from DT even if that is not
> strictly needed at the moment. This would make clocks similar to
> other resources like regulators, gpios, irqs, ...
> 
> Having the clocks referenced from DT looks cleaner to me. It means I
> can check the DT file for any resources used by a driver. It also
> creates some kind of consistency in the kernel.

I think that would be best, yes. AFAIK most other platforms do this
already, OMAP is a bit behind because it started using clocks when the
infrastructure for doing this right was still incomplete.

	Arnd
