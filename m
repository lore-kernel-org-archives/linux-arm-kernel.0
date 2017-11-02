From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 2 Nov 2017 20:00:40 +0100 (CET)
Subject: [PATCH 00/12] bcm63xx-rng conversion to bcm2835-rng
In-Reply-To: <20171102010408.27736-1-f.fainelli@gmail.com>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
Message-ID: <1883956051.127519.1509649240138@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> Florian Fainelli <f.fainelli@gmail.com> hat am 2. November 2017 um 02:03 geschrieben:
> 
> 
> Hi,
> 
> As it usually happens when there is a fair amount of HW IP block re-use,
> competing implementations show up. In that case the BCM2835 HWRNG driver and
> the BCM63xx RNG driver have exactly the same register offsets and this is
> indeed the same piece of HW.
> 
> This patch series first prepares the bcm2835-rng to be more future proof and
> support newer platforms, and the last part brings in what is necessary to
> migrate the bcm63xx-rng over to bcm2835-rng. Finally we delete bcm63xx-rng
> completely.
> 
> The reason why BCM2835 RNG was kept over BCM63xx RNG is because the former
> deals correctly with a warm up count and the number of words available in the
> FIFO size.

are these the same patches as in this branch [1]?

https://github.com/ffainelli/linux/commits/rng-consolidation

Regards
Stefan

> 
> Thanks!
> 
> Florian Fainelli (12):
>   hwrng: bcm2835-rng: Obtain base register via resource
>   hwrng: bcm2835-rng: Define a driver private context
>   hwrng: bcm2835-rng: Move enabling to hwrng::init
>   hwrng: bcm2835-rng: Implementation cleanup callback
>   hwrng: bcm2835-rng: Use device managed helpers
>   hwrng: bcm2835-rng: Rework interrupt masking
>   hwrng: bcm2835-rng: Manage an optional clock
>   hwrng: bcm2835-rng: Abstract I/O accessors
>   hwrng: bcm2835-rng: Add Broadcom MIPS I/O accessors
>   dt-bindings: rng: Incorporate brcm,bcm6368.txt binding
>   hwrng: bcm2835-rng: Enable BCM2835 RNG to work on BCM63xx platforms
>   hwrng: bcm63xx-rng: Remove since bcm2835-rng takes over
> 
>  .../devicetree/bindings/rng/brcm,bcm2835.txt       |  22 ++-
>  .../devicetree/bindings/rng/brcm,bcm6368.txt       |  17 ---
>  drivers/char/hw_random/Kconfig                     |  20 +--
>  drivers/char/hw_random/Makefile                    |   1 -
>  drivers/char/hw_random/bcm2835-rng.c               | 166 ++++++++++++++-------
>  drivers/char/hw_random/bcm63xx-rng.c               | 154 -------------------
>  6 files changed, 139 insertions(+), 241 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm6368.txt
>  delete mode 100644 drivers/char/hw_random/bcm63xx-rng.c
> 
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
