From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Fri, 29 Jan 2016 17:37:36 +0100
Subject: [PATCH v3 06/12] acpi, numa: Enable ACPI based NUMA on ARM64
In-Reply-To: <1453541967-3744-7-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-7-git-send-email-guohanjun@huawei.com>
Message-ID: <20160129163736.GZ4914@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.01.16 17:39:21, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Add function needed for cpu to node mapping, and enable
> ACPI based NUMA for ARM64 in Kconfig
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/Kconfig |  2 +-
>  drivers/acpi/numa.c  | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h | 17 ++++++++++++++++-
>  3 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index d6d5749..31875ab 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -283,7 +283,7 @@ config ACPI_THERMAL
>  config ACPI_NUMA
>  	bool "NUMA support"
>  	depends on NUMA
> -	depends on (X86 || IA64)
> +	depends on (X86 || IA64 || ARM64)
>  	default y if IA64_GENERIC || IA64_SGI_SN2

This should be default enabled here for arm64 to have it enabled with
NUMA.

-Robert
