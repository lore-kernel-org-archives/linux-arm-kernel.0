From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Jan 2015 11:59:22 -0200
Subject: [PATCH] ARM: dts: imx51-babbage: Fix ULPI PHY reset modelling
In-Reply-To: <1420552459.2333.18.camel@pengutronix.de>
References: <1420478348-2754-1-git-send-email-fabio.estevam@freescale.com>
 <20150106124343.GM24511@dragon>
 <1420551365.2333.15.camel@pengutronix.de>
 <CAOMZO5Bn58O2Mr4SsBqWbiwecOKOiQMDDugLzi+aRVf+jOx=Sg@mail.gmail.com>
 <1420552459.2333.18.camel@pengutronix.de>
Message-ID: <CAOMZO5A32HOQkEP7_VQJ8_NhkR7kmFHQSqoO+Lnu+MG4o=X3zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 6, 2015 at 11:54 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

>> Actually the ULPI PHY reset is properly handled now. What is missing
>> is the USB Hub reset to be properly handled.
>>
> No it is not. A regulator isn't the proper abstraction for a reset at
> all. Even if you (ab)use the regulator drivers ability to toggle a reset
> GPIO.
> A ULPI PHY reset needs to be modeled as a GPIO reset attached to USB
> controller node. There is no other way to describe the hardware
> accurately.

The ULPI PHY is modelled as a GPIO reset via reset-gpios property.
This is documented at
Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt:

- reset-gpios: Should specify the GPIO for reset.

This is the property we use right now for resetting the ULPI PHY.
