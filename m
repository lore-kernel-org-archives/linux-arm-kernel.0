From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 9 Jul 2010 14:19:03 -0700
Subject: [PATCH 2/3] sdhci-s3c: add support for the non standard minimal
	clock value
In-Reply-To: <1276670996-17729-3-git-send-email-m.szyprowski@samsung.com>
References: <1276670996-17729-1-git-send-email-m.szyprowski@samsung.com>
	<1276670996-17729-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100709141903.d883ad05.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Jun 2010 08:49:55 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> S3C SDHCI host controller can change the source for generating mmc clock.
> By default host bus clock is used, what causes some problems on machines
> with 133MHz bus, because the SDHCI divider cannot be as high get proper
> clock value for identification mode. This is not a problem for the
> controller, because it can generate lower frequencies from other clock
> sources. This patch adds a new quirk to SDHCI driver to calculate the
> minimal supported clock frequency.
> 
> This fixes the flood of the following warnings on Samsung S5PV210 SoCs:
> mmc0: Minimum clock frequency too high for identification mode
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c |    1 +
>  drivers/mmc/host/sdhci-s3c.c      |   29 +++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c          |    2 +-
>  drivers/mmc/host/sdhci.h          |    2 ++
>  4 files changed, 33 insertions(+), 1 deletions(-)

This patch doesn't know about Anton's
sdhci-pltfm-add-support-for-cns3xxx-soc-devices.patch.  Please check my fixup:

--- a/drivers/mmc/host/sdhci-cns3xxx.c~sdhci-s3c-add-support-for-the-non-standard-minimal-clock-value-fix
+++ a/drivers/mmc/host/sdhci-cns3xxx.c
@@ -93,5 +93,6 @@ struct sdhci_pltfm_data sdhci_cns3xxx_pd
 		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
 		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		  SDHCI_QUIRK_NONSTANDARD_MINCLOCK |
 		  SDHCI_QUIRK_NONSTANDARD_CLOCK,
 };
