From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Apr 2013 16:52:48 +0200
Subject: [PATCH 2/2] dma: imx-sdma: move to generic device tree bindings
In-Reply-To: <20130424144318.GD2736@S2101-09.ap.freescale.net>
References: <1366812273-10833-1-git-send-email-shawn.guo@linaro.org>
 <201304241626.22518.arnd@arndb.de>
 <20130424144318.GD2736@S2101-09.ap.freescale.net>
Message-ID: <201304241652.48951.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 April 2013, Shawn Guo wrote:
> Using macros will help us to:
> 
> 1) Improve the readability of "dmas" property in dts
> 2) Keep the values stay in sync between kernel and DT
> 

I can understand the second part, but I strongly disagree on the first one.
Using symbolic constants in the DT will make it harder to understand because
you now have to look in multiple places to see what you actually put in there.

It makes some sense for the priorities, since they get reused for each
dma specifier.

	Arnd
