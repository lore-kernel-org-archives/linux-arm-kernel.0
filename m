From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Feb 2014 16:37:50 +0100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <2344852.BKudsNuPXM@wuerfel>
References: <53039894.10905@keymile.com> <2193926.ls2teBqnfK@wuerfel>
 <20140221161108.50a4c932@skate> <2344852.BKudsNuPXM@wuerfel>
Message-ID: <20140221163750.3741a8ad@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Fri, 21 Feb 2014 16:20:45 +0100, Arnd Bergmann wrote:

> > What if the size of your BAR is 128 MB + 64 MB + 32 MB ? Then you need
> > three windows, and your algorithm doesn't work 
> 
> I was hoping we could avoid using more than two windows.
> With the algorithm above we would round up to 256MB and
> fail if that doesn't fit, which is the same thing that
> happens when you run out of space.

The problem is precisely that we currently don't have any well to tell
the Linux PCI core that we need to round up the size of a BAR. That's
the whole starting point of the discussion :-)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
