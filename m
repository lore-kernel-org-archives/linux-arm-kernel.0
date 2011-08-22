From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Aug 2011 09:17:49 +0100
Subject: 46dcfc8 (ARM: Update mach-types) removes used machine types
In-Reply-To: <20110822081000.GA16557@pengutronix.de>
References: <20110822081000.GA16557@pengutronix.de>
Message-ID: <20110822081748.GJ12028@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 10:10:00AM +0200, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> your commit 46dcfc8 that is in today's next among other changes does:
> 
> -eukrea_cpuimx25sd      MACH_EUKREA_CPUIMX25    EUKREA_CPUIMX25 2820
> -eukrea_cpuimx35sd      MACH_EUKREA_CPUIMX35    EUKREA_CPUIMX35 2821
> 
> These two are both marked as "mainlined" on
> http://www.arm.linux.org.uk/developer/machines/ and both are actually
> used (arch/arm/mach-imx/mach-{eukrea_cpuimx25,cpuimx35.c})
> 
> Can you please add them back? Maybe it's worth to double-check the other
> deletions?!

No.  They're removed because they're broken (look at them) - I've added
additional checks so I don't have to waste _significant_ time fixing
the entries time and time again.

The requirement is that the machine_is_xxx() must match the MACH_xxx
parts.  If they don't, they will not exist in future updates.
