From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 11:27:37 +0000
Subject: [PATCH V3 4/5] ARM: bcm2708: add stub clock driver
In-Reply-To: <1347423509-30647-4-git-send-email-swarren@wwwdotorg.org>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
 <1347423509-30647-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201209121127.37495.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 September 2012, Stephen Warren wrote:
> From: Simon Arlott <simon@fire.lp0.eu>
> 
> This patch adds a minimal stub clock driver for the BCM2708. Its sole
> purpose is to allow the PL011 AMBA clk_get() API calls to provide
> something that looks enough like a clock that the driver probes and
> operates correctly.
> 
> This patch was extracted from git://github.com/lp0/linux.git branch
> rpi-split as of 2012/09/08, and modified as follows:
> 
> * Modified .dev_id for UART clocks to match UART DT node names.
> 
> Signed-off-by: Chris Boot <bootc@bootc.net>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <dc4@broadcom.com>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> --
> v3: New patch.
> ---
>  arch/arm/mach-bcm2708/Makefile  |    1 +
>  arch/arm/mach-bcm2708/bcm2708.c |    3 +++
>  arch/arm/mach-bcm2708/clock.c   |   53 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-bcm2708/clock.h   |   24 ++++++++++++++++++
>  4 files changed, 81 insertions(+)
>  create mode 100644 arch/arm/mach-bcm2708/clock.c
>  create mode 100644 arch/arm/mach-bcm2708/clock.h

I think you should keep Mike on Cc for clock related patches. I also wonder
whether this file should go into drivers/clk right away, since that is where
it would end up when it grows into a full clock driver.

	Arnd
