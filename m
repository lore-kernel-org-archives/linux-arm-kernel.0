From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Mon, 13 Jun 2016 20:23:02 +0530
Subject: [PATCH 0/2] ARM: pxa: ssp: Clean up probe and remove functions
Message-ID: <cover.1465827542.git.amitoj1606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Address some issues related to devm_ functions.

The first patch cleans up the remove function of this driver of
unnecessary freeing functions: kfree, iounmap, clk_put and
release_mem_region since devm_ allocated data does not need to 
be freed.

The second patch replaces devm_request_mem_region and devm_ioremap with
devm_ioremap_resource.

Amitoj Kaur Chawla (2):
  ARM: pxa: ssp: Drop unnecessary freeing functions
  ARM: pxa: ssp: Switch to devm_ioremap_resource

 arch/arm/plat-pxa/ssp.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

-- 
1.9.1
