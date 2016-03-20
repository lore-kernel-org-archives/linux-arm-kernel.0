From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sun, 20 Mar 2016 13:26:12 +0530
Subject: [GIT PULL] Mailbox changes for v4.6
Message-ID: <CABb+yY2c7QqJgqiWYXAFGjuyyhU1SY4aqexoSFN07HYeS+jyNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 1926e54f115725a9248d0c4c65c22acaf94de4c4:

  MAINTAINERS: Update mailing list for Renesas ARM64 SoC Development
(2016-02-14 18:38:15 -0800)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to c5a9d1f30c066b7922a5f66b8c03a263d2f06a8c:

  mailbox: rockchip: avoid 64-bit division (2016-03-16 09:18:15 +0530)

----------------------------------------------------------------

- Mailbox bindings and driver for APM X-Gene platform
- Mailbox bindings and driver for Hisilicon Hi6220 platform
- Mailbox bindings and driver for Rockchip RK3368 platform
- Minor fixes to the above three drivers.
- Misc cleanups of mailbox-test driver.

----------------------------------------------------------------
Arnd Bergmann (1):
      mailbox: rockchip: avoid 64-bit division

Caesar Wang (2):
      dt-bindings: rockchip-mailbox: Add mailbox controller document
on Rockchip SoCs
      mailbox: rockchip: Add Rockchip mailbox driver

Dan Carpenter (1):
      mailbox/xgene-slimpro: Checking for IS_ERR instead of NULL

Duc Dang (2):
      mailbox: Add support for APM X-Gene platform mailbox driver
      Documentation: mailbox: Add APM X-Gene SLIMpro mailbox dts documentation

Leo Yan (2):
      dt-bindings: mailbox: Document Hi6220 mailbox driver
      mailbox: Hi6220: add mailbox driver

Sudeep Holla (4):
      mailbox: mailbox-test: rename driver as generic test driver
      mailbox: mailbox-test: fix the compatible string
      mailbox: mailbox-test: use print_hex_dump_bytes to allow dynamic printk
      mailbox: mailbox-test: add support for separate tx/rx buffer
with single channel

 .../bindings/mailbox/hisilicon,hi6220-mailbox.txt  |  74 ++++
 .../bindings/mailbox/rockchip-mailbox.txt          |  32 ++
 .../devicetree/bindings/mailbox/sti-mailbox.txt    |   2 +-
 .../bindings/mailbox/xgene-slimpro-mailbox.txt     |  35 ++
 drivers/mailbox/Kconfig                            |  26 ++
 drivers/mailbox/Makefile                           |   6 +
 drivers/mailbox/hi6220-mailbox.c                   | 395 +++++++++++++++++++++
 drivers/mailbox/mailbox-test.c                     |  53 +--
 drivers/mailbox/mailbox-xgene-slimpro.c            | 284 +++++++++++++++
 drivers/mailbox/rockchip-mailbox.c                 | 283 +++++++++++++++
 10 files changed, 1167 insertions(+), 23 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
 create mode 100644
Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
 create mode 100644
Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
 create mode 100644 drivers/mailbox/hi6220-mailbox.c
 create mode 100644 drivers/mailbox/mailbox-xgene-slimpro.c
 create mode 100644 drivers/mailbox/rockchip-mailbox.c
