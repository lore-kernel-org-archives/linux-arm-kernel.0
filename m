From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Feb 2013 08:52:20 -0800
Subject: Getting your opinion about the best place to put one specific
 device driver...
In-Reply-To: <511B6140.90801@stericsson.com>
References: <511A0F11.1050608@stericsson.com>
 <201302121454.10231.arnd@arndb.de> <511A6D1E.50705@stericsson.com>
 <201302121741.31494.arnd@arndb.de>
 <20130213094552.GD3073@tbergstrom-lnx.Nvidia.com>
 <511B6140.90801@stericsson.com>
Message-ID: <20130213165219.GG7144@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jean-Nicolas GRAUX <jean-nicolas.graux@stericsson.com> [130213 01:52]:
> Le 02/13/2013 10:45 AM, Peter De Schrijver a ?crit :
> >>Correct, I try my best to avoid adding random stuff in there that might
> >>need a generic interface later. Tony already pointed out the similarity
> >>to the OMAP specific hwopbs feature, and whatever user interface we
> >>introduce for one should be generic enough to work on the other one as
> >>well, and ideally also on future ones to the degree that we can anticipate
> >>them today.
> >>
> >>I like the idea of making the in-kernel configuration part of this a
> >>pinctrl driver, which would already allow you to configure it through
> >>a custom device tree and no user interface at all.
> >>
> >Having done significant work with the OMAP3 hwobs feature, you really want a
> >userinterface. At least OMAP3 has limitations on which signal can be
> >monitored on which hwobs pin. This means that depending on the measurements
> >you want to do, you need to change the configuration. If you want to automate
> >several measurements, having a user interface (eg using debugfs), makes things
> >much easier. Also when using this for debugging, you probably will have to
> >experiment with which signals to monitor to rootcause the problem. Also then
> >having a userinterface will be much easier than modifying the devicetree
> >and rebooting the system.
> >
> Yep, that's true.

Yeah user space is the way to go for toggling the settings. For omap hwobs,
that all should be pretty close doable via debugfs with pinctrl-single.c +
the patches posted by Haojian to add debugfs write support.

Regards,

Tony
