From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Feb 2012 14:04:05 +0000
Subject: [PATCH 1/2] ARM: EXYNOS: Add files about definition of C2C
In-Reply-To: <000501cce314$cf9fcff0$6edf6fd0$%lee@samsung.com>
References: <000501cce314$cf9fcff0$6edf6fd0$%lee@samsung.com>
Message-ID: <20120204140405.GW889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 04, 2012 at 05:13:00PM +0900, Kisang Lee wrote:
> Cc: Arnd Bergmann <arnd <at> arndb.de>
> Cc: Greg Kroah-Hartman <greg <at> kroah.com>
> 
> Following files are added for C2C driver
> c2c.h : Definition of C2C platform data and mode
> regs-c2c.h : Definition of C2C registers
> 
> Signed-off-by: Kisang Lee <kisang80.lee@samsung.com>
> ---
>  arch/arm/mach-exynos/include/mach/c2c.h      |   65 +++++++++++++++++++++++
>  arch/arm/mach-exynos/include/mach/regs-c2c.h |   71 ++++++++++++++++++++++++++

Does anything other than these two files (in your second patch):

 drivers/misc/c2c/samsung-c2c.c |  500 ++++++++++++++++++++++++++++++++++++++++
 drivers/misc/c2c/samsung-c2c.h |  300 ++++++++++++++++++++++++

use the regs-c2c.h file?  If not, it should be placed next to the
drivers itself, and not in some random include directory far
away from the drivers.
