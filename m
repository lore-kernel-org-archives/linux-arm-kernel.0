From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jun 2014 15:01:56 +0100
Subject: [PATCHv3 1/5] arm64: add MIDR_EL1 field accessors
In-Reply-To: <1403795926-17139-2-git-send-email-mark.rutland@arm.com>
References: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
 <1403795926-17139-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20140627140155.GV26276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 04:18:42PM +0100, Mark Rutland wrote:
> The MIDR_EL1 register is composed of a number of bitfields, and uses of
> the fields has so far involved open-coding of the shifts and masks
> required.
> 
> This patch adds shifts and masks for each of the MIDR_EL1 subfields, and
> also provides accessors built atop of these. Existing uses within
> cputype.h are updated to use these accessors.
> 
> The read_cpuid_part_number macro is modified to return the extracted
> bitfield rather than returning the value in-place with all other fields
> (including revision) masked out, to better match the other accessors.
> As the value is only used in comparison with the *_CPU_PART_* macros
> which are similarly updated, and these values are never exposed to
> userspace, this change should not affect any functionality.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

We need to make sure this doesn't conflict horribly with the missing arm64
hunk from Russell's series in this area. Ideally, we'd take Russell's patch
as part of this series.

Will
