From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 18 Feb 2014 15:15:36 +0100
Subject: [PATCH 0/3] dtc handling unreferenced nodes and an imx board dts
Message-ID: <10555869.uLtJmrqZh3@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After showcasing my dtc change as RFC before, this series shows essentially
where I want to go with the whole change - adding support for our ereaders
without duplicating the generic pinconfig nodes :-) . And also provides with
the dt change a user for the dtc flag addition.

That being said, the dtc change might need a bit more review and I also don't
know if it should go through the scripts/dtc variant like this or some
upstream and how the *_shipped files should be handled.

The patchset is done against linux-next from today, which includes both the
pingroups moved to the individual board files and the bindings for the zforce
touchscreen.

Heiko Stuebner (3):
  dtc: add ability to make nodes conditional on them being referenced
  ARM: dts: imx6sl: move pingroups back into soc dtsi
  ARM: dts: imx6sl: add board file for BQ Cervantes

 arch/arm/boot/dts/imx6sl-bq-cervantes.dts | 133 +++++++++++++++++++++
 arch/arm/boot/dts/imx6sl-evk.dts          | 181 -----------------------------
 arch/arm/boot/dts/imx6sl.dtsi             | 185 ++++++++++++++++++++++++++++++
 scripts/dtc/checks.c                      |   2 +
 scripts/dtc/dtc-lexer.l                   |   7 ++
 scripts/dtc/dtc-parser.y                  |   5 +
 scripts/dtc/dtc.h                         |   4 +
 scripts/dtc/flattree.c                    |   3 +
 scripts/dtc/livetree.c                    |  14 +++
 9 files changed, 353 insertions(+), 181 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6sl-bq-cervantes.dts

-- 
1.8.5.3
