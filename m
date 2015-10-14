From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 Oct 2015 22:58:26 +0200
Subject: [PATCH 3/4] ARM: mvebu: remove the workaround imprecise abort
 fault handler
In-Reply-To: <1444834113-18122-4-git-send-email-l.stach@pengutronix.de>
References: <1444834113-18122-1-git-send-email-l.stach@pengutronix.de>
 <1444834113-18122-4-git-send-email-l.stach@pengutronix.de>
Message-ID: <20151014225826.28313016@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lucas,

On Wed, 14 Oct 2015 16:48:32 +0200, Lucas Stach wrote:
> This is not needed anymore. Handling a potentially pending imprecise external
> abort left behind by the bootloader is now done in a slightly safer way inside
> the common ARM startup code.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 35 -----------------------------------
>  1 file changed, 35 deletions(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

In fact this code is anyway no longer needed, since this workaround was
only needed for the Armada 375 Z1 stepping, which we no longer support
in mainline anyway.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
