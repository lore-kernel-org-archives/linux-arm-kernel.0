From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 15:38:33 -0700
Subject: [PATCH v4 0/5] Memory mapped architected timers
In-Reply-To: <20130724203253.GE27761@codeaurora.org>
References: <1374191972-18015-1-git-send-email-sboyd@codeaurora.org>
 <20130722170817.GB4833@e106331-lin.cambridge.arm.com>
 <20130724203253.GE27761@codeaurora.org>
Message-ID: <20130731223833.GJ8868@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24, Stephen Boyd wrote:
> On 07/22, Mark Rutland wrote:
> > Hi Stephen,
> > 
> > On Fri, Jul 19, 2013 at 12:59:27AM +0100, Stephen Boyd wrote:
> > > This patchset adds support for memory mapped architected timers. We
> > > don't have any other global broadcast timer in our system, so we use the
> > > mmio timer during low power modes. The first patch changes the register
> > > accessor to an enum per Thomas' request. The second patch is the binding.
> > > The next two patches lay some groundwork so that the last patch is simpler.
> > > The final patch adds support for mmio timers.
> > > 
> > > Patches are based on v3.11-rc1.
> > 
> > Be aware that as of v3.11-rc2 this doesn't cleanly apply, as the
> > __cpuinit removal broke the final patch's context in a couple of places.
> > It would be nice to get rid of the new cpuinit additions too...
> > 
> > With that cleaned up locally, I've gave this a spin on tc2 and a
> > Foundation model to test the cp15/system timers, hotplugging CPUs and
> > running a basic test (`time sleep 5`). That all seems to work.
> > 
> > Unfortunately I have no way of testing the memory-mapped timer support,
> > but I trust you've tested that locally.
> > 
> > For the series:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> 
> Thanks Mark.
> 
> Daniel, can you pick up these patches please?
> 

Ping Daniel?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
