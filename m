From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 21 Jun 2010 14:55:30 +0200
Subject: [PATCH] AT91: PM: dual ram controller support
In-Reply-To: <1273492287-7647-1-git-send-email-nicolas.ferre@atmel.com>
References: <1273492287-7647-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4C1F6142.3050004@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/05/2010 13:51, Nicolas Ferre :
> This rework allows to address tow memory controllers. AT91SAM9263 and
> AT91SAM9G45 family have tow SDRAM or DDR/SDRAM controllers. Power management
> should take care of this.
> This patch modify the way RAM IP header files are implemented to allow
> access to registers of both controllers ; it also adds some macros.
> 
> We also modify the power management files to use those modified header files.
> Slow clock (assembly) and regular power management functions are synchronized
> for setting of RAM self-refresh procedure: 
> (lpr & ~AT91_DDRSDRC_LPCB) | AT91_DDRSDRC_LPCB_SELF_REFRESH

Queued as patch 6185/1 with Ack from Andrew Victor.

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6185/1

Best regards,
-- 
Nicolas Ferre
