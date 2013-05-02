From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 21:12:42 +0200
Subject: [PATCH, RFC 16/22] USB: UHCI: clarify Kconfig dependencies
In-Reply-To: <Pine.LNX.4.44L0.1305021423450.1436-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1305021423450.1436-100000@iolanthe.rowland.org>
Message-ID: <201305022112.42583.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Alan Stern wrote:
> On Thu, 2 May 2013, Arnd Bergmann wrote:
> 
> > > What do you think of my patch as compared to yours? 
> > 
> > I think in the end it comes down to the question where you want to
> > head with your driver. The way I did my version was going towards
> > making it similar to EHCI, with stand-alone bus glue drivers
> > and a core that is just a library module but does not register
> > a device_driver by itself.
> > 
> > Given that there are just three bus glues from UHCI, and at most
> > two of them enabled at the same time, I don't see a direct need
> > for UHCI to go down the same route as EHCI. If you want to just
> > leave this driver alone, your patch is simpler and has the same
> > effect in the end. Otherwise I think my patch avoids changing it
> > all again once the driver gets reworked.
> 
> Okay then, I'll submit my patch to Greg after the merge window closes.

Ok, thanks!

	Arnd
