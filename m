From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 21 Sep 2014 16:10:10 -0700
Subject: [PATCH 1/2] bus: brcmstb_gisb: register the fault code hook
In-Reply-To: <20140920151950.443b7ea9@free-electrons.com>
References: <1411155880-23447-1-git-send-email-f.fainelli@gmail.com>
 <1411155880-23447-2-git-send-email-f.fainelli@gmail.com>
 <20140920151950.443b7ea9@free-electrons.com>
Message-ID: <20140921231010.GN7362@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Sat, Sep 20, 2014 at 03:19:50PM +0200, Thomas Petazzoni wrote:
> On Fri, 19 Sep 2014 12:44:39 -0700, Florian Fainelli wrote:
> 
> > -void __init brcmstb_hook_fault_code(void)
> > +static int __init brcmstb_hook_fault_code(void)
> >  {
> >  	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
> >  			"imprecise external abort");
> > +	return 0;
> >  }
> > +arch_initcall(brcmstb_hook_fault_code)
> 
> I don't have the entire context, but if your platform is part of
> multi-platform, it means that regardless of which platform is actually
> booting your system, you will register your fault hook. Is this the
> intended behavior?
> 
> Generally speaking, in a multiplatform context, many arch_initcall()
> should have a conditional to check whether we're really on a platform
> where the initcall is needed.

Florian already sent v2, about which I already made a similar comment:

  https://lkml.org/lkml/2014/9/19/516

I believe Florian plans to move this into the platform device probe
function instead.

Brian
