From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 23 Nov 2015 16:07:00 +0100
Subject: [PATCH 0/3] prepare GPC driver for multiple domain support
Message-ID: <1448291223-9938-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series reworks the i.MX6 GPC driver to support multiple power
domains. The main issue is the DT binding which is not sufficient
to support more than the single "PU" domain present on MX6Q.

This series introduces a new DT binding, which is more flexible and
allows to model different numbers of power domains with a single
unified binding. The driver is then reworked to split things a bit
more cleanly and work with the new binding. Compatibility for the
currently supported i.MX6Q/DL binding is kept, but deprecated, so
existing DTBs continue to work.

Regards,
Lucas

Lucas Stach (3):
  dt-bindings: add multidomain support to i.MX GPC DT binding
  ARM: imx6: rework GPC to support mutiple power domains
  ARM: imx6: adopt DT to new GPC binding

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  81 ++--
 arch/arm/boot/dts/imx6qdl.dtsi                     |  33 +-
 arch/arm/mach-imx/gpc.c                            | 435 ++++++++++++++++-----
 3 files changed, 407 insertions(+), 142 deletions(-)

-- 
2.6.2
