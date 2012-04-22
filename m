From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Apr 2012 15:13:21 +0100
Subject: [PATCH 02/17] ARM clps711x: Added Cirrus Logic EP7312 CPU variant
In-Reply-To: <201204221358.29315.arnd@arndb.de>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
 <201204211211.36273.arnd@arndb.de>
 <20120421122044.GF24211@n2100.arm.linux.org.uk>
 <201204221358.29315.arnd@arndb.de>
Message-ID: <20120422141321.GI24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 22, 2012 at 01:58:28PM +0000, Arnd Bergmann wrote:
> On Saturday 21 April 2012, Russell King - ARM Linux wrote:
> > The headers still have to end up being in an accessible place, and having
> > drivers include the minimum required is a good idea.  Merely moving them
> > into include/mach and updating the include statements as far as I'd go.
> > (and I've never liked the idea of mach/hardware.h being an "include the
> > world for this platform" header file.)
> 
> Digging a bit deeper into clps711x, I found that with Alexander's patch
> series applied, there is nothing that actually includes the three
> asm/hardware/ep7*.h files. I wonder about the motivation behind providing
> them. Any reason we can't just remove those three files altogher?

To me it looks like there isn't anything using any definitions from those
ep721*.h files, so there's little point them existing.  And they've not
changed since 2.6.12-rc2 either...  I'd suggest just getting rid of those
two headers entirely.
