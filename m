From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 17:39:54 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <4FB277E3.4020805@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB26E4B.4020609@codethink.co.uk> <20120515170020.23c68cac@skate>
 <4FB277E3.4020805@codethink.co.uk>
Message-ID: <20120515173954.18ba2250@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 16:36:03 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> I've tracked this down to the following:
> arch/arm/mach-armada/time.c
> 
>     190          } else {
>     191                  u32 clk;
>     192                  of_property_read_u32(np, "clock-frequency",
> &clk); 193                  WARN_ON(!clk);
> 
> The problem is the 'clk' variable is un-initialised and therefore
> the fact my device-tree is missing a clock-frequency property is
> causing the system to use what was in 'clk' which was around 16000
> from the stack.
> 
> I suggest that any property that is necessary to a unit operation
> should check that there was something to read. WARN_ON() is fine,
> but they you should not carry on and initialise the unit anyway.
> 
> I have now gone and fixed my .dts file and the system now gets to
> the point to try and mount an initrd.

Thanks for your report and investigation, you're obviously correct.
We'll fix that.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
