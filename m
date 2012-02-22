From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 22 Feb 2012 18:07:24 +0100
Subject: [PATCH v2 12/19] ARM: at91/rtc-at91sam9: each SoC can select
 the RTT device to use
In-Reply-To: <201202221647.23430.arnd@arndb.de>
References: <1329903585-30738-1-git-send-email-nicolas.ferre@atmel.com>
 <201202221450.04390.arnd@arndb.de>
 <20120222162442.GD9407@game.jcrosoft.org>
 <201202221647.23430.arnd@arndb.de>
Message-ID: <20120222170724.GF9407@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:47 Wed 22 Feb     , Arnd Bergmann wrote:
> On Wednesday 22 February 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 14:50 Wed 22 Feb     , Arnd Bergmann wrote:
> > > On Wednesday 22 February 2012, Nicolas Ferre wrote:
> > > > From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > > > 
> > > > For the RTT as RTC driver rtc-at91sam9, the platform_device structure
> > > > is filled during SoC initialization. This will allow to convert this
> > > > RTC driver as a standard platform driver.
> > > 
> > > Can you make this more elaborate? I don't see from this or the code why
> > > you don't just always register the RTT as "rtc-at91sam9". There seems to
> > > be no driver for the "at91_rtt" in tree, so I don't know if there is
> > > an out of tree driver binding to it.
> > > 
> > > Would it be possible to remove the compile time #if and the resetting
> > > of the device name if both drivers bind to the rtc name and the other
> > > rtt driver binds to both names?
> > because I see a quite some people use the rtt for something else
> > 
> > so I don't want to change on existing kernel
> 
> But if you change the rtc driver to always bind to the existing
> "at91_rtt" platform_device and fail the probe() function for the
> case that you are on at91sam9263 probing the non-RTC device,
> you should get the exact same result without any extra code
> in the per-soc files.
agreed but as on at91sam9263 you have 2 RTTs so you can have 2 drivers at the
same time that use the RTT. So we can not do this except if we set the second
RTT to an other device name.
> 
> I guess it also makes sense to specify a device tree property
> that lets you detect whether the RTT is used as RTC or something
> else.
>
agreed for DT I think of something like this with a phandle maybe

but today not all the soc are DT and will not be switch to DT at first

Best Regards,
J.
