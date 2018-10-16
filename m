From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Oct 2018 12:01:46 +0900
Subject: [PATCH 0/3] i2c: uniphier-f: fix concurrency issues and race
 conditions
Message-ID: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently, this driver has issues that rarely happen.

With this patch series, long-run tests passed.



Masahiro Yamada (3):
  i2c: uniphier-f: make driver robust against concurrency
  i2c: uniphier-f: fix occasional timeout error
  i2c: uniphier-f: fix race condition when IRQ is cleared

 drivers/i2c/busses/i2c-uniphier-f.c | 59 +++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 13 deletions(-)

-- 
2.7.4
