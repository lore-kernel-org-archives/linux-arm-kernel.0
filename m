From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 14 Feb 2013 14:52:03 -0500
Subject: [PATCH] ARM: kirkwood: add missing include for nsa310
In-Reply-To: <1360850491-1463387-1-git-send-email-arnd@arndb.de>
References: <1360850491-1463387-1-git-send-email-arnd@arndb.de>
Message-ID: <20130214195203.GQ14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 03:01:30PM +0100, Arnd Bergmann wrote:
> Patch 92cb7625 "ARM: kirkwood: nsa310: cleanup includes and
> unneeded code" was a little too quick, since there is still
> an I2C_BOARD_INFO left in this file at the moment. Once
> that is gone and replaced by a DT description of the devices,
> the inclusion can be removed again
> 
> Without this patch, building kirkwood_defconfig results in:
> 
> arch/arm/mach-kirkwood/board-nsa310.c:42:74: error: array type has incomplete element type
> arch/arm/mach-kirkwood/board-nsa310.c:43:2: error: implicit declaration of function 'I2C_BOARD_INFO' [-Werror=implicit-function-declaration]
> arch/arm/mach-kirkwood/board-nsa310.c: In function 'nsa310_gpio_init':
> arch/arm/mach-kirkwood/board-nsa310.c:71:3: error: 'pm_power_off' undeclared (first use in this function)
> arch/arm/mach-kirkwood/board-nsa310.c:71:3: note: each undeclared identifier is reported only once for each function it appears in
> arch/arm/mach-kirkwood/board-nsa310.c: In function 'nsa310_init':
> arch/arm/mach-kirkwood/board-nsa310.c:83:2: error: implicit declaration of function 'i2c_register_board_info' [-Werror=implicit-function-declaration]
> arch/arm/mach-kirkwood/board-nsa310.c:83:121: error: negative width in bit-field '<anonymous>'
> arch/arm/mach-kirkwood/board-nsa310.c: At top level:
> arch/arm/mach-kirkwood/board-nsa310.c:42:74: warning: 'nsa310_i2c_info' defined but not used [-Wunused-variable]
> cc1: some warnings being treated as errors
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/mach-kirkwood/board-nsa310.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> 
> This file has been broken for a while in arm-soc,
> so I'm applying the obvious fix directly to the
> next/cleanup branch that introduced the problem.

Thanks, Arnd.

Jason.
