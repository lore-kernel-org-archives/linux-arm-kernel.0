From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 18 Oct 2012 16:33:13 +0000
Subject: [PATCH 2/3] RTC: omap-rtc: enable pm_runtime
In-Reply-To: <50802C20.9040408@gmail.com>
References: <1350575631-15523-1-git-send-email-zonque@gmail.com>
 <1350575631-15523-2-git-send-email-zonque@gmail.com>
 <50802A87.9010409@ti.com> <50802C20.9040408@gmail.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB43BD9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 21:49:44, Daniel Mack wrote:
> On 18.10.2012 18:12, Vaibhav Hiremath wrote:
> > 
> > 
> > On 10/18/2012 9:23 PM, Daniel Mack wrote:
> >> This is needed as preparation for platforms where using pm runtime usage
> >> is mandatory.
> >>
> >> Signed-off-by: Daniel Mack <zonque@gmail.com>
> > 
> > It looks like, you just duplicated effort here.
> > RTC patches have been already submitted quite some time back for AM33xx,
> > probably you missed to do google before spending time on this.
> > 
> > Patch Series -
> > http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg23253.html
> 
> Heh, damn :) I would have thought that so shortly after the merge
> window, that code either went in already or is yet missing. Oh well.
> 
> > Denial,
> > It would be really helpful if you could test these patches and ack them.
> 
> Ok, will do tomorrow. What's missing there is support for writing to the
> OMAP_RTC_OSC_REG (path 3/3 in my series). Would like me to rebase the
> functionality? I need thatkind of setup for my board ...
> 
> 

This is bit tricky and required more discussion before merging it, 
let me reopen the old discussion which I had started some time back -


RTC OSC clock is required to configure clocksource systemtimer for the 
kernel, and it is important when you get into PM related features.

Please refer the below commit for more reference,

http://marc.info/?l=u-boot&m=135057734713796&w=2


> > Just FYI, we have bunch of parallel activities going inside team to
> > upstream all the patches/module/drivers/features, so to avoid such
> > duplication of effort, I suggest you to google for the patches or ping
> > on mailing list.
> 
> Yes, it's more difficult to participate in the AM33xx code than in other
> platforms. I'm not complaining about other doing all the hard work
> though, it's just a little different.
> 

No its not. Its good that we have so many developers contributing, so now 
its just working together. Recommend you to ping once before spending time, 
so that we can collaboratively work together, even I wouldn't mind you to 
pick/own on-going development and submit it.


Thanks,
Vaibhav
> Anyway - thanks for the heads-up!
> 
> 
> Daniel
> 
> 
