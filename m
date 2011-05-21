From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 May 2011 00:47:25 +0100
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<20110519233958.GB18181@ponder.secretlab.ca>
	<4DD66B8A.5040404@gmail.com> <201105201621.03801.arnd@arndb.de>
	<4DD68614.6090209@gmail.com>
	<a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>
	<BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
Message-ID: <20110521234725.GB17672@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 21, 2011 at 11:42:34AM -0600, Grant Likely wrote:
> Russell, it seems to me that the primary behaviour that amba_bus has
> over platform_bus is the clock management, and secondarily
> verification of the type of device by the device id.  Am I correct, or
> am I missing something?

It matches by vendor/device ID just like PCI does, and does the bus
clock management and power management in a really nice way, which I
doubt platform devices will ever do.

The way this discussion is going, I'm going to suggest that we also
convert PCI stuff to being platform devices too.  I don't see the
point of PCI existing for all the same reasons being given in this
thread.
