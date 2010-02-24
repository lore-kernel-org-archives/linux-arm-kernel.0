From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Feb 2010 16:30:28 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <4B8543B2.4030004@marcansoft.com>
References: <1266933437-4876-1-git-send-email-hector@marcansoft.com>
	<20100224084259.GA8068@pengutronix.de>
	<4B84F0F6.40902@marcansoft.com>
	<20100224110353.GA15105@n2100.arm.linux.org.uk>
	<4B8543B2.4030004@marcansoft.com>
Message-ID: <20100224153028.GA28805@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 04:20:18PM +0100, Hector Martin wrote:
> Russell King - ARM Linux wrote:
> > It does work with the previous version of the decompressor.
> 
> Sure, at this point in time. The broken code is still the loader, not
> the new decompressor. If a GCC update had been the culprit, it wouldn't
> be GCC's fault. The fact remains that the behavior is undefined and
> (with current GCC versions) requires carefully crafting the resulting C
> code in order to get reasonable behavior. I don't think you can
> reasonably require that a generic descompressor be maintained by others
> with care for compatibility with this hack; someone would have to police
> changes for potential issues, and you still have a decent chance of
> getting breakage if GCC decides to change its behavior some day. I'd say
> fixing the loader to not require this undefined behavior is a
> considerably better long-term solution.
> 
> > I noticed that you did not reply to my previous email on this subject,
> > are you intentionally ignoring my responses?
> 
> You had a valid point which I hadn't considered (running ROM images from
> RAM), so I figured I'd give addressing that a shot before going into
> discussion mode.
Independant of the outcome of this discussion I suggest reverting the
switch to the new decompressor for .33.  Hectors patch definitely isn't
.33 material and broken or not the old decompressor was more reliable.

In general I would welcome to get rid of -Dstatic=, but it needs
careful consideration.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
