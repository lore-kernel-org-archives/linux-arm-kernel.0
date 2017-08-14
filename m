From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Aug 2017 11:52:18 +0100
Subject: [PATCH v5 2/6] ARM: smp_scu: add a helper for powering on a
 specific CPU
In-Reply-To: <20170728212138.12217-3-martin.blumenstingl@googlemail.com>
References: <20170728212138.12217-1-martin.blumenstingl@googlemail.com>
 <20170728212138.12217-3-martin.blumenstingl@googlemail.com>
Message-ID: <20170814105218.GG20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 11:21:34PM +0200, Martin Blumenstingl wrote:
> +/*
> + * Set the executing CPUs power mode to SCU_PM_NORMAL.
> + *
> + * This function must be called with preemption disabled, and as it
> + * has the side effect of disabling coherency, caches must have been
> + * flushed. Interrupts must also have been disabled.

This comment looks rather misleading for several reasons:

1. we're bringing another CPU to normal power mode, which means it's
   coming _into_ coherency, not leaving coherency, so "side effect of
   disabling coherency" is wrong.

2. what has the state of the _local_ CPUs caches got to do with the
   remote CPU when it isn't even powered up?

Could you please reword this comment to be more accurate please - I
think the paragraph can be removed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
