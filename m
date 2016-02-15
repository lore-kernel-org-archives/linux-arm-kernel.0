From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Feb 2016 11:10:14 +0100
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <20160215100415.GD10826@n2100.arm.linux.org.uk>
References: <20160214165010.GA3189@roeck-us.net>
 <20160214195501.GA12289@pengutronix.de>
 <20160214200755.GB10826@n2100.arm.linux.org.uk>
 <20160215081750.GD12289@pengutronix.de>
 <20160215085818.GC10826@n2100.arm.linux.org.uk>
 <20160215091406.GE12289@pengutronix.de>
 <20160215100415.GD10826@n2100.arm.linux.org.uk>
Message-ID: <20160215101014.GG12289@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Mon, Feb 15, 2016 at 10:04:15AM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 15, 2016 at 10:14:06AM +0100, Uwe Kleine-K?nig wrote:
> > On Mon, Feb 15, 2016 at 08:58:18AM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Feb 15, 2016 at 09:17:50AM +0100, Uwe Kleine-K?nig wrote:
> > > > On Sun, Feb 14, 2016 at 08:07:55PM +0000, Russell King - ARM Linux wrote:
> > > > > On Sun, Feb 14, 2016 at 08:55:01PM +0100, Uwe Kleine-K?nig wrote:
> > > > > > So the unexpected abnormality here is that even though this device is
> > > > > > instantiated by dt, the driver doesn't provide any compatibles.
> > > > > > Either my expectation is wrong, then 67d02a1bbb33455 should be reverted
> > > > > 
> > > > > Your expectation is wrong.  AMBA primecell devices have hardware IDs
> > > > > and are matched to their drivers by those IDs.  Just like PCI.
> > > > 
> > > > pci devices don't appear in dt, do they? I don't see the connection
> > > > between amba devices and platform devices, see my other mail in this
> > > > thread for some more details.
> > > 
> > > They both have hardware IDs, and they are both matched via those hardware
> > > IDs.
> > 
> > I changed platform_match which is about matching by dt compatible, acpi
> > and/or device name. I don't see how this can affect an amba device given
> > they match to a driver by a hardware id.
> > 
> > > Your change has introduced a regression and is therefore wrong.
> > 
> > I'd like to understand though why and how my commit is wrong to be able
> > to fix it instead of getting it reverted.
> 
> I don't have the commit, and I haven't seen the patch so I can't
> comment further, sorry.

It's in -next. For a quick look:

	https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=67d02a1bbb33455

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
