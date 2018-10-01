From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Oct 2018 15:29:15 +0100
Subject: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
In-Reply-To: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20181001142914.GD9716@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ganapat,

On Mon, Oct 01, 2018 at 10:07:43AM +0000, Kulkarni, Ganapatrao wrote:
> Perf events L1-dcache-load-misses, L1-dcache-store-misses are mapped to
> armv8_pmuv3 (both DT and ACPI) event L1D_CACHE_REFILL. This is incorrect,
> since L1D_CACHE_REFILL counts both load and store misses.
> Similarly the events L1-dcache-loads, L1-dcache-stores, dTLB-load-misses
> and dTLB-loads are wrongly mapped. Hence Deleting all these cache events
> from armv8_pmuv3 cache mapping.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  arch/arm64/kernel/perf_event.c | 8 --------
>  1 file changed, 8 deletions(-)

The "generic" events are really implemented on a best-effort basis, as
they rarely tend to map exactly to what the hardware supports. I think
they originally stemmed from the x86 CPU PMU, but that doesn't really
help us.

I had a discussion with Ingo back when we originally implemented perf
because I actually preferred not to implement the generic events at all.
However, he was strongly of the opinion that a best-effort approach was
sufficient to get casual users going with the tool, so that's what we went
with.

Will
