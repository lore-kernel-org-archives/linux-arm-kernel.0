From: zhangwm@marvell.com (Neil Zhang)
Date: Thu, 3 Jul 2014 20:05:04 -0700
Subject: [PATCH] ARM: remove redundant code in machine_halt
In-Reply-To: <9034CBD80F070943B59700D7F8149ED9A0875745@SC-VEXCH4.marvell.com>
References: <1399441823-9907-1-git-send-email-zhangwm@marvell.com>
 <9034CBD80F070943B59700D7F8149ED9A0875745@SC-VEXCH4.marvell.com>
Message-ID: <9034CBD80F070943B59700D7F8149ED90182308483@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Neil Zhang
> Sent: 2014?5?14? 15:52
> To: Neil Zhang; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Cc: rmk+kernel at arm.linux.org.uk
> Subject: RE: [PATCH] ARM: remove redundant code in machine_halt
> 
> > -----Original Message-----
> > From: Neil Zhang [mailto:zhangwm at marvell.com]
> > Sent: 2014?5?7? 13:50
> > To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> > Cc: rmk+kernel at arm.linux.org.uk; Neil Zhang
> > Subject: [PATCH] ARM: remove redundant code in machine_halt
> >
> > There is no need to call local_irq_disable twice.
> >
> > Signed-off-by: Neil Zhang <zhangwm@marvell.com>
> > ---
> >  arch/arm/kernel/process.c |    1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c index
> > 81ef686..18cfce4 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -195,7 +195,6 @@ void machine_halt(void)
> >  	local_irq_disable();
> >  	smp_send_stop();
> >
> > -	local_irq_disable();
> >  	while (1);
> >  }
> >
> > --
> > 1.7.9.5
> 
> Any comments?
> 

Ping!

> Best Regards,
> Neil Zhang

Best Regards,
Neil Zhang
