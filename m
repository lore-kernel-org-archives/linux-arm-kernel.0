From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 20 Jul 2017 15:32:39 +0800
Subject: [PATCH v7 0/3] MFD: add driver for HiSilicon Hi6421v530 PMIC
Message-ID: <20170720073242.1758-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds driver for HiSilicon Hi6421v530 PMIC.

Mainline kernel already has driver support to a similar chip, Hi6421.
Hi6421 and Hi6421v530 are both from the same vendor, HiSilicon, but
they are at different revisions. They both use the same Memory-mapped
I/O method to communicate with Main SoC. However, they differ quite a
lot in their regulator designs. Eg. they have completely different LDO
voltage points.

Patch 1 and 2 are hi6421-pmic cleaning up.
Patch 3 extends hi6421-pmic-core.c to support Hi6421v530 revision.

Major changes in v7:
 - rebase to v4.13-rc1 and resend MFD driver patches.
 - As of v6, DTS and regulator parts have been merged into v4.13-rc1.
   So they are not included in v7.

Major changes in v6:
 - Patch 5, solve review comments from Mark Brown, add hi6421v530 regulator
     driver to module device table.
 - Add Acked-by from Arnd Bergmann

Major changes in v5:
 - Patch 3, solve review comments from Lee Johes

Major changes in v4:
 - put hi6421-pmic cleanup in separate patches.
 - solve review comments from Lee Johes.
 - regulator-name should not have '/' character. Otherwise it "Failed to
     create debugfs directory"

Major changes in v3:
 - in hi6421-pmic-core.c
    * use shorter license script.
    * arrange #include in alphabetical order.
    * using recommended error log messages from Lee Jones.
 - in hi6421v530-regulator.c
    * remove unused #include files
    * arrange remaining ones in alphabetical order.

Major changes in v2:
 - instead of writing a new driver, extend hi6421-pmic-core.c
     to support its v530 revision
 - update hi6421v530-regulator.c to use modern regulator driver
     design logics.

*** BLURB HERE ***

Guodong Xu (3):
  mfd: hi6421-pmic: cleanup: change license text to shorter form
  mfd: hi6421-pmic: cleanup: update dev_err messages
  mfd: hi6421-pmic: add support for HiSilicon Hi6421v530

 drivers/mfd/hi6421-pmic-core.c  | 89 ++++++++++++++++++++++++++---------------
 include/linux/mfd/hi6421-pmic.h |  5 +++
 2 files changed, 62 insertions(+), 32 deletions(-)

-- 
2.10.2
