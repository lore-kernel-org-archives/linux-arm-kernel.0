From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Mar 2014 10:11:27 +0000
Subject: Forcing DEBUG_UART_{PHYS, VIRT} changes when switching between
 v7 platforms?
In-Reply-To: <8099777.qvOx0M5YBS@wuerfel>
References: <CAGVrzcZT+3VuuM9wdLTAu7wtbYTFcwSnMaYE7PcR8Eo4PmTnhg@mail.gmail.com>
 <8099777.qvOx0M5YBS@wuerfel>
Message-ID: <20140320101127.GN7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 08:07:52AM +0100, Arnd Bergmann wrote:
> On Wednesday 19 March 2014 16:38:45 Florian Fainelli wrote:
> > Hi,
> > 
> > When switching between different Multi v7 platform which all select
> > DEBUG_UART_8250, whichever platform managed to set
> > DEBUG_UART_{PHYS,VIRT} first will end-up forcing its value to the
> > others.
> > 
> > What I am seeing at the moment is for instance enabling BCM_MOBILE
> > will set DEBUG_UART_PHYS to 0x3e000000, disabling BCM_MOBILE and now
> > enabling MVEBU won't force a new DEBUG_UART_PHYS address to be
> > re-computed.
> > 
> > Should we add some sort of specific annotation to the Kconfig symbol
> > to force a recalculation of the UART PHYS address?
> 
> Russell has plans to change the Konfig logic in the future, removing the
> platform specific options. With the current code, you could probably
> do something along the lines of

The only reason the default values are there is to provide an easy way
for people to locate the values they need for the time being.  The
plan is to kill them off, so you have to enter them manually.  The
issue with that is it becomes quite painful if you have to keep searching
around for the right values when something breaks.

(Personally, I've ended up a number of times searching around for the
right address to generate uImage's for various target platforms which
can only load uImages... but I've now ended up with a script which has
that information stored in it...)

So yes, eventually these will have to be specified manually.  I'm
probably going to move them into file(s) in Documentation/arm/
so that we retain the information in an easily accessible form.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
