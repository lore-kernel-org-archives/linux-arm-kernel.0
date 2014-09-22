From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Sep 2014 16:39:19 +0100
Subject: [PATCH v2 0/3] arm_arch_timer: VDSO preparation, code
 consolidation
In-Reply-To: <1411052390-27238-1-git-send-email-nathan_lynch@mentor.com>
References: <1411052390-27238-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140922153919.GQ25809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 03:59:32PM +0100, Nathan Lynch wrote:
> This series contains the necessary changes to allow architected timer
> access from user-space on 32-bit ARM.  This allows the VDSO to support
> high resolution timestamps for clock_gettime and gettimeofday.  This
> also merges substantially similar code from arm and arm64 into the
> core arm_arch_timer driver.
> 
> The functional changes are:
> - When available, CNTVCT is made readable by user space on arm, as it
>   is on arm64.
> - The clocksource name becomes "arch_mem_counter" if CP15 access to
>   the counter is not available.
> 
> These changes have been carried as part of the ARM VDSO patch set over
> the last several months, but I am splitting them out here as I assume
> they should go through the clocksource maintainers.

For the series:

  Acked-by: Will Deacon <will.deacon@arm.com>

I'm not sure which tree the arch-timer stuff usually goes through, but
the arm/arm64 bits look fine so I'm happy for them to merged together.

Will
