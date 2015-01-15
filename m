From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Jan 2015 10:25:11 +0000
Subject: [PATCH v10] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <vnkwtwztp2rm.fsf@mitchelh-linux.qualcomm.com>
References: <1418687243-16395-1-git-send-email-mitchelh@codeaurora.org>
 <20141216094527.GC6580@arm.com>
 <vnkwtwztp2rm.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <20150115102511.GB23475@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 07:42:53PM +0000, Mitchel Humpherys wrote:
> On Tue, Dec 16 2014 at 01:45:27 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Dec 15, 2014 at 11:47:23PM +0000, Mitchel Humpherys wrote:
> >> From: Matt Wagantall <mattw@codeaurora.org>
> >> 
> >> It is sometimes necessary to poll a memory-mapped register until its value
> >> satisfies some condition. Introduce a family of convenience macros that do
> >> this. Tight-looping, sleeping, and timing out can all be accomplished using
> >> these macros.
> >> 
> >> Cc: Thierry Reding <thierry.reding@gmail.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Robert Elliott <elliott@hp.com>
> >> Signed-off-by: Matt Wagantall <mattw@codeaurora.org>
> >> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> >> ---
> >> v9..10:
> >>   - Actually added the comments mentioned in v8..v9 (doh!)
> >> 
> >> v8..v9:
> >>   - Added note in comments about max sleep time (Rob Elliott)
> >> 
> >> v7..v8:
> >>   - sorted helper macros by size (b, w, l, q)
> >>   - removed some of the more esoteric (or flat-out bogus) helper macros
> >> 
> >> This patch was originally part of a series [1] for adding support for IOMMU
> >> address translations through an ARM SMMU hardware register.  The other
> >> patch in the series (the one that actually uses these macros and implements
> >> said hardware address translations) was Ack'd by the driver maintainer
> >> there (Will Deacon) so I've pulled this patch out to avoid resending an
> >> already Ack'd patch over and over again.
> >> 
> >> In short, please see [1] for previous discussion and the first user of
> >> these macros.
> >> 
> >> Will also acked this patch in [2].  I didn't retain his Ack here because I
> >> added to the macro comments.
> >
> > You can keep the ack, it still looks good to me and I'm not really fussed
> > about the comments.
> >
> > Will
> 
> This hasn't gotten any further comments.  Would someone be willing to
> take it?

If you get an Ack from any of Arnd/Joerg/akpm then I'm happy to take it via
the arm-smmu pull (along with the patch making use of it).

Joerg, would you be ok with that?

Will

> Joerg, maybe you could take this through the IOMMU tree since the first
> user is an IOMMU driver?  Currently we can't move [1] forward because of
> this dependency...
> 
> [1] http://thread.gmane.org/gmane.linux.kernel.iommu/7837
> 
> 
> -Mitch
> 
> -- 
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
