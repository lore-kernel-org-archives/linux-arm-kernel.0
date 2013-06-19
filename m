From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Jun 2013 19:29:04 +0200
Subject: [PATCH 1/6] ARM: add CPU_BE8_BOOT_LE configuration
In-Reply-To: <1371659404-20167-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1371659404-20167-1-git-send-email-ben.dooks@codethink.co.uk>
 <1371659404-20167-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130619192904.0375c15c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Wed, 19 Jun 2013 17:29:58 +0100, Ben Dooks wrote:

> +config CPU_BE8_BOOT_LE
> +	bool "Boot BE system from LE loader"
> +	depends on CPU_ENDIAN_BE8
> +	help
> +	  Support for running BE-8 (big-endian) from a boot environment that is
> +	  running in LE mode.
> +

I'm not sure to understand how this option articulates with the
CPU_ENDIAN_BE8 option, because your other patch series ("Initial
big-endian support series") in its PATCH 4 ("ARM: set BE8 if LE in head
code") already switches the kernel into BE mode even if it's booted
from a Little Endian bootloader.

Maybe what you wanted to achieve is:

 * The first patch series "Initial big-endian support series" allows to
   run the kernel big-endian if the bootloader has booted it big-endian.

 * The second patch series "ARM big-endian - atags and loader updates",
   allows to run the kernel big-endian even if the bootloader started
   it little-endian.

In this case, then the PATCH 4 of your first patch series ("ARM: set
BE8 if LE in head code") should be in the second patch series, and
the code be conditional under CPU_BE8_BOOT_LE.

Or maybe I'm missing something?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
