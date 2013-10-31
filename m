From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 14:10:43 +0800
Subject: [PATCHv2 3/7] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <1383023757-30711-4-git-send-email-gerg@uclinux.org>
References: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
 <1383023757-30711-4-git-send-email-gerg@uclinux.org>
Message-ID: <20131031061041.GC23549@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 03:15:53PM +1000, gerg at uclinux.org wrote:
> +DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
> +	.map_io		= mx53_map_io,
> +	.init_early	= imx53_init_early,
> +	.init_irq	= mx53_init_irq,
> +	.handle_irq	= imx53_handle_irq,
> +	.init_machine	= imx50_dt_init,
> +	.init_late	= imx53_init_late,
> +	.dt_compat	= imx50_dt_board_compat,
> +	.restart	= mxc_restart,
> +MACHINE_END

The imx53 is a platform that was converted from non-DT to DT.  Some of
these imx53 hooks may not even necessary for imx53 now, since imx53
supports DT boot only today.  So I do not prefer to reuse these imx53
hooks on the brand new imx50 DT machine.  I would suggest to maintain a
mach-imx50.c and machine descriptor for imx50 with only the necessary
hooks implemented as local functions inside mach-imx50.c.  After imx53
machine descriptor and hooks gets cleaned up, we can look at how we can
consolidate these descriptors if they are pretty much in common.

Shawn
