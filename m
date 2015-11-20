From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Fri, 20 Nov 2015 08:45:15 +0100
Subject: [PATCH v2 0/2] fix a possible NULL dereference
Message-ID: <1448005517-26004-1-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

The main goal of this patch series is to fix a possible NULL dereference.
Even if the probability of this case is very low, fixing it made
static analyzers happy.
In the same time it permits to remove a "cast that drop const qualifiers.

Regards

Changes since v1
- Use of_device_get_match_data
- Add the missing patch for constify atmel_nand_caps structures

LABBE Corentin (2):
  mtd: nand: atmel_nand: constify atmel_nand_caps structures
  mtd: nand: atmel_nand: fix a possible NULL dereference

 drivers/mtd/nand/atmel_nand.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.4.10
