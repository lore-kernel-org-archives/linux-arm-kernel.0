From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 22 Apr 2012 16:34:20 +0200
Subject: [PATCH] arm: at91: fix build-error for board-dt
In-Reply-To: <201204221339.18385.arnd@arndb.de>
References: <1335004105-3162-1-git-send-email-w.sang@pengutronix.de>
 <201204211839.15535.arnd@arndb.de>
 <20120422015059.GE9142@game.jcrosoft.org>
 <201204221339.18385.arnd@arndb.de>
Message-ID: <20120422143420.GA3942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> How about this patch for v3.4 then? It ensures that we don't try to build
> ARCH_AT91RM9200 or ARCH_AT91X40 with MACH_AT91SAM_DT, which would be broken
> in v3.4-rc4 as Wolfram pointed out.
> 
> 8<----
> ARM: at91: fix DT-enabled builds for non-DT chips
> 
> The ARCH_AT91RM9200 and ARCH_AT91X40 variants do not support booting with
> DT yet, so we must not let the user select MACH_AT91SAM_DT in order
> to avoid build errors.
> 
> It's still possible to enable USE_OF, and we should provide a few stub
> functions for that case for restart and clock_init.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks! In case it goes in:

Reported-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120422/638bd040/attachment.sig>
