From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jun 2016 12:14:49 +0100
Subject: [PATCH 2/8] arm64: pmu: Probe default hw/cache counters
In-Reply-To: <1465511013-10742-3-git-send-email-jeremy.linton@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-3-git-send-email-jeremy.linton@arm.com>
Message-ID: <20160615111449.GH24029@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 05:23:27PM -0500, Jeremy Linton wrote:
> ARMv8 machines can identify the micro/arch defined counters
> that are available on a machine. Add all these counters to the
> default armv8 perf map. At run-time disable the counters which
> are not available on the given PMU.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 45 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 917c3e2..e1a3bce 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -190,13 +190,23 @@
>  #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED

Minus the last hunk (which I mentioned in the previous patch):

Acked-by: Will Deacon <will.deacon@arm.com>

Will
