From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 22 Aug 2017 11:47:52 -0700
Subject: [PATCH v5] vfio: platform: reset: Add Broadcom FlexRM reset module
In-Reply-To: <1503396041-19485-2-git-send-email-anup.patel@broadcom.com>
References: <1503396041-19485-1-git-send-email-anup.patel@broadcom.com>
 <1503396041-19485-2-git-send-email-anup.patel@broadcom.com>
Message-ID: <ffcc2283-506f-6849-16e7-b0f0e618cd84@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anup,

We should add default (as below).


On 17-08-22 03:00 AM, Anup Patel wrote:
> This patch adds Broadcom FlexRM low-level reset for
> VFIO platform.
>
> It will do the following:
> 1. Disable/Deactivate each FlexRM ring
> 2. Flush each FlexRM ring
>
> The cleanup sequence for FlexRM rings is adapted from
> Broadcom FlexRM mailbox driver.
>
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Oza Oza <oza.oza@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   drivers/vfio/platform/reset/Kconfig                |   8 ++
>   drivers/vfio/platform/reset/Makefile               |   1 +
>   .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 100 +++++++++++++++++++++
>   3 files changed, 109 insertions(+)
>   create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
>
> diff --git a/drivers/vfio/platform/reset/Kconfig b/drivers/vfio/platform/reset/Kconfig
> index 70cccc5..8833805 100644
> --- a/drivers/vfio/platform/reset/Kconfig
> +++ b/drivers/vfio/platform/reset/Kconfig
> @@ -13,3 +13,11 @@ config VFIO_PLATFORM_AMDXGBE_RESET
>   	  Enables the VFIO platform driver to handle reset for AMD XGBE
>   
>   	  If you don't know what to do here, say N.
> +
> +config VFIO_PLATFORM_BCMFLEXRM_RESET
> +	tristate "VFIO support for Broadcom FlexRM reset"
> +	depends on VFIO_PLATFORM && (ARCH_BCM_IPROC || COMPILE_TEST)
default ARCH_BCM_IPROC
> +	help
> +	  Enables the VFIO platform driver to handle reset for Broadcom FlexRM
> +
> +	  If you don't know what to do here, say N.
>
