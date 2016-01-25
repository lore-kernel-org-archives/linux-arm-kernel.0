From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 25 Jan 2016 21:09:16 +0200
Subject: [PATCH] clocksource: select CLKSRC_MMIO where needed
In-Reply-To: <1453737776-1960372-1-git-send-email-arnd@arndb.de>
References: <1453737776-1960372-1-git-send-email-arnd@arndb.de>
Message-ID: <20160125190916.GO2916@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jan 25, 2016 at 05:02:49PM +0100, Arnd Bergmann wrote:
> The Tegra clocksource implementation uses the clocksource_mmio helper
> functions, but currently can be configured without them, which fails:
> 
> drivers/clocksource/built-in.o: In function `tegra20_init_timer':
> :(.init.text+0xac): undefined reference to `clocksource_mmio_init'
> :(.init.text+0x140): undefined reference to `clocksource_mmio_readl_up'
> 
> The same problem exists for Digicolor:
> 
> drivers/clocksource/built-in.o: In function `digicolor_timer_init':
> :(.init.text+0xfa): undefined reference to `clocksource_mmio_init'
> :(.init.text+0x14c): undefined reference to `clocksource_mmio_readl_down'
> 
> I've inspected the Kconfig file to look for other cases that I have not
> yet run into, and added an explicit 'select' to each one to ensure we
> can successfully link the drivers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For Digicolor:

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
