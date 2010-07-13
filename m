From: jason77.wang@gmail.com (Jason Wang)
Date: Tue, 13 Jul 2010 21:02:38 +0800
Subject: [PATCH 0/3]Add imx51_3ds platform support
Message-ID: <1279026162-6634-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

part3:

 [PATCH 1/3] mx51_3ds: Add support for the imx51 3-stack board
 [PATCH 2/3] mx51: add imx_keypad device definition for mx51 platforms
 [PATCH 3/3] mx51_3ds: add keypad support on 3ds platform
 This patchset will add imx51_3ds platform in the linux kernel,
 These 3 patches are generated based off imx-for-2.6.36 branch,
 and passed build test.

 But currently in imx-for-2.6.36 branch, there is a recently applied
 patch which will affect all imx gpio chained irqs. The lan driver
 on imx51_3ds can't raise irq(through gpio) because of this potential
 issue. I generate the following patch to fix it.
 [PATCH] imx: move gpio init after to irq init
