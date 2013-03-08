From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 8 Mar 2013 10:43:58 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308150655.2bad20ce@skate>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307113917.0b751a75@skate> <201303081350.15429.arnd@arndb.de>
 <20130308150655.2bad20ce@skate>
Message-ID: <20130308174358.GD4094@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 03:06:55PM +0100, Thomas Petazzoni wrote:

> Really, I've sent this PCIe driver first on December, 7th, and it was
> working. 99% percent of the problems have been around the Device Tree,
> and continue to be around this. Wasn't DT supposed to make things
> easier? I am really surprised by the amount of nitpicking that this
> driver receives, when I see how incoherent the pinctrl DT bindings for
> the various SoC are for example...

Well, please consider that the push to make the DT a stable ABI means
it should be nearly as hard to change as the userspace ABI. If you've
watched the kernel you know how rough it is to do that. :(

Further, the PCI DT binding needs to implement the documented OF
specifications. It is not nitpicking to say that X does not conform to
the OF document.

pinctrl doesn't have an OF spec so people are doing SOC unique things.

I think a reasonable take away from some of this is that it may be
worthwhile to propose a DT binding before writing code for it,
especially if it is a new or complex concept.

> At this point, I have absolutely no idea what direction to take to
> bring this further. I'm basically in a dead-end.

I think Jason C. has said he is fine with bringing in the MBUS driver as
is.

The PCI-E driver's DT binding looks great to me, I have no further
comments at all, and I believe everyone else's comments related to DT
are delt with as well.

The huge discussion about the SW PCI-E bridge seems to be concluded
and everyone is agreeing on that point too.

Soo, I think you are not at all at a dead end, but nearly finished :)

Regards,
Jason
