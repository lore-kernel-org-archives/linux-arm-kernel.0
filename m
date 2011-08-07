From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 7 Aug 2011 13:15:33 +0200
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
Message-ID: <20110807111533.GK31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 06:07:15PM -0500, Matt Sealey wrote:
> 
> If you think the solution is not so great due to the complexity of
> describing the IOMUX settings, including the pad definitions as binary
> blobs or so such that Linux can read them out, please feel free to
> take the hint and go nag the U-Boot developers at Linaro to go put
> this in the right place - in U-Boot. The device tree is absolutely not
> the place to define pin multiplexing settings for later parsing and
> configuration by the Kernel. They should have been set up correctly
> already, and they should not be being *changed* based on an arbitrary
> configuration file. Consider that the i2c pin definitions you used in
> your example *absolutely will not change* for the lifetime of the
> board, and in most cases, will have been set up by U-Boot anyway.
> There is no point telling Linux to copy in identical settings again.
> What's missing from U-Boot and set up by Linux, should be moved out of
> Linux back into U-Boot.

System on module vendors have quite a different point of view here.
On these systems the functionality of a pin differs depending on the
baseboard they are attached to. Still you want to be able to use the
same bootloader for all usecases. Putting the pinmux into the bootloader
would mean that each user of these systems has to flash and maintain
a custom bootloader.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
