From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Jul 2014 20:03:27 -0400
Subject: [PATCH] ARM: mvebu: fix build without platforms selected
In-Reply-To: <7339332.ZE2mWIdyDh@wuerfel>
References: <7339332.ZE2mWIdyDh@wuerfel>
Message-ID: <20140725000327.GZ23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Wed, Jul 23, 2014 at 11:05:49PM +0200, Arnd Bergmann wrote:
> When building a multiplatform kernel that enables 'ARCH_MVEBU' but
> none of the individual options under it, we get this link error:
> 
> arch/arm/mach-mvebu/built-in.o: In function `mvebu_armada375_smp_wa_init':
> :(.text+0x190): undefined reference to `mvebu_setup_boot_addr_wa'
> 
> The best solution seems to be to ensure that in this configuration,
> we don't actually build any of the mvebu code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to mvebu/soc

thx,

Jason.
