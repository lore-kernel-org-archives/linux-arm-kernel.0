From: lukma@denx.de (Lukasz Majewski)
Date: Thu, 30 Nov 2017 01:45:04 +0100
Subject: [PATCH v3 0/6] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <20171116232239.16823-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
Message-ID: <20171130004510.23887-1-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for Liebherr's BK3 board, being
a derivative of TS72XX design.

This patchset consists of following patches:

- ts72xx.[c|h] cosmetic cleanup/improvement
- Rewrite ts72xx.c to be reusable by bk3
- The Liebherr's BK3 board has been added with re-using code of
  ts72xx.c (detalied list of changes can be found in patch 6/6)

This series applies on top of v4.14

Lukasz Majewski (6):
  ARM: ep93xx: ts72xx: Use DEFINE_RES_MEM macros where applicable
  ARM: ep93xx: ts72xx: Provide include guards for ts72xx.h file
  ARM: ep93xx: ts72xx: Rewrite ts72xx_register_flash() to accept
    parameters
  ARM: ep93xx: ts72xx: Rewrite map IO code to be reusable
  ARM: ep93xx: ts72xx: cosmetic: Add some description to ts72xx code
  ARM: ep93xx: ts72xx: Add support for BK3 board - ts72xx derivative

 MAINTAINERS                   |   6 ++
 arch/arm/mach-ep93xx/Kconfig  |   7 ++
 arch/arm/mach-ep93xx/ts72xx.c | 222 +++++++++++++++++++++++++++++++++++-------
 arch/arm/mach-ep93xx/ts72xx.h |   9 ++
 arch/arm/tools/mach-types     |   1 +
 5 files changed, 211 insertions(+), 34 deletions(-)

-- 
2.11.0
