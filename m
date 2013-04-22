From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Apr 2013 11:46:54 +0100
Subject: arm: ARM_VIRT_EXT is not supported by all v7 platforms, so it
 should not be enabled by default
In-Reply-To: <kks14c$e4p$1@ger.gmane.org>
References: <kks14c$e4p$1@ger.gmane.org>
Message-ID: <20130422104653.GA2572@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 07:07:15PM +0100, Sebastian Gottschall wrote:
> introduced in kernel 3.9 CONFIG_ARM_VIRT_EXT is default for all V7 arm 
> cpu's. this is wrong and breaks smp support on BCM4708 for example.
> so keep it optional since no all v7 cpu's seem to support it. BCM4708 
> for instance is a arm cortex-a9. please merge this into one of the next 
> patches.

This was intentional, since ARM_VIRT_EXT shouldn't have any visible effect
when selected on CPUs without the virtualisation extensions.

If this is breaking SMP support, then there is a bug somewhere, so please
can elaborate on the problems which you are seeing?

Cheers,

Will
