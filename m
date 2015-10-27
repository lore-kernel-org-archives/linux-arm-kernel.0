From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 27 Oct 2015 15:31:43 +0800
Subject: [PATCH v1 0/3] mailbox: rockchip: Add mailbox driver for Rockchip
 platform
Message-ID: <1445931106-683-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mailbox is used by the Rockchip CPU cores to communicate
requests to MCU processor.

This driver is found on RK3368 SoCs.

The Mailbox module is a simple APB peripheral that allows both
the Cortex-A53 MCU system to communicate by writing operation to
generate interrupt.
The registers are accessible by both CPU via APB interface.

Tested on RK3368 SDK board.


Changes in v1:
- PATCH[1/3] doc:
- As the Rob Herring comments, s/share/shared/ and specify the value of #mbox-cells.
- Move the shared memory in mailbox, let's move the property the client
  driver in the future.
- PATCH[2/3] driver:
- The commit: %s/@/(num order).
- Add the module authors to instead of the notes.
- Add the COMPILE_TEST to auto compile test in Kconfig.
- Let the chan_to_idx() trys to instead of rockchip_mbox_chan.idx.
- Let's enable/disable the interrupt in startup/shutdown.
- Move the share memory and tx buf into the client drivers.
- PATCH[3/3] dts:
- fix "processormZ"--> "processor",the miss-fingerboard.
- Remove the shared memory in mailbox controller dtsi.

Caesar Wang (3):
  dt-bindings: rockchip-mailbox: Add mailbox controller document on
    Rockchip SoCs
  mailbox: rockchip: Add Rockchip mailbox driver
  ARM64: dts: rk3368: Add mailbox device nodes

 .../bindings/mailbox/rockchip-mailbox.txt          |  32 +++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  12 +
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/rockchip-mailbox.c                 | 286 +++++++++++++++++++++
 5 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
 create mode 100644 drivers/mailbox/rockchip-mailbox.c

-- 
1.9.1
