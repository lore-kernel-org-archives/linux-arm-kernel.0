From: tony@atomide.com (Tony Lindgren)
Date: Fri, 03 Feb 2012 12:54:58 -0800
Subject: [PATCH 0/2] Initial DT only generic pinctrl-simple driver
Message-ID: <20120203205049.4089.74610.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's finally something that mostly works for omap2/3/4, this
is now using a minimal subset of the mux bindings posted earlier
by Stephen Warren.

No support for alternative modes at this point, bunch of features
missing.. And the map allocation is copying things unnecessarily
right now. But basically this is what I promised to post few
weeks ago as pinmux-simple.

Hmm, how should we mark the pinmux hogs in .dts?

Regards,

Tony

---

Tony Lindgren (2):
      pinmux: Export pinmux_register_mappings for pinmux modules
      pinctrl: Add simple pinmux driver using device tree data


 .../devicetree/bindings/pinmux/pinctrl-simple.txt  |   62 +
 drivers/pinctrl/Kconfig                            |    6 
 drivers/pinctrl/Makefile                           |    1 
 drivers/pinctrl/pinctrl-simple.c                   | 1286 ++++++++++++++++++++
 drivers/pinctrl/pinmux.c                           |    3 
 5 files changed, 1357 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinmux/pinctrl-simple.txt
 create mode 100644 drivers/pinctrl/pinctrl-simple.c

-- 
Signature
