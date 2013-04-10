From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 10 Apr 2013 05:11:31 +0000
Subject: [RFC PATCH 3/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
In-Reply-To: <20130409163459.GJ10155@atomide.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-4-git-send-email-hvaibhav@ti.com>
 <20130408172936.GQ10155@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EC47BB2@DBDE01.ent.ti.com>
 <20130409163459.GJ10155@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC4A236@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Tuesday, April 09, 2013 10:05 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; khilman at linaro.org; paul at pwsan.com;
> Nayak, Rajendra; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC PATCH 3/3] ARM: OMAP2+: Add command line parameter
> for debugSS module control
> 
> * Hiremath, Vaibhav <hvaibhav@ti.com> [130409 01:12]:
> > > From: Tony Lindgren [mailto:tony at atomide.com]
> > >
> > > I suggest you just make this part into a standard DT only
> > > device driver. That way the command line parsing and clock
> > > enabling can happen the normal way.
> > >
> >
> > That?s good idea, as we are moving towards DT only boot support.
> > Also, are you suggesting to have both command-line param and DT
> > Property for this?
> >
> >
> > > Is there any reason why this could not be a loadable module?
> > >
> >
> > Because we want to keep it enabled before late_initcall. As part of
> late_initcall
> > Clock/hwmod framework will start disabling unused modules, which will
> impact the
> > Debugs as well. Consider the case where this debugss is loaded as a
> module, the user
> > Will loose the JTAG connection until the module is loaded; and once
> module is
> > Loaded, he has to again re-connect to the debugss.
> 
> It will get run before late_initcall if compiled in. Sounds
> like there are no issues also make it work as a loadable module
> as needed.
> 
Agreed on making it as a module.

But do you think we should allow it as a loadable module (M) as well, 
as user will loose Connectivity to JTAG during boot.
Another perspective here would be, user can insert the module and
Get JTAG connectivity, which also seems ok to me.

Can you also confirm on having command line argument? I think
We can only live with DT based approach, right?

Thanks,
Vaibhav 
