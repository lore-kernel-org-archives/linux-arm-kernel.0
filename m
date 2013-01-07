From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Jan 2013 11:11:13 -0500
Subject: [PATCH] ARM: Kirkwood: Support basic hotplug for PCI-E
In-Reply-To: <20121121182528.GA12715@obsidianresearch.com>
References: <20121121182528.GA12715@obsidianresearch.com>
Message-ID: <20130107161113.GG5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 11:25:28AM -0700, Jason Gunthorpe wrote:
> Unconditionally register the PCI-E bus, even if the link is currently
> down. When the link is brought up the bus can be scanned through
> /sys/bus/pci/rescan or otherwise. Since the HW has no interrupt for
> link up, userspace will have to take care of the timing.
> 
> An earlier version of this was contingent on CONFIG_HOTPLUG, but
> that is being removed from the kernel.
> 
> This also fixes printing the link up/down message to be displayed
> on one line (structured logging broke this?)
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/arm/mach-kirkwood/pcie.c |   10 +++-------
>  1 files changed, 3 insertions(+), 7 deletions(-)

Applied to mvebu/drivers.

thx,

Jason.
