From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 07 Jul 2011 19:29:10 -0700
Subject: [RFC PATCH 17/17] ARM: kernel: save/restore build infrastructure
In-Reply-To: <1310053830-23779-18-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-18-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <4E166B76.7090901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
> This patch adds the required Kconfig and Makefile entries to
> enable and compile common idle code for ARM kernel.
>
> Common idle code depends on CPU_PM platform notifiers to trigger
> save/restore of kernel subsystems like PMU, VFP, GIC.
>
> Signed-off-by: Lorenzo Pieralisi<lorenzo.pieralisi@arm.com>
> ---
>   arch/arm/Kconfig         |   11 +++++++++++
>   arch/arm/kernel/Makefile |    4 ++++
>   2 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 356f266..5b670bd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1992,6 +1992,17 @@ config VFP
>
>   	  Say N if your target does not have VFP hardware.
>
> +config CONTEXT_SR

SR sounds cryptic. Also since it's PM related _PM_ would
be good.

> +	bool "Save/Restore code support for CPU/Cluster Power Management"
> +	depends on CPU_V7&&  CPU_PM
			^
space needed.

Regards
Santosh
