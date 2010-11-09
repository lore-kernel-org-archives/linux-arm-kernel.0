From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 09 Nov 2010 18:46:47 +0100
Subject: at91sam9g45 USB OTG support?
In-Reply-To: <AANLkTi=8-nOGxLOw-Thvc7WaKwMg2cyC3h01SF0kZFL7@mail.gmail.com>
References: <AANLkTi=8-nOGxLOw-Thvc7WaKwMg2cyC3h01SF0kZFL7@mail.gmail.com>
Message-ID: <4CD98907.1060709@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/11/2010 22:09, Rob Emanuele :
> Greetings,
> 
> We've been developing a at91sam9g45 product and it is finally available at:
> https://www.crystalfontz.com/product/CFA910.html

Very nice platform!

> We are looking into supporting USB OTG on this device as the 'g45 has
> the USB host/device port.  As far at I can tell Atmel or anyone else
> working on this platform has not made full use of this as an OTG
> device.

Indeed, it is not done for the moment...

>  I haven't found support in the USB or the OTG code for
> reading the USB ID line to determine host or device mode.

I am not sure USB ID is well supported by consumer cable providers and
is a reliable way to determine host or device mode.

> Am I missing something or is that an area that needs some code written for it?

Anyway, using this port as host or device is a matter of
1/ driving or not VBUS pin
2/ dealing with loading the gadget driver (as the "Enable" of the usba
IP is responsible for swithing to device mode).

I think that determining if the port shall be used in host or device
mode can be asked through the GUI... But note that I am not an USB expert...
-- 
Nicolas Ferre
