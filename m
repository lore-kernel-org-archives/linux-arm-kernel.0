From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Dec 2015 14:55:29 +0100
Subject: [GIT PULL] Ux500 device tree changes for v4.5
Message-ID: <CACRpkdbts6_Fk-P=Ojom8-OuJ+UThA54fXB_eTcq0H7imUBhsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

please pull these changes to ARM SoC for the next merge window.
More detailed description in the signed tag.

Yours,
Linus Walleij


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dt-for-arm-soc

for you to fetch changes up to 2f23cda3bfa5820fd3702dff45453af4420f7ada:

  ARM: ux500: configure the sensors on the TVK board correctly
(2015-12-01 14:48:12 +0100)

----------------------------------------------------------------
Device Tree changes for Ux500:
- Push the Rohm touchscreen to the STUIB, as the TVK UIB has
  a Synaptics RMI4 touchscreen.
- Set up the right sensor IRQs for the Snowball, so that
  periodic data ready-IRQ capture starts working.
- Use wakeup-source consequently.
- Remove legacy regulator-compatible strings.
- Define the sensors on the HREFP TVK board properly.

----------------------------------------------------------------
Javier Martinez Canillas (2):
      ARM: ux500: remove regulator-compatible usage
      ARM: u300: remove regulator-compatible usage

Linus Walleij (3):
      ARM: ux500: push down Rohm TS to STUIB
      ARM: ux500: Assign proper sensor IRQs for Snowball
      ARM: ux500: configure the sensors on the TVK board correctly

Sudeep Holla (1):
      ARM: ux500: replace legacy *,wakeup property with wakeup-source

 arch/arm/boot/dts/ste-dbx5x0.dtsi          | 33 -------------------
 arch/arm/boot/dts/ste-href-stuib.dtsi      | 23 +++++++++++++
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 52 +++++++++++++++++++++++++-----
 arch/arm/boot/dts/ste-hrefv60plus.dtsi     | 18 -----------
 arch/arm/boot/dts/ste-nomadik-s8815.dts    |  2 +-
 arch/arm/boot/dts/ste-snowball.dts         |  7 ++--
 arch/arm/boot/dts/ste-u300.dts             | 10 ------
 7 files changed, 72 insertions(+), 73 deletions(-)
