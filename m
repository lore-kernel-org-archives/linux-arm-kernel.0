From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Jun 2011 23:17:35 +0200
Subject: [PATCH v4 1/4] dt: check root nodes for match on
	of_platform_populate
In-Reply-To: <20110610211119.GA28994@ponder.secretlab.ca>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
	<201106102306.48426.arnd@arndb.de>
	<20110610211119.GA28994@ponder.secretlab.ca>
Message-ID: <201106102317.35879.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 June 2011 23:11:19 Grant Likely wrote:
> > Why doesn't of_platform_populate just call of_platform_bus_create on the
> > root node? That should normally take care of matching all children.
> 
> of_platform_bus_create creates a device for the 'bus' node, where
> of_platform_populate() creates children as direct children of the
> 'parent' device; which I think is the behaviour wanted here.
> 
> Also, of_platform_bus_create checks for a compatible property on the bus
> node, whereas of_platform_populate does not, and should not.

Ok, makes sense.

Thanks,

	Arnd
