From: ddaney@caviumnetworks.com (David Daney)
Date: Fri, 29 Jan 2016 09:01:06 -0800
Subject: [PATCH v2 5/5] arm64/perf: Extend event mask for ARMv8.1
In-Reply-To: <7944f006c35daeae9eb94fadb5c2bac1540ae050.1454054112.git.jglauber@cavium.com>
References: <6251e3377ca5d109c1a38ecc07fed50d6cbf5c61.1453992560.git.jglauber@cavium.com>
 <7944f006c35daeae9eb94fadb5c2bac1540ae050.1454054112.git.jglauber@cavium.com>
Message-ID: <56AB9AD2.8080903@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jan,

There was already a "[PATCH v2 5/5]" that differs from this one.

Perhaps you should resend the entire patch set and mark it v3.

Thanks,
David Daney


On 01/29/2016 12:29 AM, Jan Glauber wrote:
> ARMv8.1 increases the PMU event number space. Detect the
> presence of this PMUv3 type and extend the event mask.
>
> The event mask is moved to struct arm_pmu so different event masks
> can exist, depending on the PMU type.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>   arch/arm/kernel/perf_event_v6.c     |  6 ++++--
>   arch/arm/kernel/perf_event_v7.c     | 29 +++++++++++++++++++----------
>   arch/arm/kernel/perf_event_xscale.c |  4 +++-
>   arch/arm64/kernel/perf_event.c      | 33 +++++++++++++++++++--------------
>   drivers/perf/arm_pmu.c              |  5 +++--
>   include/linux/perf/arm_pmu.h        |  4 ++--
>   6 files changed, 50 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
> index 09413e7..d6769f5 100644
