From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 25 Oct 2016 15:41:15 +0200
Subject: [RFC v2] da850: DDR2/mDDR memory controller driver
Message-ID: <1477402876-22472-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow-up for the series[1] adding new bus and memory drivers
to better support the TI LCD controller on the da850-lcdk board.

The general consensus of the discussion that followed was that DT is
not the right tool for this kind of SoC performance tweaks.

In order to avoid committing to stable DT bindings, we only introduce
two common properties (compatible and reg) while the configuration
register values are hard-coded for each board (currently only lcdk).

In the future, once linux gets a proper framework for performance
knobs, we'll convert this driver to using the better solution.

I'm sending a single patch this time as RFC to get some reviews and
see it the approach is viewed as correct.

[1] https://lkml.org/lkml/2016/10/17/613

v1 -> v2:
- changed the compatible string to make it more descriptive
- changed the DT bindings description to describe the device, not the
  driver's functionalities
- switched to using of_machine_is_compatible() instead of handcoding
  the same functionality
- used platform_get_resource() instead of ioremapping registers by hand

Bartosz Golaszewski (1):
  ARM: memory: da8xx-ddrctl: new driver

 .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 +++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/da8xx-ddrctl.c                      | 175 +++++++++++++++++++++
 4 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
 create mode 100644 drivers/memory/da8xx-ddrctl.c

-- 
2.9.3
