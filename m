From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 28 Feb 2016 11:20:23 +0100
Subject: [PATCH v3 0/4] LG Optimus Black codename sniper support series
Message-ID: <1456654827-11349-1-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series requires lp872x regulator patches from the regulator tree[0] to work
at run-time but can be applied as-is.

Changes since v2:
* Add USB OTG support
* Add TWL4030 keypad support
* Drop references to P970 since other devices (e.g. KU5900) are supported too

Changes since v1:
* Remove lp872x patches that were accepted already from the series
* Explain why removing the invalid DVS GPIO warning is enough
* Update copyright notice on omap3-sniper.dts
* Rename the devicetree property for the enable GPIO to enable-gpios
* Rename function to enable GPIO to lp872x_hw_enable
* Add enable delays after requesting the enable GPIO
* Use IOPAD macros for pinmux description
* Mux the dp3t uart selection pins to gpio
* Restrict not-reset gpio controllers to only avoid reset when needed

This series introduces support for the LG Optimus Black, as described in the
patch adding devicetree support for the device.

In order to power the external mmc (mmc1), the lp872x regulator is used.
Its code had to be improved a bit to work on the device.

Note that the patch adding devicetree support for the device requires the
changes applied to the lp872x regulator, so all this is sent in one series
despite the fact they're different parts of the code.

[0]: https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/log/?h=topic/lp872x
