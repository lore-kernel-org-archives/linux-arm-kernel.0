From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 13 Feb 2015 19:19:28 +0100
Subject: [PATCH 0/7] ARM: berlin: refactor the clock
In-Reply-To: <20150213173121.GG26475@lunn.ch>
References: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150213173121.GG26475@lunn.ch>
Message-ID: <20150213191928.20f79ebf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 13 Feb 2015 18:31:21 +0100, Andrew Lunn wrote:

> Something which needs to be discussed for both this patchset and the
> previous one, is backwards compatibility of the device tree.
> 
> As far as i can see, these changes are not backwards compatible.
> Somebody trying to boot a new kernel with a old DT blob is going to
> have trouble.
> 
> How do we want to handle this?

I think one thing that should really be taken into account here is that
we have basically no usable datasheet for those SoCs. We only have very
partial datasheets, and only fairly a vendor kernel tree. This makes it
nearly impossible to have from the start up a clear picture of the
hardware layout and how it should be represented in the DT. Antoine,
and I guess Sebastian as well, are discovering progressively the layout
of the registers, their functionality, depending on the features that
are enabled.

The DT backward compatibility requirement essentially requires either:

 * A very clear picture of the hardware from the beginning, so that we
   can be pretty sure when designing the first DT binding, that it is
   going to be alright. This is clearly not something we have for the
   Marvell Berlin platforms.

 * Keep vast amount of legacy code to support old DTs, which nobody is
   every going to test, which means that such code is guaranteed to
   bitrot within 2 or 3 kernel releases, if not earlier.

Instead, since I believe at this point Marvell doesn't care about DT
backward compatibility for its platforms, could we instead declare the
DT bindings of this platform as "unstable", just like the AT91 guys did
for their DT bindings
(http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/arm/Atmel/README#n100) ?

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
