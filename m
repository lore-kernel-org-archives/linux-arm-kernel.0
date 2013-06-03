From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 3 Jun 2013 09:51:08 +0200
Subject: [PATCH 02/10] clocksource: dw_apb_timer_of: add clock-handling
In-Reply-To: <20130603032219.GM11798@tarshish>
References: <201306030055.15413.heiko@sntech.de>
 <201306030056.37724.heiko@sntech.de> <20130603032219.GM11798@tarshish>
Message-ID: <201306030951.09468.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 3. Juni 2013, 05:22:19 schrieb Baruch Siach:
> Hi Heiko,
> 
> On Mon, Jun 03, 2013 at 12:56:37AM +0200, Heiko St?bner wrote:
> > Add the possibility to get the clock-frequency from a timer clock instead
> > of specifying it as dt property. Additionally also add the possibility
> > to also define a controlling periphal clock for the timer block.
> > 
> > The clock-frequency property is kept to act as fallback if no clocks
> > are specified.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  Documentation/devicetree/bindings/rtc/dw-apb.txt |   19 ++++++++++++++++
> >  drivers/clocksource/dw_apb_timer_of.c            |   26
> >  +++++++++++++++++++++- 2 files changed, 44 insertions(+), 1
> >  deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt
> > b/Documentation/devicetree/bindings/rtc/dw-apb.txt index
> > 93e2b0f..80ab1c1 100644
> > --- a/Documentation/devicetree/bindings/rtc/dw-apb.txt
> > +++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
> > 
> > @@ -5,9 +5,20 @@ Required properties:
> >  - reg: physical base address of the controller and length of memory
> >  mapped
> >  
> >    region.
> >  
> >  - interrupts: IRQ line for the timer.
> > 
> > +- either clocks+clock-names or clock-frequency properties
> > +
> > +Optional properties:
> > +- clocks	: list of clock specifiers, corresponding to entries in
> > +		  the clock-names property;
> > +- clock-names	: should contain "timer and "pclk" entries, matching
> > entries
> 
> Missing closing quotes around "timer".

thanks for finding ... will fix in the next run
