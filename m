From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Sep 2016 10:39:04 +0100
Subject: [PATCHv4] arm: l2x0: add PMU support
In-Reply-To: <20160901163802.ee39ea1a3c664fd182b97489@arm.com>
References: <1472653416-774-1-git-send-email-mark.rutland@arm.com>
 <20160901153706.GZ1041@n2100.armlinux.org.uk>
 <20160901163802.ee39ea1a3c664fd182b97489@arm.com>
Message-ID: <20160902093904.GA9261@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 04:38:02PM -0500, Kim Phillips wrote:
> On Thu, 1 Sep 2016 16:37:07 +0100
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> > On Wed, Aug 31, 2016 at 03:23:36PM +0100, Mark Rutland wrote:
> > > The L2C-220 (AKA L220) and L2C-310 (AKA PL310) cache controllers feature
> > > a Performance Monitoring Unit (PMU), which can be useful for tuning
> > > and/or debugging. This hardware is always present and the relevant
> > > registers are accessible to non-secure accesses. Thus, no special
> > > firmware interface is necessary.
> > > 
> > > This patch adds support for the PMU, plugging into the usual perf
> > > infrastructure. The overflow interrupt is not always available (e.g. on
> > > RealView PBX A9 it is not wired up at all), and the hardware counters
> > > saturate, so the driver does not make use of this. Instead, the driver
> > > periodically polls and reset counters as required to avoid losing
> > > events due to saturation.
> > > 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Acked-by: Pawel Moll <pawel.moll@arm.com>
> > > Cc: Kim Phillips <kim.phillips@arm.com>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > 
> > Much better, thanks.  When you're happy, please put it in the patch
> > system, thanks.
> 
> feel free to tack on my:
> 
> Tested-by: Kim Phillips <kim.phillips@arm.com>

Cheers!

I've folded that in, and dropped this in the patch system as 8611/1.

Thanks,
Mark.
