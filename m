From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 12 May 2018 13:13:36 +0200
Subject: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
 <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
Message-ID: <1937901.oyadCYFYNo@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 4, 2018 8:50:52 PM CEST Oleksij Rempel wrote:
> Hallo Andrew,
> I need your ACK or NACK for this patch.
> 
> This function is used to configure external PMIC to interpret
> signal which will be triggered by pm_power_off as power off.
> Since same signal can be used for stand by, I linked PMIC configuration
> with pm_power_off_prepare to avoid possible conflicts.
> 
> On Mon, Mar 05, 2018 at 11:25:20AM +0100, Oleksij Rempel wrote:
> > Export pm_power_off_prepare. It is needed to implement power off on
> > Freescale/NXP iMX6 based boards with external power management
> > integrated circuit (PMIC).
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  kernel/reboot.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index e4ced883d8de..350be6baa60d 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -49,6 +49,7 @@ int reboot_force;
> >   */
> >  
> >  void (*pm_power_off_prepare)(void);
> > +EXPORT_SYMBOL(pm_power_off_prepare);

Why not EXPORT_SYMBOL_GPL() ?

> >  
> >  /**
> >   *	emergency_restart - reboot the system
> 
> 
