From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Fri, 11 Aug 2017 08:57:35 +0200
Subject: [PATCH 0/2] constify regmap_bus structures
Message-ID: <1502434657-16701-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These regmap_bus structures are only passed as the second argument to
__devm_regmap_init or __regmap_init, both of which are const, so the
regmap_bus structures can be const too.

Done with the help of Coccinelle.

---

 drivers/base/regmap/regmap-spi.c  |    2 +-
 drivers/base/regmap/regmap-spmi.c |    4 ++--
 drivers/bus/sunxi-rsb.c           |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
