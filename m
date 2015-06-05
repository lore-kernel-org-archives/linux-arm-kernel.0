From: linux-arm@myspectrum.nl (Jeroen Hofstee)
Date: Fri, 05 Jun 2015 10:01:50 +0200
Subject: [PATCH] ARM: dts: AM35xx: fix system control module clocks
In-Reply-To: <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
 <1433172627-28052-1-git-send-email-t-kristo@ti.com>
 <556C8ED5.5050000@myspectrum.nl> <20150601173126.GY30984@atomide.com>
 <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
Message-ID: <5571576E.6020207@myspectrum.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,

On 01-06-15 19:44, Paul Walmsley wrote:
> The best way to make this work IMHO would be for us not to accept any new
> feature addition patches as long as there are warnings reported in the
> test results.  The only real exception that I would foresee is if those
> warnings are due to something outside of our control, e.g., a crappy
> bootloader, as I suspect the USB_OTG initiator warnings are for the
> CM-T3517.
>

I doubt this is related to the bootloader. I have the suspicion that is 
actually
a bug in linux but only triggered depending on whether the ROMcode setup
the USB OTG or not. Here is some data to backup my statement:

Linux booting without USB_OTG error trap
md 480022F0 1
480022f0: 0000032f                               /...
md 48002580 1
48002580: 0f00b7a2                               ....

bit USBOTG_PHY_RESET is 0 -> out of reset


USB_OTG sees memory hole
md 480022F0 1
480022f0: 0000030f    ....
md 48002580 1
48002580: 0f00c71e    ....

USBOTG_PHY_RESET is 1 -> still in reset when booting linux.

Does that match with how your am3517 boards boot?

Regards,
Jeroen
