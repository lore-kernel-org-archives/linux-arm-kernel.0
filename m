From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Dec 2015 07:36:31 -0800
Subject: [PATCH 2/3] wlcore/wl12xx: spi: add device tree support
In-Reply-To: <567AB1CB.1050203@compulab.co.il>
References: <1450859744-9948-1-git-send-email-uri.mashiach@compulab.co.il>
 <1450859744-9948-3-git-send-email-uri.mashiach@compulab.co.il>
 <567A76B5.70605@ti.com> <567AB1CB.1050203@compulab.co.il>
Message-ID: <20151223153630.GK2793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uri Mashiach <uri.mashiach@compulab.co.il> [151223 06:38]:
> On 12/23/2015 12:25 PM, Grygorii Strashko wrote:
> 
> >>+                        that services interrupts for this device
> >>+- vwlan-supply :        Point the node of the regulator that controls the wl1271 chip WLAN_EN pin
> >
> >Pls, use gpio if this is required just to toggle WLAN_EN pin.
> >
> >[ti,] power-gpio or en-gpio
> >
> >
> 
> The controller's power might need toggling in some board implementation.
> Maybe GPIO and regulator should be implemented?

Yes a regulator for wlcore is best here because to properly control it
and the wait needed.

Regards,

Tony
