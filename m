From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 31 Dec 2012 13:57:28 +0530
Subject: [PATCH 1/3] ARM: OMAP2xxx: PM: enter WFI via inline asm if CORE
 stays active
In-Reply-To: <20121230182826.30526.27155.stgit@dusk.lan>
References: <20121230182745.30526.47072.stgit@dusk.lan>
 <20121230182826.30526.27155.stgit@dusk.lan>
Message-ID: <50E14C70.2090700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 30 December 2012 11:58 PM, Paul Walmsley wrote:
> There shouldn't be any need to jump to SRAM code if the OMAP CORE
> clockdomain (and consequently the SDRAM controller and CORE PLL) stays
> active during MPU WFI.  The SRAM code should only be needed when the RAM
> enters self-refresh.  So in the case where CORE stays active, just call
> WFI directly from the mach-omap2/pm24xx.c code.  This removes some
> unnecessary SRAM code.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Richard Woodruff <r-woodruff2@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
This sounds correct to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
