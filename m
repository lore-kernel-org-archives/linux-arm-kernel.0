From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 16:39:29 +0200
Subject: [PATCH 2/3] edac: Add L3/SoC support to the APM X-Gene SoC EDAC
 driver
In-Reply-To: <1432937075-16558-3-git-send-email-lho@apm.com>
References: <1432937075-16558-1-git-send-email-lho@apm.com>
 <1432937075-16558-2-git-send-email-lho@apm.com>
 <1432937075-16558-3-git-send-email-lho@apm.com>
Message-ID: <1979546.jtvJnZomID@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 May 2015 16:04:34 Loc Ho wrote:
> +static void xgene_edac_soc_check(struct edac_device_ctl_info *edac_dev)
> +{
> +       struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +       static const char * const mem_err_ip[] = {
> +               "10GbE0",
> +               "10GbE1",
> +               "Security",
> +               "SATA45",
> +               "SATA23/ETH23",
> +               "SATA01/ETH01",
> +               "USB1",
> +               "USB0",
> +               "QML",
> +               "QM0",
> +               "QM1 (XGbE01)",
> +               "PCIE4",

This list seems a little too hardware specific, I'd assume that the numbers
get a different meaning with the xgene2.
	Arnd
