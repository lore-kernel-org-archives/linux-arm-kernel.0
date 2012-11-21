From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 21 Nov 2012 12:19:02 -0700
Subject: [PATCH] ARM: Kirkwood: Support basic hotplug for PCI-E
In-Reply-To: <20121121190230.GB9177@lunn.ch>
References: <20121121182528.GA12715@obsidianresearch.com>
 <20121121183527.GC15800@titan.lakedaemon.net>
 <20121121190230.GB9177@lunn.ch>
Message-ID: <20121121191902.GD12822@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 08:02:30PM +0100, Andrew Lunn wrote:

> I think it may also cause problems with udev persistent rules. The IDs
> will change for devices which are on the second controller and the
> first controller was previously not registered. I've not idea if this
> is just a theoretical problem, or a real problem.

Most udev persistance rules I've seen are based on something more
permanent, like a MAC address or whatnot. The PCI-E bus number is
usually not used because it is historically not stable.

If a system is pluggable then the bus number already changes based on
what ports are plugged, so in a sense this patch makes things a bit
better by providing stable bus numbers.

When the PCI-E driver is integrated with DT it can get a busnr
resource range unique to each port and then the bus numbers will be
stable in almost all cases.

Jason
