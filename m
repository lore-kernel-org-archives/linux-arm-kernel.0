From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jun 2014 15:06:22 +0100
Subject: [PATCHv3 1/5] arm64: add MIDR_EL1 field accessors
In-Reply-To: <20140627140155.GV26276@arm.com>
References: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
 <1403795926-17139-2-git-send-email-mark.rutland@arm.com>
 <20140627140155.GV26276@arm.com>
Message-ID: <20140627140622.GJ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 03:01:56PM +0100, Will Deacon wrote:
> On Thu, Jun 26, 2014 at 04:18:42PM +0100, Mark Rutland wrote:
> > The MIDR_EL1 register is composed of a number of bitfields, and uses of
> > the fields has so far involved open-coding of the shifts and masks
> > required.
> > 
> > This patch adds shifts and masks for each of the MIDR_EL1 subfields, and
> > also provides accessors built atop of these. Existing uses within
> > cputype.h are updated to use these accessors.
> > 
> > The read_cpuid_part_number macro is modified to return the extracted
> > bitfield rather than returning the value in-place with all other fields
> > (including revision) masked out, to better match the other accessors.
> > As the value is only used in comparison with the *_CPU_PART_* macros
> > which are similarly updated, and these values are never exposed to
> > userspace, this change should not affect any functionality.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> We need to make sure this doesn't conflict horribly with the missing arm64
> hunk from Russell's series in this area. Ideally, we'd take Russell's patch
> as part of this series.

The "missing arm64 hunk" was intentionally dropped as I couldn't see,
and still don't see a justification for it.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
