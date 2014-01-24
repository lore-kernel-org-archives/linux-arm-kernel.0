From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jan 2014 16:35:49 +0000
Subject: [PATCH v5 0/4] perf: AARCH64 arch support
In-Reply-To: <1390399879-5109-1-git-send-email-jean.pihet@linaro.org>
References: <1390399879-5109-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <20140124163548.GH31040@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Wed, Jan 22, 2014 at 02:11:15PM +0000, Jean Pihet wrote:
> Add AARCH64 specific support. This includes the following:
> - AARCH64 perf registers definition and hooks,
> - compat mode registers use, i.e. profiling a 32-bit binary on
>    a 64-bit system,
> - unwinding using the dwarf information from the .debug_frame
>    section of the ELF binary,
> - unwinding using the frame pointer information; in 64-bit and
>    compat modes.
> 
> Note: support for unwinding using the dwarf information in compat
> mode requires some changes to the libunwind code. Those changes
> have been submitted on the libunwind ML and are in discussion.
> 
> Tested on ARMv7, ARMv8 and x86_64 platforms. The compat mode has been
> tested on ARMv8 using statically built 32-bit binaries.

This is look alright to me now, but there are still two blockers:

 (1) Getting the libunwind code merged
 (2) Splitting this into an arch/arm64 series and a tools/perf series, so
     that acme can merge the latter independently (and avoid the mess we had
     last time).

Anyway, for the series:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
