From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Feb 2010 01:05:00 +0100
Subject: [PATCH 0/7] PrimeCell DMA Device
Message-ID: <1266537900-11710-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a revised set of patches mainly adding DMA
engine support to the so-called "amba" bus which is
actually the PrimeCell bus. It also deals with
setting the maximum clocking frequency from the
platform data.

For DMA: the idea is to structure the data passed
from the PrimeCell to the DMA engine framework to
get some control over it, atleast we will have an
established place where such stuff should go, and
that is struct amba_dma_channel_config.

The patches goes from trivial groundwork to
controversial so that the chain can be cut anywhere.
It's cleanup patches for amba and MMCI first.

Patch 1 - Removes the custom DBG macro and a printk()
  in mmci.c in favor of dev_dbg()/dev_err()
  [Rebase of earlier patch]

Patch 2 - Introduce the f_max attribute in the MMCI
  platform data struct and add kerneldoc to the
  platform data in <linux/amba/mmci.h>.
  [Rebase of earlier patch]

Patch 3 - Set the U300 f_max attribute to 24 MHz
  [Rebase of earlier patch]

Patch 4 - Add the PrimeCell DMA device superset
  extension in <linux/amba/dma.h> and (basically a
  struct and the dma_set_ambaconfig() call) and
  implement this all the way in the MMCI driver as
  an example.

Patch 5 - Amend the U300 platform config with
  DMA specifics.

Patch 6 - Patch sent earliner to Dan Williams
  that updates the linux-next COH 901 318 driver
  to support memcpy and slaves properly.

Patch 7 - Patch on top of the patch already sent
  to Dan Williams, adding the PrimeCell API
  to COH 901 318 so that U300 compiles properly.

The entire set has been regression compiled against
the RealView, Versatile and Integrator defconfigs.

Yours,
Linus Walleij
