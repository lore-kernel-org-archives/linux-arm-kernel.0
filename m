From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Feb 2012 14:50:57 -0800
Subject: What's in tegra.git for 3.4
Message-ID: <CAOesGMjnWPgSa44hgRu+d0jrQLm9KuOcuufg9V8fYZ8TytsbPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We're closing in on when things need to be in the sub-arch trees in
time to get merged for the next merge window. The shortlog below is
what i have queued up today.

There are some patches that I've had recent comments to, and most of
those I expect follow-up or respins of. If there's something that I
seem to have missed completely and been silent on (and it's not
listed), then now is the time to speak up.

I'll let the below sit such that it gets picked up by linux-next
tomorrow (I might have missed today's pulls by sfr), and then send the
arm-soc pull requests.


-Olof

Doug Anderson (2):
      ARM: tegra: Introduce define DEBUG_UART_SHIFT
      ARM: tegra: uncompress.h: Store UART address in a variable

Laxman Dewangan (2):
      ARM: tegra: Pause DMA when reading transfer count
      ARM: tegra: dma: not required to move requestor when stopping.

Leon Romanovsky (2):
      ARM: dt: tegra: Enable device tree audio codec on PAZ00 board.
      ARM: dt: tegra: Enable headset autodetection on PAZ00 board.

Marc Dietrich (5):
      ARM: tegra: paz00: fix wrong SD1 power gpio
      ARM: tegra: paz00: fix wrong UART port on mini-pcie plug
      ARM: dt: tegra: add ADT7461 temperature sensor to paz00 device tree
      ARM: dt: tegra: add the power gpio key to paz00 device tree
      ARM: dt: tegra: add the wifi led to paz00 device tree

Olof Johansson (9):
      ARM: tegra: emc: device tree bindings
      ARM: tegra: seaboard: add EMC table to device tree
      ARM: tegra: Don't WARN_ON() for too early dma channel allocations
      ARM: tegra: use APB DMA for accessing APB devices
      ARM: tegra: fuse: use apbio dma for register access
      ARM: tegra: fuse: add functions to access chip revision
      ARM: tegra: fuse: add bct strapping reading
      ARM: tegra: emc: convert tegra2_emc to a platform driver
      ARM: tegra: emc: device tree support

Peter De Schrijver (19):
      ARM: tegra: add support for tegra30 interrupts
      ARM: tegra: add support for new clock framework features
      ARM: tegra: implement basic tegra30 clock framework
      ARM: tegra: enable tegra30 clock framework
      ARM: tegra: initialize basic system clocks
      ARM: tegra: definitions for flow controller
      ARM: tegra: assembler code for LP3
      ARM: tegra: cpuidle driver for tegra
      ARM: tegra: cleanup use of chipid register
      ARM: tegra: export Tegra chipid
      ARM: tegra: initialize Tegra chipid early
      ARM: tegra: functions to access the flowcontroller
      ARM: tegra: rework Tegra secondary CPU core bringup
      ARM: tegra: prepare powergate.c for multiple variants
      ARM: tegra: export tegra_powergate_is_powered()
      ARM: tegra: add support for Tegra30 powerdomains
      ARM: tegra: support for Tegra30 CPU powerdomains
      ARM: tegra: support for secondary cores on Tegra30
      ARM: tegra: Avoid compiling cpuidle code when not configured

Stephen Warren (21):
      dt: tegra gpio: Flesh out binding documentation
      ARM: dt: tegra30.dtsi: Reformat gpio's interrupts property
      ARM: dt: tegra30.dtsi: Add extra GPIO interrupt
      ARM: dt: tegra: Add Tegra APB DMA device tree binding
      ARM: dt: tegra: Modify I2S nodes to match binding
      ARM: dt: tegra: Add labels for I2S controllers
      ARM: dt: tegra: Enable audio on WM8903 boards, disable others
      ARM: dt: Add binding for Tegra PMC
      ARM: tegra: Support Tegra30 in decompressor UART setup
      ARM: tegra: uncompress.h: Choose a UART at runtime
      ARM: tegra: Pass uncompress.h UART selection to DEBUG_LL
      ARM: tegra: Remove use of TEGRA_GPIO_TO_IRQ
      gpio: tegra: Dynamically allocate IRQ base, and support DT
      gpio: tegra: Parameterize the number of banks
      ARM: tegra: Fix EMC pdata initialization from registers
      ARM: tegra: Add a simple PMC driver
      ARM: tegra: Remove duplicate PMU interrupt inversion code
      gpio: tegra: Fix build issue due to irq_domain rework.
      ARM: dt: Add SD controller configuration to Tegra Cardhu
      ARM: tegra: Demote EMC clock inconsistency BUG to WARN
      ARM: tegra: select required CPU and L2 errata options

Thierry Reding (1):
      ARM: tegra: PCIe: Provide 3.3V supply voltage
