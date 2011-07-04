From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 4 Jul 2011 13:55:51 +0200
Subject: [RFC PATCH 0/3] base board consolidation
In-Reply-To: <20110704103820.GC8286@n2100.arm.linux.org.uk>
References: <20110701094403.GT11559@pengutronix.de>
	<CACTFLAPsaiF8KEXeDGOX72dcAvzegHDUQcPEPNxywwYewrHsUw@mail.gmail.com>
	<20110704103820.GC8286@n2100.arm.linux.org.uk>
Message-ID: <201107041355.52025.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 04, 2011 12:38:20 PM Russell King - ARM Linux wrote:
> On Mon, Jul 04, 2011 at 12:20:08PM +0200, Daniel Mack wrote:
> > Yes, I would also much more like to see these boards being supported
> > by DT, and eventually, we can probably provide static tree definitions
> > for these boards and get rid of the whole code entirely.
> 
> While some of that can be done, I think the idea of getting rid of all
> the code is a pipedream - things like detecting the LCD panel is
> something which has to be in code.
> 
> Having separate DT blobs because you happen to have connected a different
> LCD display is not sane when you can detect the LCD type at run time -
> from either the support perspective or the maintainence perspective.
> 
> There's also a similar issue where the ethernet controller may be of
> two different types, which can only be detected at runtime - and again
> having different DT blobs would be a nightmare.

Which leads me to a question (likely quite off-topic here). Working on a pxa-
device tree support, there're a lot of procedures called during init doing 
exactly this -- how do you handle this via device tree ? Is there any way to 
call them ? Or does the kernel need to patch device tree on run-time ? Or how?

Thanks
> 
> With that alone, you're talking about 10 different DT blobs (5 different
> CLCD panel configs + 2 ethernet configs) for just one Realview board.
> 
> There's also the matter of the platform specific registers setting the
> clock speed for the SP804 timers.
> 
> So no, I don't think that we'll ever get rid of all the code for ARMs
> development platforms without losing functionality/utility, but we should
> be able to get rid of quite an amount like I've already done by
> consolidating across the entire set with plat-versatile.
