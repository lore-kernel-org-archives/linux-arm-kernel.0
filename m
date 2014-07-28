From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 28 Jul 2014 12:29:13 -0600
Subject: [Patch V2 2/2] i2c: mv64xxx: Remove internal compatible string
 from Documentation
In-Reply-To: <5514427.elClhaDPhf@wuerfel>
References: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
 <20140728132251.GN23220@titan.lakedaemon.net>
 <20140728132716.GC2891@lunn.ch> <5514427.elClhaDPhf@wuerfel>
Message-ID: <20140728182913.GB3708@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 03:51:27PM +0200, Arnd Bergmann wrote:

> I remember this being discussed when the quirk was initially added,
> but it seemed cleaner to handle this in the platform code at the time
> when it was just for one particular board. Now that it's basically
> an accepted feature of the i2c device that you have to know the
> SoC version, that should probably become a proper API.

Reading the SOC ID (which has to come from a PCI-E controller) is
already known to mess up PCI-E. IMHO, reading it should be minimized,
unless we can figure out how to fix that.

At some point we need to push back on the bootloader situation and
require the kernel to be booted with a correct DT.

All the infrastructure was already provided for this, I'm not sure how
we got into the situation where it was OK for bootloaders to ignore
the DT requirements and it is the kernel's job to fix it :(

Jason
