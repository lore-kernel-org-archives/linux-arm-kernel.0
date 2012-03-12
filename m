From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 12 Mar 2012 20:46:23 +0000
Subject: [PATCH] ARM: davinci: DA850: move da850_register_pm to .init.text
In-Reply-To: <1331157836-30527-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1331157836-30527-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317F2EA8@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Mar 08, 2012 at 03:33:56, Uwe Kleine-K?nig wrote:
> All callers (board-mityomapl138.c and board-da850-evm.c) use it in
> __init functions only.
> 
> This fixes:
> 
> 	WARNING: vmlinux.o(.text+0xd664): Section mismatch in reference from the function da850_register_pm() to the function .init.text:da8xx_get_mem_ctlr()
> 	The function da850_register_pm() references
> 	the function __init da8xx_get_mem_ctlr().
> 	This is often because da850_register_pm lacks a __init
> 	annotation or the annotation of da8xx_get_mem_ctlr is wrong.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applying this, thanks.

Regards,
Sekhar
