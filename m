From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Jun 2016 05:23:59 -0700
Subject: Extcon build failure in next
In-Reply-To: <124460021.HZdfr0AOY2@wuerfel>
References: <20160630053705.GM28140@atomide.com> <3746939.q8kt0ym6m3@wuerfel>
 <20160630114911.GO28140@atomide.com> <124460021.HZdfr0AOY2@wuerfel>
Message-ID: <20160630122359.GP28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [160630 05:05]:
> On Thursday, June 30, 2016 4:49:12 AM CEST Tony Lindgren wrote:
> > > > Also I'm seeing:
> > > > 
> > > > drivers/extcon/extcon.c: In function 'extcon_register_notifier':
> > > > drivers/extcon/extcon.c:455:6: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > > >    if (idx >= 0) {
> > > >          ^
> > > 
> > > I don't see this one. Which compiler version do you use?
> > 
> > Looks like I'm currently using older arm-none-linux-gnueabi-gcc
> > (Sourcery CodeBench Lite 2014.05-29) 4.8.3 20140320 (prerelease).
> > I think the Debian compiler was not working few months ago and
> > I changed to something I had around.
> > 
> > Looks like the warning does not appear with arm-linux-gnueabihf-gcc
> > (Debian 6.1.1-3) 6.1.1 20160511.
> 
> You are certainly not the only one using gcc-4.7 or gcc-4.8, but
> they are known to produce more false postive -Wmaybe-uninitialized
> warnings and 4.9 or higher. I usually send patches for these warnings
> when gcc-6 finds them, and I have recently sent patches for all
> the warnings I got in allmodconfig with 4.9, but have no plans to
> do that for the older compilers.

OK thanks for the information, I'll change back to something newer
here again.

> I wonder whether we should just disable this warning with gcc-4.8
> by adding $(call cc-ifversion, -eq, 0408, -Wno-maybe-uninitialized)
> to the command line. However, gcc-4.7 does not let you turn off
> the warning at all, so the use of that is fairly limited.

That probably disables warnings also for real warnings too then :)

Tony
