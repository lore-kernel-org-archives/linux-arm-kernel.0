From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Oct 2010 10:53:03 +0100
Subject: [PATCH 0/3] Add OMAP hardware spinlock misc driver
In-Reply-To: <1287531090.9245.139.camel@c-dwalke-linux.qualcomm.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287531090.9245.139.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20101020095303.GA21242@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 04:31:30PM -0700, Daniel Walker wrote:
> On Mon, 2010-10-18 at 09:44 +0200, Ohad Ben-Cohen wrote:
> > OMAP4 introduces a Spinlock hardware module, which provides hardware
> > assistance for synchronization and mutual exclusion between heterogeneous
> > processors and those not operating under a single, shared operating system
> > (e.g. OMAP4 has dual Cortex-A9, dual Cortex-M3 and a C64x+ DSP).
> > 
> > The intention of this hardware module is to allow remote processors,
> > that have no alternative mechanism to accomplish synchronization and mutual
> > exclusion operations, to share resources (such as memory and/or any other
> > hardware resource).
> > 
> > This patchset adds a new misc driver for this OMAP hwspinlock module.
> 
> Does this code interface with some hardware unit (other than the other
> processors) to accomplish this locking ?
> 
> The reason I ask is because MSM has similar code, and from what I can
> tell the MSM version has some structures in memory but that's all. It
> just operates on the structures in memory.
> 
> It might be worth looking over the two implementation so we aren't both
> remaking the wheel.

Ohad's message to which you replied had:

To: linux-omap at vger.kernel.org, linux-kernel at vger.kernel.org,
        linux-arm-kernel at lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Hari Kanigeri <h-kanigeri2@ti.com>,
        Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>,
        Greg KH <greg@kroah.com>, Grant Likely <grant.likely@secretlab.ca>,
        akpm at linux-foundation.org, Suman Anna <s-anna@ti.com>

Yours has:

To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Benoit Cousson <b-cousson@ti.com>,
        Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>,
        linux-kernel at vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>, mattw at codeaurora.org,
        akpm at linux-foundation.org, Suman Anna <s-anna@ti.com>,
        mattw at codeaurora.orgmattw, linux-arm-kernel at lists.infradead.org

which includes an invalid address "mattw at codeaurora.orgmattw".  Is there
a reason why you're excluding the linux-omap list from your message and
subsequent discussion?
