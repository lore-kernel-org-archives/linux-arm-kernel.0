From: alex@digriz.org.uk (Alexander Clouter)
Date: Fri, 4 Dec 2009 10:28:21 +0000
Subject: [PATCH 1/2] ep93xx: implemented watchdog timer driver for TS-72xx
	SBCs
References: <cover.1259866661.git.mika.westerberg@iki.fi>
	<3518ebf38d7a0038262cd20beb5283198e99e22e.1259866661.git.mika.westerberg@iki.fi>
Message-ID: <5r4nu6-pia.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mika Westerberg <mika.westerberg@iki.fi> wrote:
>
> Technologic Systems TS-72xx SBCs have external glue logic
> CPLD which includes watchdog timer. This driver implements
> kernel support for that.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
> drivers/watchdog/Kconfig      |   11 +
> drivers/watchdog/Makefile     |    1 +
> drivers/watchdog/ts72xx_wdt.c |  458 +++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 470 insertions(+), 0 deletions(-)
> create mode 100644 drivers/watchdog/ts72xx_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3711b88..5204612 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -289,6 +289,17 @@ config ADX_WATCHDOG
>          Say Y here if you want support for the watchdog timer on Avionic
>          Design Xanthos boards.
> 
> +config TS72XX_WATCHDOG
> +       tristate "TS-72XX SBC Watchdog"
> +       depends on MACH_TS72XX
> +       help
> +         Technologic Systems TS-7200, TS-7250 and TS-7260 boards have
> +         watchdog timer implemented in a external CPLD chip. Say Y here
> +         if you want to support for the watchdog timer on TS-72XX boards.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called ts72xx_wdt.
> +
> # AVR32 Architecture
>
....and also on the TS-78XX boards.  Although my TS-7800 board is being 
neglected at the moment it would be great if you could replace 
everywhere you put ts72xx with ts7xxx and such.  Means when I add the 
platform hooks for the TS-78xx I do not have to submit a patch that is a 
rather intrusive rename/relabelling one.

Cheers

-- 
Alexander Clouter
.sigmonster says: Monday is an awful way to spend one seventh of your life.
