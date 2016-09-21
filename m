From: rric@kernel.org (Robert Richter)
Date: Wed, 21 Sep 2016 08:55:08 +0200
Subject: [PATCH] arm64: Call numa_store_cpu_info() earlier.
In-Reply-To: <1474397195-16520-1-git-send-email-ddaney.cavm@gmail.com>
References: <1474397195-16520-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160921065508.GS25086@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.09.16 11:46:35, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
...
> Fix by moving call to numa_store_cpu_info() for all CPUs into
> smp_prepare_cpus(), which happens before wq_numa_init().  Since
> smp_store_cpu_info() now contains only a single function call,
> simplify by removing the function and out-lining its contents.
> 
> Suggested-by: Robert Richter <rric@kernel.org>
> fixes: 1a2db300348b ("arm64, numa: Add NUMA support for arm64 platforms.")
> Cc: <stable@vger.kernel.org> # 4.7.x-
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/arm64/kernel/smp.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Looks good, your version properly initializes the boot cpu that was
missing in my version.

Reviewed-by: Robert Richter <rrichter@cavium.com>
