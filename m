From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 30 May 2014 13:39:57 +0200
Subject: [PATCH] ARM: EXYNOS: Fix core ID used by platsmp and hotplug code
In-Reply-To: <1400858430-4278-1-git-send-email-t.figa@samsung.com>
References: <1400858430-4278-1-git-send-email-t.figa@samsung.com>
Message-ID: <53886E0D.3050804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23.05.2014 17:20, Tomasz Figa wrote:
> When CPU topology is specified in device tree, cpu_logical_map() does
> not return core ID anymore, but rather full MPIDR value. This breaks
> existing calculation of PMU register offsets on Exynos SoCs.
> 
> This patch fixes the problem by adjusting the code to use only core ID
> bits of the value returned by cpu_logical_map() to allow CPU topology to
> be specified in device tree on Exynos SoCs.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/hotplug.c | 10 ++++++----
>  arch/arm/mach-exynos/platsmp.c | 34 +++++++++++++++++++---------------
>  2 files changed, 25 insertions(+), 19 deletions(-)

Ping.

Best regards,
Tomasz
