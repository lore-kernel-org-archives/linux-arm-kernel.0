From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 Sep 2013 20:36:18 +0200
Subject: [PATCH 1/2] ARM: msm: trout: fix 'pointer from integer' warnings
In-Reply-To: <5350fa5571d24b68d6bb27959d3ef761ccb95b00.1378771874.git.joshc@codeaurora.org>
References: <5350fa5571d24b68d6bb27959d3ef761ccb95b00.1378771874.git.joshc@codeaurora.org>
Message-ID: <201309152036.18373.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 September 2013, Josh Cartwright wrote:
> -#define TROUT_GPIO_INT_MASK0_REG            (0x0c)
> -#define TROUT_GPIO_INT_STAT0_REG            (0x0e)
> -#define TROUT_GPIO_INT_MASK1_REG            (0x14)
> -#define TROUT_GPIO_INT_STAT1_REG            (0x10)
> +#define TROUT_GPIO_INT_MASK0_REG            IOMEM(0x0c)
> +#define TROUT_GPIO_INT_STAT0_REG            IOMEM(0x0e)
> +#define TROUT_GPIO_INT_MASK1_REG            IOMEM(0x14)
> +#define TROUT_GPIO_INT_STAT1_REG            IOMEM(0x10)

This is wrong, the values above are offsets from TROUT_CPLD_BASE. Instead you
need to make that constant an __iomem token and leave these as integers.

	Arnd
