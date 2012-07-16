From: marex@denx.de (Marek Vasut)
Date: Mon, 16 Jul 2012 15:06:07 +0200
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20120716102151.GC17435@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <201207141409.38554.marex@denx.de> <20120716102151.GC17435@pengutronix.de>
Message-ID: <201207161506.08147.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> Marek,
> 
> > > I am also still interested to check the runtime switching, but it might
> > > take another month until I can really hack on it.
> > 
> > Good, there is some bit that probably needs to be flipped to allow this
> > switching. I managed to get this working with SPI, not with i2c though.
> > With
> 
> Ah, hearing that it works with SPI is good news.
> 
> > i2c, if I restarted the controller inbetween each transaction, it worked
> > ... which is not what I'd like to see there.
> 
> Agreed.
> 
> > > > No, it doesn't. See above about small transfers. Consider the easy
> > > > situation where you have sensor on one bus (so you do PIO because you
> > > > transfer small data) and you have EEPROM on other bus, where you use
> > > > DMA because you transfer large data. And the mixed mode isn't there
> > > > yet.
> > > 
> > > I fully understand what you want to configure. I did before. Yet,
> > > devicetree bindings are not platform_data and shouldn't be used like
> > > them.
> > 
> > But then, how would you configure this detail on a per-bus basis? Well
> > all
> 
> This is a question for devicetree-discuss.

Did you Cc it?

> > patch actually fixes a real issue, I'd like to have it in ASAP and it's
> > been aboue three months already, which sucks.
> 
> I am open to ideas improving the situation (which is: a lot more
> patches, but not a lot more reviewers)
> 
> Thanks,
> 
>    Wolfram

Best regards,
Marek Vasut
