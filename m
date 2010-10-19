From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 19 Oct 2010 11:25:31 +0200
Subject: [PATCH v4] ARM: AT91: add board support for Pcontrol_G20
In-Reply-To: <20101014151451.GB23434@n2100.arm.linux.org.uk>
References: <1286466086.4306.41.camel@aspire.localdomain>
	<20101008123407.GB30252@game.jcrosoft.org>
	<1286550644.21584.34.camel@aspire.localdomain>
	<1286787761.7800.11.camel@aspire.localdomain>
	<1286792568.7800.19.camel@aspire.localdomain>
	<20101013131515.GC11087@game.jcrosoft.org>
	<1286979531.7165.9.camel@aspire.localdomain>
	<4CB71813.6060601@atmel.com>
	<20101014151451.GB23434@n2100.arm.linux.org.uk>
Message-ID: <4CBD640B.1050402@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 14/10/2010 17:14, Russell King - ARM Linux :
> On Thu, Oct 14, 2010 at 04:47:47PM +0200, Nicolas Ferre wrote:
>>> diff --git a/arch/arm/configs/pcontrol_g20_defconfig b/arch/arm/configs/pcontrol_g20_defconfig
>>> new file mode 100644
> 
> Is it really necessary to have another platform specific defconfig rather
> than grouping it together with other similar platforms?

Hi Russell,

Peter used the new defconfig infrastructure (which produces a reduced
defconfig) and we are working on merging board code as much as we can
(Cf. merging of 9g20ek and 9g20ek_2mmc).

So, maybe you can take this board support and we will try to share
defconfig per platform during .37 development cycle?


BTW, will I have to merge this change to conform with new "debug macro
infrastructure" ?

--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -314,8 +314,6 @@ static void __init pcontrol_g20_board_init(void)

 MACHINE_START(PCONTROL_G20, "PControl G20")
        /* Maintainer: pgsellmann at portner-elektronik.at */
-       .phys_io        = AT91_BASE_SYS,
-       .io_pg_offst    = (AT91_VA_BASE_SYS >> 18) & 0xfffc,
        .boot_params    = AT91_SDRAM_BASE + 0x100,
        .timer          = &at91sam926x_timer,
        .map_io         = pcontrol_g20_map_io,

Best regards,
-- 
Nicolas Ferre
