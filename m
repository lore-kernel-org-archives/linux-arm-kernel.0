From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 8 Apr 2013 13:11:13 +0200
Subject: [RFC 4/5] RTC: rtc-at91sam9: add device-tree support
In-Reply-To: <20130408103847.GE25605@localhost>
References: <20130407150938.GA25605@localhost>
 <1365347572-14972-1-git-send-email-jhovold@gmail.com>
 <1365347572-14972-4-git-send-email-jhovold@gmail.com>
 <20130408073807.GQ20693@game.jcrosoft.org>
 <20130408090023.GC25605@localhost> <51629472.3070404@atmel.com>
 <20130408103847.GE25605@localhost>
Message-ID: <20130408111113.GX20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:38 Mon 08 Apr     , Johan Hovold wrote:
> On Mon, Apr 08, 2013 at 11:57:06AM +0200, Nicolas Ferre wrote:
> > On 04/08/2013 11:00 AM, Johan Hovold :
> > > On Mon, Apr 08, 2013 at 09:38:07AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > >> On 17:12 Sun 07 Apr     , Johan Hovold wrote:
> > >>> Add device-tree support.
> > >>>
> > >>> The AT91 RTT can be used as an RTC if the atmel,at91-rtt-as-rtc-gpbr
> > >>> property is present and set to the general-purpose backup register to
> > >>> use to store the RTC time base.
> > >>>
> > >>> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> > >>> ---
> > >>>  .../devicetree/bindings/rtc/rtc-at91sam9.txt       | 19 ++++++++++++
> > >>>  drivers/rtc/rtc-at91sam9.c                         | 36 +++++++++++++++++++++-
> > >>>  2 files changed, 54 insertions(+), 1 deletion(-)
> > >>>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt > >>>
> > >>> diff --git
> > >>> a/Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt
> > >>> b/Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt > >>> new
> > >>> file mode 100644
> > >>> index 0000000..0f54988
> > >>> --- /dev/null
> > >>> +++ b/Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt
> > >>> @@ -0,0 +1,19 @@
> > >>> +Atmel AT91 RTT as RTC
> > >>> +=====================
> > >>> +
> > >>> +Required properties:
> > >>> +- compatible: Should be "atmel,at91sam9260-rtt"
> > >>> +- reg: Should contain register location and length
> > >>> +- interrupts: Should contain interrupt for the RTT which is the IRQ line
> > >>> +  shared across all System Controller members.
> > >>> +- atmel,rtt-as-rtc-gpbr: Should contain the backup-register to use to store
> > >>> +  the RTC time base
> > >>> +
> > >>> +Example:
> > >>> +
> > >>> +rtt at fffffd20 {
> > >>> +		compatible = "atmel,at91sam9g45-rtt", "atmel,at91sam9260-rtt";
> > 
> > No, there is no visible difference between the sam9g45 RTT and the
> > sam9260 one. So the most precise compatibility string is still sam9260.
> > If one day we feel the need for a advanced feature that exists on a more
> > recent SoC, we have the possibility to add it at that time...
> 
> Yes, this should be just "atmel,at91sam9260-rtt" to follow the current
> practise in AT91. However, as I mentioned in an earlier mail one could
> interpret
> 
> 	"The first string in the list specifies the exact device that
> 	the node represents in the form "<manufacturer>,<model>". The
> 	following strings represent other devices that the device is
> 	compatible with.
> 
> 	For example, the Freescale MPC8349 System on Chip (SoC) has a
> 	serial device which implements the National Semiconductor
> 	ns16550 register interface. The compatible property for the
> 	MPC8349 serial device should therefore be: compatible =
> 	"fsl,mpc8349-uart", "ns16550". In this case, fsl,mpc8349-uart
> 	specifies the exact device, and ns16550 states that it is
> 	register-level compatible with a National Semiconductor 16550
> 	UART."
> 
> 	http://www.devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property
> 
> to mean that the compatible property should always be exact SoC-IP
> followed by the first (most generic) compatible one.
here you describe compatible IP not drivers implementation

they are both usuart IP that are compatible at IP level.

Best Regards,
J.
