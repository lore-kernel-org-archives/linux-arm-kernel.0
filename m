From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Aug 2012 16:36:55 +0100
Subject: [PATCH 3/6] ARM: sa1100: include asm/io.h in hackkit leds code
In-Reply-To: <1344430493-5304-4-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
 <1344430493-5304-4-git-send-email-arnd@arndb.de>
Message-ID: <20120808153655.GN18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 02:54:50PM +0200, Arnd Bergmann wrote:
> The sa1100 definition of the io_p2v macro has changed in v3.6, and this one
> file stopped working because of that.
> 
> Without this patch, building hackkit_defconfig results in:
> 
> arch/arm/mach-sa1100/leds-hackkit.c: In function 'hackkit_leds_event':
> arch/arm/mach-sa1100/leds-hackkit.c:39:4: error: implicit declaration of function 'IOMEM' [-Werror=implicit-function-declaration]

NAK.  Should be linux/io.h
