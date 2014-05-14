From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 14 May 2014 10:39:31 -0700
Subject: [PATCH] bus/omap_l3: avoid sync initcall for modules
In-Reply-To: <20140513162731.GD16837@atomide.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-6-git-send-email-arnd@arndb.de>
 <20140512222006.GI5668@atomide.com> <177753046.dmVvfiu3Rn@wuerfel>
 <20140513162731.GD16837@atomide.com>
Message-ID: <20140514173931.GA14003@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 09:27:33AM -0700, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [140513 08:13]:
> > On Monday 12 May 2014 15:20:07 Tony Lindgren wrote:
> > > 
> > > How about instead let's add this into include/linux/module.h
> > > like we have for other initcalls:
> 
> I mean include/linux/init.h naturally..
>  
> > > #define postcore_initcall(fn)           module_init(fn)
> > > 
> > > There may be others missing too from there. BTW, this driver
> > > might be few of the drivers that actually might need to be
> > > initialized early for debugging to catch bad access from
> > > other drivers.
> > 
> > There is a comment above those defines saying:
> > 
> > /* Don't use these in loadable modules, but some people do... */
> > 
> > so I'm not sure if adding more would be appreciated.
> > 
> > 	Arnd
> 
> Well "some" in that comment is probably an understatement :)
> 
> $ git grep _initcall drivers/ | wc -l
> 737
> 
> I did not look what percentage has tristate in the Kconfig,
> but that might keep some people from making loadable drivers.
> 
> Greg, is the following patch something you may want to
> consider picking up?

Sure, is this needed to fix issues in 3.15-final, or is 3.16-rc1 ok?

thanks,

greg k-h
