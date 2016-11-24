From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 24 Nov 2016 02:25:26 -0800
Subject: [PATCH 0/2] OF phandle nexus support + GPIO nexus
Message-ID: <20161124102529.20212-1-stephen.boyd@linaro.org>
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

Stephen Boyd (3):
  of: Support parsing phandle argument lists through a nexus node
  of: unittest: Add phandle remapping test
  gpio: Support gpio nexus dt bindings

 drivers/gpio/gpiolib-of.c                   |   5 +-
 drivers/of/base.c                           | 146 ++++++++++++++++++++++++++++
 drivers/of/unittest-data/testcases.dts      |  11 +++
 drivers/of/unittest-data/tests-phandle.dtsi |  24 +++++
 drivers/of/unittest.c                       | 124 +++++++++++++++++++++++
 include/linux/of.h                          |  14 +++
 6 files changed, 322 insertions(+), 2 deletions(-)

-- 
2.10.0.297.gf6727b0
