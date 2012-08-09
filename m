From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 9 Aug 2012 23:53:26 +0530
Subject: [PATCH v2 06/10] ARM: davinci: don't use broken ntosd2_init_i2c
In-Reply-To: <201208090800.18321.arnd@arndb.de>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
 <1344461278-28245-7-git-send-email-arnd@arndb.de>
 <201208090800.18321.arnd@arndb.de>
Message-ID: <5024001E.3080803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 8/9/2012 1:30 PM, Arnd Bergmann wrote:
> On second thought, there is probably no use in keeping the broken function
> around, and we can just kill it off. If someone wants to add an i2c
> device to the bus, they can always add the init code back as well.
> 
> 8<-----
> Subject: ARM: davinci: don't use broken ntosd2_init_i2c
> 
> ntosd2_init_i2c walks the ntosd2_i2c_info array, which it expects to
> be populated with at least one member. gcc correctly warns about
> the out-of-bounds access here.
> 
> Since this can not possibly work, it's better to disable i2c
> support entirely on this board.
> 
> Without this patch, building davinci_all_defconfig results in:
> 
> arch/arm/mach-davinci/board-neuros-osd2.c: In function 'davinci_ntosd2_init':
> arch/arm/mach-davinci/board-neuros-osd2.c:187:20: warning: array subscript is above array bounds [-Warray-bounds]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Andrey Porodko <panda@chelcom.ru>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
