From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 19 Mar 2014 15:37:40 -0400
Subject: [PATCH 26/62] ARM: mvebu: don't select CONFIG_NEON
In-Reply-To: <1395257399-359545-27-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-27-git-send-email-arnd@arndb.de>
Message-ID: <20140319193740.GT15608@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:29:23PM +0100, Arnd Bergmann wrote:
> CONFIG_NEON is meant to be user-selectable. Turning it on
> unconditionally means we can't build a smaller kernel when
> we don't need it, and causes build errors if CONFIG_VFP
> is not also enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

Gregory, Thomas, Ezequiel,

Care to spin a patch adding NEON to mvebu_v7_defconfig?  (If you want
it)

thx,

Jason.
