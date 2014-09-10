From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 10 Sep 2014 14:46:15 +0200
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <20140905121316.GI30401@n2100.arm.linux.org.uk>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201409051338.40988@pali>
 <20140905121316.GI30401@n2100.arm.linux.org.uk>
Message-ID: <20140910124615.GA466@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2014-09-05 13:13:16, Russell King - ARM Linux wrote:
> On Fri, Sep 05, 2014 at 01:38:40PM +0200, Pali Roh?r wrote:
> > On Wednesday 18 June 2014 18:54:24 Pali Roh?r wrote:
> > > -	if (!mdesc)
> > > +	if (mdesc)
> > > +		machine_name = of_flat_dt_get_machine_name();
> > > +	else
> > >  		mdesc = setup_machine_tags(__atags_pointer,
> > > __machine_arch_type); machine_desc = mdesc;
> > > -	machine_name = mdesc->name;
> > > +	if (!machine_name)
> > > +		machine_name = mdesc->name;
> > > 
> > >  	if (mdesc->reboot_mode != REBOOT_HARD)
> > >  		reboot_mode = mdesc->reboot_mode;
> > 
> > So, do you really want to break userspace which reading file 
> > /proc/cpuinfo (after migration from boardcode --> DT)?
> > 
> > I still do not see reason for that. And only this one file is 
> > problematic...
> 
> Sorry, I just don't give a damn about your whinging about this.  I've
> made the situation perfectly clear.  Your patch will not be accepted.

Linus made it pretty clear that regressions are not accepted. 

You are an arm maintainer and there is regression in n900 that broke userspace.

How do you solve it?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
