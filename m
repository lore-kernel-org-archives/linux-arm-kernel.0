From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Sep 2013 20:51:58 +0100
Subject: device tree binding documentation outdated
Message-ID: <20130926195158.GS12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can someone please point me at the current documentation for the
iMX6DL pinctrl bindings?

I mean the stuff which looks like this:

#define MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0           0x1e8 0x5b8 0x858 0x2 0x0

which clearly doesn't match:

Required properties for pin configuration node:
- fsl,pins: two integers array, represents a group of pins mux and config
  setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is a
  pin working on a specific function, which consists of a tuple of
  <mux_reg conf_reg input_reg mux_val input_val>.  CONFIG is the pad setting
  value like pull-up on this pin.

I thought DT was supposed to make bringing up support on new hardware
easier, but without documentation, I'm frankly stuffed with the cubox-i,
because it's impossible to work out what the right pinctrl settings
should be from what seems to be an undocumented pile of random numbers
stuffed into DT.

Thanks.
