From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Sat, 5 May 2018 09:01:47 +0200
Subject: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180504134956.36dc72a253d03e94a517a867@linux-foundation.org>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
 <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
 <20180504134956.36dc72a253d03e94a517a867@linux-foundation.org>
Message-ID: <20180505070147.epsrglnypm72jr5u@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving Rafael from Cc to To.

Hi Rafael,

can you please help here?
I need your ACK or NACK for this patch.

On Fri, May 04, 2018 at 01:49:56PM -0700, Andrew Morton wrote:
> On Fri, 4 May 2018 20:50:52 +0200 Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Hallo Andrew,
> > I need your ACK or NACK for this patch.
> > 
> > This function is used to configure external PMIC to interpret
> > signal which will be triggered by pm_power_off as power off.
> > Since same signal can be used for stand by, I linked PMIC configuration
> > with pm_power_off_prepare to avoid possible conflicts.
> > 
> > ...
> >
> > > --- a/kernel/reboot.c
> > > +++ b/kernel/reboot.c
> > > @@ -49,6 +49,7 @@ int reboot_force;
> > >   */
> > >  
> > >  void (*pm_power_off_prepare)(void);
> > > +EXPORT_SYMBOL(pm_power_off_prepare);
> > >  
> 
> OK by me, but it's more of a Rafael thing.
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180505/28f953ea/attachment-0001.sig>
