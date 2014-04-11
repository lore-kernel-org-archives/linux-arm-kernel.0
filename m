From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Apr 2014 15:16:09 +0200
Subject: [PATCH v4 1/9] mfd: AXP20x: Add mfd driver for AXP20x PMIC
In-Reply-To: <20140411120908.GC28800@sirena.org.uk>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <235623053.nj0gFkxyW5@wuerfel> <20140411120908.GC28800@sirena.org.uk>
Message-ID: <4702508.rsJyuQngOj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 April 2014 13:09:08 Mark Brown wrote:
> On Fri, Apr 11, 2014 at 01:25:03PM +0200, Arnd Bergmann wrote:
> 
> > Why do you have to enumerate the interrupts here? Can't you just
> > put all the numbers into the DT nodes of the devices using them?
> 
> > In general, I would say that the mfd driver should not care about
> > what is connected to it.
> 
> This then means that all the machines using the device need to define
> the interrupt table and have the MFD cells represented in the DT which
> means encoding Linux abstractions into the DT.
> 
> In cases where the device is also used with ACPI or platform data that's
> a definite issue since they have different idioms.  That applies less to
> PMICs tightly bound to particular SoCs but is an issue in general, not
> all the world is DT.
> 
> There's also issues here with us changing our subsystems.  Things like
> clocks are a bit indistinct at present, they're sort of floating between
> clock and other subsystems.  We've also done things like invent extcon,
> making completely new subdevices.  Keeping the data out of DT avoids
> problems when this happens.  The balance changes a bit if there are
> clearly reusable IPs within the device but sadly hardware designers
> don't always give us that and even then sometimes we don't want to use
> them like that.

Ok, fair enough.

	Arnd
