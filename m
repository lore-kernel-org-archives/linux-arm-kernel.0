From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Oct 2014 09:46:18 +0100
Subject: next build: 304 warnings 0 failures (next/next-20141013)
In-Reply-To: <543b63d2.a479420a.486e.ffffb6e2@mx.google.com>
References: <543b63d2.a479420a.486e.ffffb6e2@mx.google.com>
Message-ID: <20141013084618.GC27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 12, 2014 at 10:32:02PM -0700, Olof's autobuilder wrote:
>       1 arch/arm/mach-cns3xxx/pcie.c:313:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This should be fixed.

>       1 arch/arm/mach-omap1/board-htcherald.c:296:2: warning: initialization makes pointer from integer without a cast [enabled by default]
>       1 arch/arm/mach-omap1/board-htcherald.c:296:2: warning: (near initialization for 'gpio_leds[0].gpiod') [enabled by default]
>       1 arch/arm/mach-omap1/board-htcherald.c:297:2: warning: initialization makes pointer from integer without a cast [enabled by default]
>       1 arch/arm/mach-omap1/board-htcherald.c:297:2: warning: (near initialization for 'gpio_leds[1].gpiod') [enabled by default]
...

All of these need fixing.

>       2 drivers/base/dma-contiguous.c:244:2: warning: initialization from incompatible pointer type
>       2 drivers/base/dma-contiguous.c:244:2: warning: (near initialization for 'rmem_cma_ops.device_init')

This does too.

>       3 drivers/base/dma-coherent.c:303:2: warning: initialization from incompatible pointer type
>       3 drivers/base/dma-coherent.c:303:2: warning: (near initialization for 'rmem_dma_ops.device_init')
>       8 drivers/base/dma-contiguous.c:244:2: warning: initialization from incompatible pointer type [enabled by default]
>       8 drivers/base/dma-contiguous.c:244:2: warning: (near initialization for 'rmem_cma_ops.device_init') [enabled by default]
>      50 drivers/base/dma-coherent.c:303:2: warning: initialization from incompatible pointer type [enabled by default]
>      50 drivers/base/dma-coherent.c:303:2: warning: (near initialization for 'rmem_dma_ops.device_init') [enabled by default]

And these.

None of these warnings should hit mainline; they should all be fixed now,
before any of the changes which caused them are merged.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
