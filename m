From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 22 Feb 2012 19:02:38 +0100
Subject: [PATCH v2 12/19] ARM: at91/rtc-at91sam9: each SoC can select
 the RTT device to use
In-Reply-To: <201202221725.46150.arnd@arndb.de>
References: <1329903585-30738-1-git-send-email-nicolas.ferre@atmel.com>
 <201202221647.23430.arnd@arndb.de>
 <20120222170724.GF9407@game.jcrosoft.org>
 <201202221725.46150.arnd@arndb.de>
Message-ID: <20120222180238.GH9407@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:25 Wed 22 Feb     , Arnd Bergmann wrote:
> On Wednesday 22 February 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > But if you change the rtc driver to always bind to the existing
> > > "at91_rtt" platform_device and fail the probe() function for the
> > > case that you are on at91sam9263 probing the non-RTC device,
> > > you should get the exact same result without any extra code
> > > in the per-soc files.
> >
> > agreed but as on at91sam9263 you have 2 RTTs so you can have 2 drivers at the
> > same time that use the RTT. So we can not do this except if we set the second
> > RTT to an other device name.
> 
> Let me rephrase what I meant then:
> 
> The first driver should in its probe function do:
> 
> 	if (pdev->id != CONFIG_RTC_DRV_AT91SAM9_RTT)
> 		return -ENODEV;
> 
> while the other driver does
> 
> 	if (pdev->id == CONFIG_RTC_DRV_AT91SAM9_RTT)
> 		return -ENODEV;
> 
> This way, each driver binds to one device but not the other.
> It should even work with an unmodified second driver, as long
> as you guarantee that it's loaded after the first one.
> 
> Any reason why this won't work?
just one other issue I need to pass the GPBR ressource to the RTC driver only

Best Regards,
J.
