From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 16:45:15 +0000
Subject: [PATCH v3 2/8] mfd: Add atmel-st driver
In-Reply-To: <54BE7916.4060204@atmel.com>
References: <1421077023-30954-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421077023-30954-3-git-send-email-alexandre.belloni@free-electrons.com>
 <20150119094224.GJ21886@x1> <20150119225923.GG5014@piout.net>
 <20150120094739.GM5767@x1> <20150120150501.GH5014@piout.net>
 <54BE7916.4060204@atmel.com>
Message-ID: <20150120164515.GF30656@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jan 2015, Nicolas Ferre wrote:

> Le 20/01/2015 16:05, Alexandre Belloni a ?crit :
> > On 20/01/2015 at 09:47:39 +0000, Lee Jones wrote :
> >>>> This driver looks pretty pointless.  Why can't you request the sysconf
> >>>> registers from within the drivers themselves?
> >>>>
> >>>
> >>> How would you probe the watchdog driver then? Would you had the
> >>> "atmel,at91rm9200-st" compatible there?
> >>>
> >>> At some point in time, we should add the reset driver, would you also
> >>> match it on "atmel,at91rm9200-st"?
> >>>
> >>> I'm fine with that as this allows to avoid the mfd driver.
> >>
> >> I'm sorry, I don't follow.  Why can't each driver have their own
> >> compatible strings?
> >>
> > 
> > The same IP provides a clocksource, a watchdog and is also the reset
> > controller. I think that the DT guidelines requires that the DT
> > describes the hardware and so use one compatible for that IP;
> 
> I would add also that the registers within the IP are kind of mixed,
> there is no way to separate by logical functions.

How is that different from any other syscon based device?

BTW, did you see "mfd: syscon: fix syscon probing from dt"

It may be the solution to your problem.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
