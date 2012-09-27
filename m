From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Sep 2012 16:11:59 +0100
Subject: [PATCH 0/7] Next instalment of Device Tree work for ST-Ericsson
Message-ID: <1348758726-25336-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Contained in this patch are some serious clean-ups for HREF related
Device Tree code. We make clear definition between pre-v60 and post-
v60 HREFs with the creation of their own DTS files. We also start to
take out most of the device registration calls which were duplicated
to aid with step-by-step DT enablement. There are also some small
fixes for the Snowball DTS which were uncovered during this
enablement phase.

  arch/arm/boot/dts/dbx5x0.dtsi      |   12 +-
  arch/arm/boot/dts/href.dtsi        |  274 ++++++++++++++++++++++++++++++++++++
  arch/arm/boot/dts/hrefprev60.dts   |   31 ++++
  arch/arm/boot/dts/hrefv60plus.dts  |  210 +--------------------------
  arch/arm/boot/dts/snowball.dts     |    6 +-
  arch/arm/mach-ux500/board-mop500.c |   24 ----
  6 files changed, 318 insertions(+), 239 deletions(-)
