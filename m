From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 8 Aug 2013 10:05:37 +0200
Subject: [PATCH 0/5] Armada 370/XP clocksource fixes
In-Reply-To: <20130808071206.GA29815@lunn.ch>
References: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130808071206.GA29815@lunn.ch>
Message-ID: <20130808100537.3d8e0980@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 8 Aug 2013 09:12:06 +0200, Andrew Lunn wrote:
> On Wed, Aug 07, 2013 at 08:52:31PM -0300, Ezequiel Garcia wrote:
> > This small patchset fixes a somewhat minor issue found in the clocksource
> > driver for Armada 370/XP SoC.
> > 
> > The Armada 370 SoC has no 25 MHz fixed timer, while the Armada XP SoC cannot
> > work properly without such 25 MHz fixed timer selected.
> 
> Hi Ezequiel
> 
> Is the XP case a silicon bug, or a design feature? If its a silicon
> bug, is it likely to be fixed in later steppings of the SOCs? If this
> feature is to come back, might we want to keep the property?

My understanding is that it's a design feature. Using the non-25 Mhz
timer leads to using a clocksource whose frequency varies when doing
cpufreq frequency changes, which isn't nice to handle. The fixed 25
Mhz was added in Armada XP to solve this problem, as far as I
understood.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
