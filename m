From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 5 Oct 2018 18:26:29 +0200
Subject: [PATCH] ARM: orion: avoid VLA in orion_mpp_conf
In-Reply-To: <20181005161601.875388-1-arnd@arndb.de>
References: <20181005161601.875388-1-arnd@arndb.de>
Message-ID: <20181005162629.GJ4730@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 06:15:49PM +0200, Arnd Bergmann wrote:
> Testing randconfig builds found an instance of a VLA that was
> missed when determining that we have removed them all:
> 
> arch/arm/plat-orion/mpp.c: In function 'orion_mpp_conf':
> arch/arm/plat-orion/mpp.c:31:2: error: ISO C90 forbids variable length array 'mpp_ctrl' [-Werror=vla]
> 
> This one is fairly straightforward: we know what all three
> callers are, and the maximum length is not very long.
> 
> Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Hi Arnd

Do you want this to go via the mvebu tree? Or you can take it direct
into arm-soc. There have not been any patches to orion5x, dove or
mv78xx0 for a long time, so there won't be any merge conflicts.

Thanks

    Andrew
