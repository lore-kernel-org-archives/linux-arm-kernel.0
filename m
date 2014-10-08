From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 14:07:48 +0200
Subject: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa
 board
In-Reply-To: <CAPDyKFqGS5mRpAJLkmQ3fnGKktLFDEt_pi+uaK-xCUtw1+Duvg@mail.gmail.com>
References: <2750153.I3nVqzmXTP@amdc1032>
 <CAPDyKFqGS5mRpAJLkmQ3fnGKktLFDEt_pi+uaK-xCUtw1+Duvg@mail.gmail.com>
Message-ID: <3871564.7PhRGhHd6U@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 October 2014 20:16:44 Ulf Hansson wrote:
> On 2 October 2014 18:10, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > Regulators for MMC2 (SD card) are PVDD_TFLASH_2V8 (LDO19) for vmmc
> > and PVDD_APIO_MMCOFF_2V8 (LDO13) for vqmmc.  Currently the device
> > tree entry for MMC2 uses PVDD_PRE_1V8 (LDO10) for vmmc and vqmmc is
> > not specified.  Fix it.
> >
> > Without this patch:
> > - "mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators"
> >   patch causes a SD card detection to fail
> > - "mmc: dw_mmc: Support voltage changes" patch causes a boot hang
> >
> > This patch fixes both above problems.
> >
> > Suggested-by: Doug Anderson <dianders@google.com>
> > Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Unless it causes a bunch non-trivial conflicts, I suggest we take this
> through my mmc tree to not break bisectability.

Have you tried if it conflicts with arm-soc? If not, 

Acked-by: Arnd Bergmann <arnd@arndb.de>
