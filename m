From: blogic@openwrt.org (John Crispin)
Date: Fri, 19 Feb 2016 09:44:04 +0100
Subject: [PATCH V6 00/11] soc: mediatek: PMIC wrap: add MT6323/2701/7623
 support
Message-ID: <1455871455-21212-1-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the MT6323 PMIC and the MT2701/7623 SoC.
MT6323 is slightly different to the already supported PMIC. This series
makes a few changes to the code to allow easy addition of the new PMIC
and SoCs.

Changes in V6
* 4/11 - make description verbose and rename init_special
* 6/11 - make description verbose
* 7/11 - make description verbose
* 8/11 - make description verbose
* 9/11 - put mt6397 specific dew registers in their own paragraph


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
 drivers/soc/mediatek/mtk-pmic-wrap.c               |  544 +++++++++++++++-----
 2 files changed, 414 insertions(+), 131 deletions(-)

-- 
1.7.10.4
