From: blogic@openwrt.org (John Crispin)
Date: Sun,  7 Feb 2016 11:42:47 +0100
Subject: [PATCH V5 00/11] soc: mediatek: PMIC wrap: add MT6323/2701/7623
 support
Message-ID: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for a new PMIC (MT6323) and 2 new SoCs
(MT2701/7623) to the pmic-wrap driver.


John Crispin (11):
  dt-bindings: ARM: Mediatek: add MT2701/7623 string to the PMIC
    wrapper doc
  soc: mediatek: PMIC wrap: don't duplicate the wrapper data
  soc: mediatek: PMIC wrap: add wrapper callbacks for init_reg_clock
  soc: mediatek: PMIC wrap: split SoC specific init into callback
  soc: mediatek: PMIC wrap: WRAP_INT_EN needs a different bitmask for
    MT2701/7623
  soc: mediatek: PMIC wrap: SPI_WRITE needs a different bitmask for
    MT2701/7623
  soc: mediatek: PMIC wrap: move wdt_src into the pmic_wrapper_type
    struct
  soc: mediatek: PMIC wrap: remove pwrap_is_mt8135() and
    pwrap_is_mt8173()
  soc: mediatek: PMIC wrap: add a slave specific struct
  soc: mediatek: PMIC wrap: add mt6323 slave support
  soc: mediatek: PMIC wrap: add MT2701/7623 support

 .../devicetree/bindings/soc/mediatek/pwrap.txt     |    1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               |  554 +++++++++++++++-----
 2 files changed, 424 insertions(+), 131 deletions(-)

-- 
1.7.10.4
