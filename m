From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 15 May 2012 10:32:01 +0100 (BST)
Subject: [GIT PULL][for 3.5] pull request of board-specific branch in
 arch-pxa git tree
In-Reply-To: <201205150925.17477.arnd@arndb.de>
Message-ID: <1337074321.33676.YahooMailClassic@web29011.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

--- On Tue, 15/5/12, Arnd Bergmann <arnd@arndb.de> wrote:
> The last patch in this series causes a build error with
> magician_defconfig:
> 
> /home/arnd/linux-arm/arch/arm/mach-pxa/hx4700.c:298:2:
> error: unknown field 'clock_rate' specified in initializer
> /home/arnd/linux-arm/arch/arm/mach-pxa/hx4700.c:298:2:
> error: initialization makes pointer from integer without a
> cast [-Werror]
> /home/arnd/linux-arm/arch/arm/mach-pxa/hx4700.c:298:2:
> error: (near initialization for 'asic3_platform_data.leds')
> [-Werror]
> cc1: all warnings being treated as errors
> make[2]: *** [arch/arm/mach-pxa/hx4700.o] Error 1
> make[1]: *** [arch/arm/mach-pxa] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
> 
> Did you miss a dependency? Should I revert that patch for
> now?

hx4700.c expects to find the clock_rate field in the
asic3_platform_data structure.

The clock_rate field is due to be added in V3.5:

http://lkml.indiana.edu/hypermail/linux/kernel/1204.2/00339.html

Regards,
Paul
