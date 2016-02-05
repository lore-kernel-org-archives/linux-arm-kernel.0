From: contact@paulk.fr (Paul Kocialkowski)
Date: Fri,  5 Feb 2016 19:42:17 +0100
Subject: [PATCH v2 0/6] LG Optimus Black (P970) codename sniper support and
 lp872x improvements
Message-ID: <1454697741-8687-1-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
