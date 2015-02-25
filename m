From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Feb 2015 17:18:36 +0100
Subject: [PATCH v4] ARM: multi_v7_defconfig: Enable shmobile platforms
In-Reply-To: <1424787285-31177-1-git-send-email-geert+renesas@glider.be>
References: <1424787285-31177-1-git-send-email-geert+renesas@glider.be>
Message-ID: <2701175.enxAKM7Ysp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 15:14:45 Geert Uytterhoeven wrote:
> Enable support for shmobile platforms that became multi-platform aware.
> Several non-critical drivers and subsystems are built as modules, to keep
> kernel size reasonable.
> 
> Tested on:
>   - r8a73a4/ape6evm:
>       - U-Boot fails with "Error: unrecognized/unsupported machine ID",
>       - kexec works.
>   - r8a7740/armadillo:
>       - Hermit boot loader fails (larger image, more memory corruption),
>       - kexec works.
>   - r8a7791/koelsch,
>   - sh73a0/kzm9g:
>       - zImage+DTB from U-Boot needs CONFIG_ARM_ATAG_DTB_COMPAT=n,
>       - kexec works.
>   - am335x/boneblack.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Many thanks for applying!
> 
> v4:
>   - Add Acked-by,
>   - Enable R-Mobile reset driver (for r8a73a4/r8a7740/sh73a0),
>   - Add r8a73a4/ape6evm, as it became multi-platform aware,
>   - Drop useless SERIAL_8250_EXTENDED=y,
>   - Make lots of new (and only new) stuff modular:
>       - media,
>       - RTC,
>       - USB (except for USB_GADGET, as that would affect USB_CHIPIDEA),
>       - accelerometer,
>       - i2c host drivers for buses with devices that have modular or no
> 	drivers.
>     This saves ca. 256 KiB according to bloat-o-meter.
> 

Nice!

Should we take this for 4.0, or 4.1?

	Arnd
