From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 11:22:08 +0000
Subject: mfd: Implement devicetree support for AB8500 Btemp
In-Reply-To: <504EFA0F.2090102@stericsson.com>
References: <CAB4BAktQz5MY_AHHWUAhRp7HtEzC3v8uFbP0enx1b7ibJLoZ4Q@mail.gmail.com>
 <201209101401.06859.arnd@arndb.de> <504EFA0F.2090102@stericsson.com>
Message-ID: <201209111122.08713.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 September 2012, Rajanikanth HV wrote:
> >> +Supplied-to:
> >> +     This shall be power supply class dependency where in the
> runtime battery
> >> +     properties will be shared across fuel guage and charging
> algorithm driver.
> >
> > I probably don't understand enough of this, but shouldn't the other
> devices
> > that are supplied by this have a reference to this node rather than doing
> > it this way around? Why use strings here instead of phandles?
> 
> This is a logical binding w.r.t power supply event change
> across energy-management-module drivers where in runtime battery
> properties are shared along with uevent notification.
> ref: di->btemp_psy.external_power_
> changed =
>      ab8500_btemp_external_power_changed;
>      ref: ab8500_btemp.c
> 
> Need for this property:
>  btemp, fg and charger updates power-supply properties
>  based on the events listed above.
>  Event handler invokes power supply change notifier
>  which in-turn invokes registered power supply class call-back
>  based on the 'supplied_to' string.
>  ref:
>    power_supply_changed_work(..) ./drivers/power/power_supply_core.c
> 
> In this case how to approach through phandle?
> ============================
> 

Sorry, I really tried, but I cannot make sense of what you wrote
there. Can you try again and describe in full English sentences
how the hardware blocks are connected and what their purpose is?

	Arnd
