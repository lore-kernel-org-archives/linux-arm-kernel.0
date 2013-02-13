From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Feb 2013 09:18:56 +0000
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130213004118.GB1052@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302122259.54073.arnd@arndb.de>
 <20130213004118.GB1052@obsidianresearch.com>
Message-ID: <201302130918.56909.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 February 2013, Jason Gunthorpe wrote:
> , Arnd Bergmann wrote:
>  
> > b) drivers/bus/<something>
> > This would make a lot more sense if we followed the scheme I explained
> > in my discussion to Jason Gunthorpe, where we basically treat this
> > bus as a parent node in the device tree for anything that can get remapped.
> > Without that change, it feels a little misplaced
> 
> Also, FWIW, recall this related discussion and other possible DT
> binding:
> 
> http://www.spinics.net/lists/arm-kernel/msg219992.html
> 
> drivers/bus/orion-mbus.c feels like the right option, but when I
> looked at it, getting the DT binding, and full dynamicness setup
> seemed like it would be best done after non-DT support was purged, and
> that is somewhat contigent on getting the irqchip and timer stuff
> sorted (see my first attempt at that):
> 
> https://patchwork.kernel.org/patch/1852011/
> 
> Guess it depends where you want to draw the line on cleanups before
> something can be accepted..

I guess as long as we agree on where we are headed with the
address translation, it's ok to just move the code now and
change the code later. I would like to be strict about the
include path stuff though.

	Arnd
