From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Dec 2011 12:32:44 +0000
Subject: [linux-next] make  s5p64x0_defconfig build error
In-Reply-To: <1323838630.18517.1.camel@phoenix>
References: <1323838630.18517.1.camel@phoenix>
Message-ID: <20111214123244.GE7122@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 04:57:10AM +0000, Axel Lin wrote:
> I got below build error on linux-next 20111213.
> 
>   CC      arch/arm/kernel/process.o
> In file included from arch/arm/mach-s5p64x0/include/mach/system.h:16,
>                  from arch/arm/kernel/process.c:64:
> arch/arm/plat-samsung/include/plat/system-reset.h:19:2: error: #error Fix me up
> make[1]: *** [arch/arm/kernel/process.o] Error 1
> make: *** [arch/arm/kernel] Error 2

The clue is in the commit message:

commit d0f7e2beabe6a116152ccc31959b6654b6ef0071
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Tue Dec 6 12:57:02 2011 +0000

    ARM: restart: Temporary #error to persuade platform maintainers to take the restart changes seriously

    Force builds to fail to ensure that platform maintainers take the
    restart changes seriously, and sort out fixing their code before the
    next merge window.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>


Will
