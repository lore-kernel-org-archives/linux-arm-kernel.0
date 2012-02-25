From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 25 Feb 2012 08:45:44 +0000
Subject: [PATCH v2] USB: Support for LPC32xx SoC
In-Reply-To: <20120225035128.GA4455@pengutronix.de>
References: <1330030639-3796-1-git-send-email-stigge@antcom.de>
 <201202241503.27406.arnd@arndb.de> <20120225035128.GA4455@pengutronix.de>
Message-ID: <201202250845.44427.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 25 February 2012, Wolfram Sang wrote:
> > Unfortunately, the way that ohci handles the abstraction between the
> > various implementations is backwards, it would be much easier if the
> > main driver was following that model to start with.
> 
> ... exactly for that reason I didn't suggest it. Looking at other ohci-sources
> (e.g. ohci-omap.c), machine_is_* seems to be the consistent use-case.

I still hope that someone takes the time to convert ohci and ehci into
something more regular, building the .c files separately instead of the
conditional #include "foo.c" inside of the main file.

Alan and Greg, do you know if anyone is working on that, and if not do you
think someone should do it?

	Arnd
