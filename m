From: kevin.wells@nxp.com (Kevin Wells)
Date: Mon, 27 Feb 2012 20:16:45 +0100
Subject: [PATCH v2 0/6] ARM: LPC32xx: Patch set with further fixes for
 LPC32xx
In-Reply-To: <1330184118-10270-1-git-send-email-stigge@antcom.de>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
Message-ID: <083DF309106F364B939360100EC290F81F365B2AD8@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>This is another bundle of patches for LPC32xx, fixing bugs and completing
>support for drivers using the LPC32xx base port.
>
>It synchronizes changes from lpclinux.com to the mainline kernel and applies
>cleanly to 3.3-rc4.
>
>Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Kevin Wells <Kevin.wells@nxp.com>

>---
>
>Roland Stigge (6):
>  ARM: LPC32xx: Fix irq on GPI_28
>  ARM: LPC32xx: Fix missing and bad LPC32XX macros
>  ARM: LPC32xx: Fix interrupt controller init
>  ARM: LPC32xx: irq.c: Clear latched event
>  ARM: LPC32xx: serial.c: HW bug workaround
>  ARM: LPC32xx: serial.c: Fixed loop limit
>
> arch/arm/mach-lpc32xx/include/mach/irqs.h     |    2 -
> arch/arm/mach-lpc32xx/include/mach/platform.h |   51 +++++++++++++-------------
> arch/arm/mach-lpc32xx/irq.c                   |   25 ++++++++++--
> arch/arm/mach-lpc32xx/pm.c                    |    2 -
> arch/arm/mach-lpc32xx/serial.c                |   20 +++++++++-
> arch/arm/mach-lpc32xx/timer.c                 |   46 +++++++++++------------
> 6 files changed, 91 insertions(+), 55 deletions(-)
