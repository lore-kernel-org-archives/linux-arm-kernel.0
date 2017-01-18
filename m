From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 17 Jan 2017 16:50:35 -0800
Subject: [PATCHv2 0/3] OF phandle nexus support + GPIO nexus
Message-ID: <20170118005038.9216-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is one small chunk of work related to DT overlays for expansion
boards. It would be good to have a way to expose #<list>-cells types of
providers through a connector in a standard way. So we introduce a way
to make "nexus" nodes for these types of properties to remap the consumer
number space to the other side of the connector's number space. It's
basically a copy of the interrupt nexus implementation, but without
the address space matching design and interrupt-parent walking.

The first patch implements a generic method to do this, and the second patch
adds a unit test for it. The third patch is more of an example than anything
else. It shows how we would modify frameworks to use the new API.

I wasn't certain what more to document, but I

Changes since v1:
 * Addition of optional pass-thru parameter
 * Reduction of strings passed to 1 instead of 3 (or 4 now)
 * Updated gpio patch for the new function signature
 * Updated test-case for new funciton signature and pass-thru parameter
 * Updated kernel-doc to be correct and highlighted difference between
   this API and of_parse_phandle_with_args()

Stephen Boyd (3):
  of: Support parsing phandle argument lists through a nexus node
  of: unittest: Add phandle remapping test
  gpio: Support gpio nexus dt bindings

 drivers/gpio/gpiolib-of.c                   |   4 +-
 drivers/of/base.c                           | 186 ++++++++++++++++++++++++++++
 drivers/of/unittest-data/testcases.dts      |  11 ++
 drivers/of/unittest-data/tests-phandle.dtsi |  25 ++++
 drivers/of/unittest.c                       | 120 ++++++++++++++++++
 include/linux/of.h                          |  12 ++
 6 files changed, 356 insertions(+), 2 deletions(-)

-- 
2.10.0.297.gf6727b0
