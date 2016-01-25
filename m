From: blogic@openwrt.org (John Crispin)
Date: Mon, 25 Jan 2016 10:53:13 +0100
Subject: [PATCH V3 00/11] soc: mediatek: PMIC wrap: add MT6323/2701/7623
 support
Message-ID: <1453715604-36856-1-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in V3:
* I accidentially sent a V2 about 15 minutes ago. Unfortunatley the time
  inside the VM that i used was wrong and lagged by 6 days. V3 is the same
  as V2 but with the correct time.

Changes in V2:
* rebase the code on the MTK internal driver

John Crispin (11):
  dt-bindings: ARM: Mediatek: add MT2701/7623 string to the PMIC
    wrapper doc
  soc: mediatek: PMIC wrap: don't duplicate the wrapper data
  soc: mediatek: PMIC wrap: add wrapper callbacks for init_reg_clock
  soc: mediatek: PMIC wrap: split SoC specific init into callback
  soc: mediatek: PMIC wrap: WRAP_INT_EN needs a different bitmask for
    MT2701/7623
  soc: mediatek: PMIC wrap:: SPI_WRITE needs a different bitmask for
    MT2701/7623
  soc: mediatek: PMIC wrap: move wdt_src into the pmic_wrapper_type
    struct
  soc: mediatek: PMIC wrap: remove pwrap_is_mt8135() and
    pwrap_is_mt8173()
  soc: mediatek: PMIC wrap: add a slave specific struct
  soc: mediatek: PMIC wrap: add mt6323 slave support
  soc: mediatek: PMIC wrap: add MT2701/7623 support

 .../devicetree/bindings/soc/mediatek/pwrap.txt     |    1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               |  560 +++++++++++++++-----
 2 files changed, 430 insertions(+), 131 deletions(-)

-- 
1.7.10.4
