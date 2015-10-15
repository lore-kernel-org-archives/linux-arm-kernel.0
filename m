From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 15 Oct 2015 13:41:57 -0700
Subject: [PATCH v3 04/10] clk: nsp: add clock support for Broadcom
 Northstar Plus SoC
In-Reply-To: <1444938513-10758-5-git-send-email-jonmason@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-5-git-send-email-jonmason@broadcom.com>
Message-ID: <56200F95.3040902@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon,

Review below.

On 15-10-15 12:48 PM, Jon Mason wrote:
> The Broadcom Northstar Plus SoC is architected under the iProc

Based on changes in Makefile below - should this be for Northstar and 
Northstar Plus?

> architecture. It has the following PLLs: ARMPLL, GENPLL, LCPLL0, all
> derived from an onboard crystal.
>
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---
>   drivers/clk/bcm/Makefile            |   2 +
>   drivers/clk/bcm/clk-nsp.c           | 135 ++++++++++++++++++++++++++++++++++++
>   include/dt-bindings/clock/bcm-nsp.h |  51 ++++++++++++++
>   3 files changed, 188 insertions(+)
>   create mode 100644 drivers/clk/bcm/clk-nsp.c
>   create mode 100644 include/dt-bindings/clock/bcm-nsp.h
>
> diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
> index 8a7a477..e258b28 100644
> --- a/drivers/clk/bcm/Makefile
> +++ b/drivers/clk/bcm/Makefile
> @@ -4,3 +4,5 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
>   obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
>   obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
>   obj-$(CONFIG_ARCH_BCM_CYGNUS)	+= clk-cygnus.o
> +obj-$(CONFIG_ARCH_BCM_NSP)	+= clk-nsp.o
> +obj-$(CONFIG_ARCH_BCM_5301X)	+= clk-nsp.o
