From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Oct 2013 14:50:48 +0200
Subject: [RESEND PATCHv2 1/3] arm: socfpga: Set the SDMMC clock phase in
 system manager
In-Reply-To: <1381780051-1826-1-git-send-email-dinguyen@altera.com>
References: <1381780051-1826-1-git-send-email-dinguyen@altera.com>
Message-ID: <201310151450.48650.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 October 2013, dinguyen at altera.com wrote:
> +void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(u32 drvsel, u32 smplsel)
> +{
> +       u32 hs_timing;
> +
> +       hs_timing = SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel);
> +       writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
> +}
> +EXPORT_SYMBOL(socfpga_sysmgr_set_dwmmc_drvsel_smpsel);

This looks like the wrong approach. What are you trying to do? If you want to
set a clock, please use the clk API.

	Arnd
