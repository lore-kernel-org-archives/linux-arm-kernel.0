From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 19 Mar 2014 15:39:00 -0400
Subject: [PATCH 27/62] ARM: orion5x: make dns323 independent of PHY support
In-Reply-To: <1395257399-359545-28-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-28-git-send-email-arnd@arndb.de>
Message-ID: <20140319193900.GU15608@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:29:24PM +0100, Arnd Bergmann wrote:
> The D-Link DNS-323 machine tries to unconditionally select CONFIG_PHYLIB,
> but that has other dependencies that might not necessarily be enabled,
> causing random build errors.
> 
> To work around this, this patch removes the 'select' statement and
> instead uses a compile-time check to skip the phy_register_fixup_for_uid()
> call if PHYLIB is not available in the kernel.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  arch/arm/mach-orion5x/Kconfig        | 1 -
>  arch/arm/mach-orion5x/dns323-setup.c | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
