From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 4 May 2018 13:49:56 -0700
Subject: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
 <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
Message-ID: <20180504134956.36dc72a253d03e94a517a867@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 May 2018 20:50:52 +0200 Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hallo Andrew,
> I need your ACK or NACK for this patch.
> 
> This function is used to configure external PMIC to interpret
> signal which will be triggered by pm_power_off as power off.
> Since same signal can be used for stand by, I linked PMIC configuration
> with pm_power_off_prepare to avoid possible conflicts.
> 
> ...
>
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -49,6 +49,7 @@ int reboot_force;
> >   */
> >  
> >  void (*pm_power_off_prepare)(void);
> > +EXPORT_SYMBOL(pm_power_off_prepare);
> >  

OK by me, but it's more of a Rafael thing.
