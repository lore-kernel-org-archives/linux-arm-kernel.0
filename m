From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 11 Jul 2018 21:05:44 +0800
Subject: [PATCH] ARM: imx: call imx6sx_cpuidle_init() conditionally for
 6sll
In-Reply-To: <20180709155130.2126597-1-arnd@arndb.de>
References: <20180709155130.2126597-1-arnd@arndb.de>
Message-ID: <20180711130543.GI6959@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 05:51:17PM +0200, Arnd Bergmann wrote:
> The imx6sl platform has two different cpuidle implementations,
> and fails to link if we only want one of the two:
> 
> arch/arm/mach-imx/mach-imx6sl.o: In function `imx6sl_init_late':
> mach-imx6sl.c:(.init.text+0x12): undefined reference to `imx6sx_cpuidle_init'
> 
> This makes the call into reference conditional on the configuration.
> 
> Fixes: e7fa1fb39b11 ("ARM: imx: add cpu idle support for i.MX6SLL")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I had already sent a related patch earlier, but missed this second
> problem then.

Applied both, thanks.
