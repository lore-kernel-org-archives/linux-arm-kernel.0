From: sid@reserved-bit.com (Siddhesh Poyarekar)
Date: Thu, 28 Jan 2016 23:14:28 +0530
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <20160128172705.GC20099@e104818-lin.cambridge.arm.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
 <20160126160257.GB28238@arm.com> <56A79D17.2000009@arm.com>
 <20160126165538.GC22776@devel.intra.reserved-bit.com>
 <20160128160747.GN775@arm.com>
 <20160128164631.GC17552@devel.intra.reserved-bit.com>
 <20160128172705.GC20099@e104818-lin.cambridge.arm.com>
Message-ID: <20160128174428.GD17552@devel.intra.reserved-bit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 05:27:05PM +0000, Catalin Marinas wrote:
> Suzuki's MRS emulation only exposes the CPU feature registers and not
> the MIDR. So this would help with choosing implementation based on
> features (e.g. crypto) but not for micro-architecture tuning.

Umm, I'm pretty sure it does, at least the patchset I tested back in
October did.  I think you may be confusing with revidr.

> I don't think you would get such assurance. Basically how the CPUs are
> connected on a system is the property of a SoC and not of the CPU (nor
> MIDR). I know it's not helpful but we don't really have an option (other
> than using made-up MIDR values with some reserved vendor id field and a
> central, OS-agnostic database to describe the real MIDRs).

... which means we would end up traversing all of /sysfs and/or check
CPU feature registers for this information, which makes a more optimal
API even more important.

> So are you only interested in MIDR for microarchitecture tuning? Would
> glibc make any use of the feature registers exposed via MRS emulation
> (and so far mirrored by HWCAP bits, well, as long as we can still do
> this sanely)?

My primary interest is exploring the ability to identify CPUs of
specific vendors (and specific make/models) based on their MIDR.
However, we would definitely also like to use the CPU feature bits to
enhance specific parts of glibc, like vectorized string/memory
routines for processors that support them.

Siddhesh
