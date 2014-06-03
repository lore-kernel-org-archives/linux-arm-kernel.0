From: andrea.adami@gmail.com (Andrea Adami)
Date: Tue,  3 Jun 2014 23:28:59 +0200
Subject: [PATCH 0/2] ARM: sa1100: collie mtd fixes
Message-ID: <1401830941-17086-1-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After having extensivly tested three different units (2 Zaurus SL-5500,
1 SL-5500G) I finally send this small patches fixing collie's mtd.

The background is the improved support for the specific chips, see pending:
"mtd: cfi_cmdset_0001.c: add support for Sharp LH28F640BF NOR" for linux-mtd.

The most important is the first one reverting to cfi_probe
(the test-unit had broken CFI rom and CFI query was not matched).

The second one exposes the nor bootblock (in a read-only manner).
Sharp decided to put there just a few bytes, the sharpls_param
(COMADJ, UUID, TOUCH, AD, PHAD) set in the Diagnostic Menu.

Andrea Adami (2):
  arm: sa1100: collie: revert back to cfi_probe
  arm: sa1100: collie: add top boot mtd partition

 arch/arm/mach-sa1100/collie.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
1.9.1
