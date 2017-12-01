From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Dec 2017 14:04:06 +0000
Subject: [PATCH v2 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
Message-ID: <20171201140406.oanuaz6zvyrhp4ml@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Nov 30, 2017 at 04:39:28PM +0000, Will Deacon wrote:
> Hi again,
> 
> This is version two of the patches previously posted here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/542751.html
> 
> Changes since v1 include:
> 
>   * Based on v4.15-rc1
>   * Trampoline moved into FIXMAP area
>   * Explicit static key replaced by cpu cap
>   * Disable SPE for userspace profiling if kernel unmapped at EL0
>   * Changed polarity of cpu feature to match config option
>   * Changed command-line option so we can force on in future if necessary
>   * Changed Falkor workaround to invalidate different page within 2MB region
>   * Reworked alternative sequences in entry.S, since the NOP slides with
>     kaiser=off were measurable

This generally looks good to me.

For patches patches 1-10, 13-15, and 17, feel free to add:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

(assuming you fix up the issue Robin spotted on patch 14).

Thanks,
Mark.
