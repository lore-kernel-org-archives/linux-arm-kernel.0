From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Sat, 3 Dec 2016 06:28:07 +0900
Subject: [PATCH 0/2] arm64: PMU: Sanitize usage of PMSELR_EL0.SEL
In-Reply-To: <1480693859-27249-1-git-send-email-marc.zyngier@arm.com>
References: <1480693859-27249-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <d27d50ad-c61e-28a6-c8e5-5714b1530c4d@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Successfully verified them on a Rev B0 CPU. Thank you for quickly 
providing the fix.

On 2016/12/03 0:50, Marc Zyngier wrote:
> An ugly interaction between the use of PMSELR_EL0 in a host kernel and
> the use of PMXEVCNTR_EL0 in a guest has recently come to light [1],
> leading to the guest taking an UNDEF exception in EL1 when using the
> PMU.
>
> The fix is pretty simple ("don't do that!"), making the PMU useable on
> X-Gene, which seems to have a stricter (but nonetheless valid)
> interpretation of the architecture.
>
> Patches against 4.9-rc6.
>
> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2016-November/022545.html
>
> Marc Zyngier (2):
>   arm64: PMU: Do not use PMSELR_EL0 to access PMCCFILTR_EL0
>   arm64: PMU: Reset PMSELR_EL0 to a sane value at boot time
>
>  arch/arm64/kernel/perf_event.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
