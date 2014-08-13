From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Aug 2014 16:29:28 -0700
Subject: [PATCH 0/3] ARM: l2c: cache size parsing through device tree
Message-ID: <1407972571-8986-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds support for specifying the L2 cache size through Device
Tree using the ePAPR standard 'cache-size' and 'cache-sets' properties.

The rationale behind these patches is to support Broadcom's BCM63138 DSL SoC
which comes out of reset with an invalid cache way-size specified in its L2C
auxiliary register.

For the third patch I took the approach of a helper function that can be called
by the 3 different of_parse functions that we have currently.

Thanks!

Florian Fainelli (3):
  ARM: l2c: enforce use of cache-level property
  ARM: l2c: order optional properties in alphabetical order
  ARM: l2c: parse 'cache-size' and 'cache-sets' properties

 Documentation/devicetree/bindings/arm/l2cc.txt |  4 +-
 arch/arm/mm/cache-l2x0.c                       | 68 ++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)

-- 
1.9.1
