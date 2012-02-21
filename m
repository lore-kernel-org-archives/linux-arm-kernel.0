From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2012 15:19:10 +0000
Subject: [PATCH] ARM: perf: do not handle deleted counter in irq handler
 to avoid oops
In-Reply-To: <CACVXFVMxpRDsG_hNn_WaX17uEdZCJmcraOvDwCL6JQ7Xyz5nig@mail.gmail.com>
References: <1329799058-27082-1-git-send-email-tom.leiming@gmail.com>
 <20120221133228.GK19696@mudshark.cambridge.arm.com>
 <CACVXFVMxpRDsG_hNn_WaX17uEdZCJmcraOvDwCL6JQ7Xyz5nig@mail.gmail.com>
Message-ID: <20120221151909.GA23133@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 02:02:32PM +0000, Ming Lei wrote:
> On Tue, Feb 21, 2012 at 9:32 PM, Will Deacon <will.deacon@arm.com> wrote:
> > I have a couple of patches that solve this by (a) clearing the overflow flag
> > when disabling the counter for ARMv7 and (b) adding the event checks to the
> 
> Maybe ARMv6 and xscale need to be fixed too if the overflow flag will be kept
> even after the counter is disabled.

I don't think so - seems like we clear the overflow flag already for those
PMUs in the disable path (note that we write ~mask).

Will
