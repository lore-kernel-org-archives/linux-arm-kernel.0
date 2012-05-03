From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 3 May 2012 19:14:03 +0300
Subject: [PATCHv4 8/8] ARM: OMAP4: PM: Added option for enabling OSWR
In-Reply-To: <CAORVsuWVMa-_T4JuXTwT6sePhp0mPoE9U_xhwA28AULveeiM+w@mail.gmail.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
 <1334913591-26312-9-git-send-email-t-kristo@ti.com>
 <CAORVsuWVMa-_T4JuXTwT6sePhp0mPoE9U_xhwA28AULveeiM+w@mail.gmail.com>
Message-ID: <1336061643.2149.213.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


<clip>

> > @@ -274,8 +278,16 @@ static int __init pm_dbg_init(void)
> >
> >        pwrdm_for_each(pwrdms_setup, (void *)d);
> >
> > -       (void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
> > -                                  &enable_off_mode, &pm_dbg_option_fops);
> > +       if (cpu_is_omap34xx())
> > +               (void) debugfs_create_file("enable_off_mode",
> > +                       S_IRUGO | S_IWUSR, d, &enable_off_mode,
> > +                       &pm_dbg_option_fops);
> Is the enable_off_mode entry needed on other OMAP platorms (OMAP<3)?

Actually I am not sure, I've never used OMAP2. It looks like@least
the kernel does not support off-mode for OMAP2, but according to TRM it
might be possible to support it on HW.

-Tero
