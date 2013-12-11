From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 11 Dec 2013 12:59:28 +0200
Subject: [PATCH v3 0/2] Introduce AEMIF driver for Davinci/Keystone archs
Message-ID: <1386759570-29671-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches introduce Async External Memory Interface (EMIF16/AEMIF)
controller driver for Davinci/Keystone archs.

For more informations see documentation:
Davinci DM646x - http://www.ti.com/lit/ug/sprueq7c/sprueq7c.pdf
OMAP-L138 - http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
Kestone - http://www.ti.com/lit/ug/sprugz3a/sprugz3a.pdf

Based on
git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
keystone/master

v2..v3:
- memory: ti-aemif: introduce AEMIF driver
	changed to work with multiple AEMIF controllers
	corrected "copyright" to "authors" in header
	changed compatible "ti,omap-L138-aemif" to "ti,da850-aeimf"
	used NULL in clk_get() instead of "aemif" name
	driver can be build as loadable module
	treat all child nodes as cs nodes, it makes code simpler

- memory: ti-aemif: add bindings for AEMIF driver
	deleted direct link driver/memory/ti-aemif.c
	clarified description of controller ranges property
	changed compatible "ti,omap-L138-aemif" to "ti,da850-aeimf"
	added cs number information in commit log
	removed compatible property from cs node, it makes code simpler

v1..v2:
- memory: ti-aemif: introduce AEMIF driver
- memory: ti-aemif: add bindings for AEMIF driver
	added ti.cs-chipselect property instead of representing chipselect
	number in cs node name.

Ivan Khoronzhuk (2):
  memory: ti-aemif: introduce AEMIF driver
  memory: ti-aemif: add bindings for AEMIF driver

 .../bindings/memory-controllers/ti-aemif.txt       |  210 ++++++++++
 drivers/memory/Kconfig                             |   11 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/ti-aemif.c                          |  429 ++++++++++++++++++++
 4 files changed, 651 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt
 create mode 100644 drivers/memory/ti-aemif.c

-- 
1.7.9.5
