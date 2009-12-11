From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Dec 2009 23:28:38 +0000
Subject: GPIO support for HTC Dream
In-Reply-To: <20091211221015.GB24456@elf.ucw.cz>
References: <20091208102842.GH12264@elf.ucw.cz>
	<4B1EB57D.6070408@bluewatersys.com>
	<20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
Message-ID: <20091211232838.GE12628@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2009 at 11:10:15PM +0100, Pavel Machek wrote:
> +#include <linux/gpio.h>
...
> +#include <mach/gpio.h>
...
> +#include <asm/gpio.h>

Emm, this is getting really silly.

include/linux/gpio.h:
  
  #ifdef CONFIG_GENERIC_GPIO
  #include <asm/gpio.h>
  #else
  ...
  #endif

arch/arm/include/asm/gpio.h:

  #include <mach/gpio.h>

There really is no point in including mach/gpio.h nor asm/gpio.h when
linux/gpio.h will do.  I'm retiscent to add #warnings or #errors into
these files, but it seems that this is such a common thing that it may
be beneficial to do so.
