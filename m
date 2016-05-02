From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 2 May 2016 16:34:11 +0200
Subject: [GIT PULL] ARM: mediatek soc updates for v4.7
Message-ID: <CABuKBeJV6bA=2Sx_apRp2HMfuyymFCV67zxaoJzBeRbRMzv0AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please take the following patches for v4.7.

Thanks,
Matthias

---

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.6-next-soc

for you to fetch changes up to 601bac7638fa693204dc70035d2651474704967c:

  ARM: mediatek: enable gpt6 on boot up to make arch timer work on
mt7623 (2016-04-20 13:58:45 +0200)

----------------------------------------------------------------
- re-organize pmic wrapper code for easier and cleaner addiont of new
SoCs and pmic wrappers
- add support for pmic wrapper mt6323
- add support for SoC mt2701
- enable gpt6 arch timer on mt7623

----------------------------------------------------------------
John Crispin (11):
      soc: mediatek: PMIC wrap: don't duplicate the wrapper data
      soc: mediatek: PMIC wrap: add wrapper callbacks for init_reg_clock
      soc: mediatek: PMIC wrap: split SoC specific init into callback
      soc: mediatek: PMIC wrap: WRAP_INT_EN needs a different bitmask
for MT2701/7623
      soc: mediatek: PMIC wrap: SPI_WRITE needs a different bitmask
for MT2701/7623
      soc: mediatek: PMIC wrap: move wdt_src into the pmic_wrapper_type struct
      soc: mediatek: PMIC wrap: remove pwrap_is_mt8135() and pwrap_is_mt8173()
      soc: mediatek: PMIC wrap: add a slave specific struct
      soc: mediatek: PMIC wrap: add mt6323 slave support
      soc: mediatek: PMIC wrap: add MT2701/7623 support
      ARM: mediatek: enable gpt6 on boot up to make arch timer work on mt7623

 arch/arm/mach-mediatek/mediatek.c    |   1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c | 544 ++++++++++++++++++++++++++---------
 2 files changed, 414 insertions(+), 131 deletions(-)
