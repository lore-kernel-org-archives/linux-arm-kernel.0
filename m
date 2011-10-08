From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2011 15:00:11 +0200
Subject: [PATCH 08/26] ARM: pxa: move z2 to generic cpu_suspend
In-Reply-To: <CAMPhdO97bJZ1FRHUq_VHQ8oHyY7U4ay-jv5Ft+gunRwtBvz8qw@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<201110071156.38283.arnd@arndb.de>
	<CAMPhdO97bJZ1FRHUq_VHQ8oHyY7U4ay-jv5Ft+gunRwtBvz8qw@mail.gmail.com>
Message-ID: <14032344.tng7XWeaFg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 October 2011 20:37:53 Eric Miao wrote:
> >>
> >>  #ifdef CONFIG_PM
> >> +extern void pxa27x_cpu_pm_enter(suspend_state_t state);
> >> +
> >>  static void z2_power_off(void)
> >>  {
> >>         /* We're using deep sleep as poweroff, so clear PSPR to ensure that
> >
> > You really shouldn't have an extern declaration in a .c file. Otherwise
> > looks good to me.
> 
> How about this one?

Yes, looks good as far as I can tell (I still don't quite understand how the
cpu power management all fits together, but I don't see anything wrong with
it either.

Acked-by: Arnd Bergmann <arnd@arndb.de>
