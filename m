From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 17 Aug 2011 12:47:26 +0100
Subject: [RFC PATCH 0/2] WIP: generic OF pinmux binding
Message-ID: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid going too far in the wrong direction I thought I'd post what I
have so far for a generic pinmux binding.  Essentially it's just
Stephen's nvidia binding but with the nvidia specifics abstracted out so
the common loop can be used for other platforms.  This approach works
nicely for picoxcell too.

For more esoteric bindings, such as pull strength, these could be
handled in the platform specific configuration function.

This doesn't address the runtime muxing that LinusW's set of patches do,
and I'm not sure how to handle that.

Jamie Iles (1):
  of: add a generic pinmux helper

Stephen Warren (1):
  arm/tegra: Add device tree support to pinmux driver

 arch/arm/mach-tegra/pinmux.c |  240 ++++++++++++++++++++++++++++++++++++++++++
 drivers/of/Kconfig           |    5 +
 drivers/of/Makefile          |    1 +
 drivers/of/of_pinmux.c       |   80 ++++++++++++++
 include/linux/of_pinmux.h    |   67 ++++++++++++
 5 files changed, 393 insertions(+), 0 deletions(-)
 create mode 100644 drivers/of/of_pinmux.c
 create mode 100644 include/linux/of_pinmux.h

-- 
1.7.4.1
