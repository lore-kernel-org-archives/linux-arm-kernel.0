From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 11 Feb 2016 12:46:17 +0100
Subject: [PATCH V5 00/11] soc: mediatek: PMIC wrap: add MT6323/2701/7623
 support
In-Reply-To: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
References: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
Message-ID: <56BC7489.8030402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On 07/02/16 11:42, John Crispin wrote:
> This series adds support for a new PMIC (MT6323) and 2 new SoCs
> (MT2701/7623) to the pmic-wrap driver.
>
>
> John Crispin (11):
>    dt-bindings: ARM: Mediatek: add MT2701/7623 string to the PMIC
>      wrapper doc
>    soc: mediatek: PMIC wrap: don't duplicate the wrapper data
>    soc: mediatek: PMIC wrap: add wrapper callbacks for init_reg_clock
>    soc: mediatek: PMIC wrap: split SoC specific init into callback
>    soc: mediatek: PMIC wrap: WRAP_INT_EN needs a different bitmask for
>      MT2701/7623
>    soc: mediatek: PMIC wrap: SPI_WRITE needs a different bitmask for
>      MT2701/7623
>    soc: mediatek: PMIC wrap: move wdt_src into the pmic_wrapper_type
>      struct
>    soc: mediatek: PMIC wrap: remove pwrap_is_mt8135() and
>      pwrap_is_mt8173()
>    soc: mediatek: PMIC wrap: add a slave specific struct
>    soc: mediatek: PMIC wrap: add mt6323 slave support
>    soc: mediatek: PMIC wrap: add MT2701/7623 support
>
>   .../devicetree/bindings/soc/mediatek/pwrap.txt     |    1 +
>   drivers/soc/mediatek/mtk-pmic-wrap.c               |  554 +++++++++++++++-----
>   2 files changed, 424 insertions(+), 131 deletions(-)
>

In the future, can you please add one liners to explain what you changed 
in comparison to the former version, this helps pretty much when 
reviewing patch series.

The whole series is in a pretty good shape, I have just some minor comments.

Regards,
Matthias
