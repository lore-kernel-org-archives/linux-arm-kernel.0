From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 20 Jan 2015 16:05:01 +0100
Subject: [PATCH v3 2/8] mfd: Add atmel-st driver
In-Reply-To: <20150120094739.GM5767@x1>
References: <1421077023-30954-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421077023-30954-3-git-send-email-alexandre.belloni@free-electrons.com>
 <20150119094224.GJ21886@x1> <20150119225923.GG5014@piout.net>
 <20150120094739.GM5767@x1>
Message-ID: <20150120150501.GH5014@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/2015 at 09:47:39 +0000, Lee Jones wrote :
> > > This driver looks pretty pointless.  Why can't you request the sysconf
> > > registers from within the drivers themselves?
> > > 
> > 
> > How would you probe the watchdog driver then? Would you had the
> > "atmel,at91rm9200-st" compatible there?
> > 
> > At some point in time, we should add the reset driver, would you also
> > match it on "atmel,at91rm9200-st"?
> > 
> > I'm fine with that as this allows to avoid the mfd driver.
> 
> I'm sorry, I don't follow.  Why can't each driver have their own
> compatible strings?
> 

The same IP provides a clocksource, a watchdog and is also the reset
controller. I think that the DT guidelines requires that the DT
describes the hardware and so use one compatible for that IP;


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
