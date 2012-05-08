From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 May 2012 14:36:46 +0000
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <20120508142926.GT15893@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <201205081348.14269.arnd@arndb.de>
 <20120508142926.GT15893@opensource.wolfsonmicro.com>
Message-ID: <201205081436.46471.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 May 2012, Mark Brown wrote:
> On Tue, May 08, 2012 at 01:48:14PM +0000, Arnd Bergmann wrote:
> > On Tuesday 08 May 2012, Lee Jones wrote:
> 
> > > I did run this past Arnd before writing the code and he agreed that this 
> > > would be suitable; however, if you know of a better way in which I can 
> > > do this, I'd be pleased to hear of it.
> 
> > It was the best approach that I could think of for this, but I'm also
> > a total newbie on regulators.
> 
> It's not really a regulator thing, what the code is doing is blasting in
> a bunch of magic register writes to set things up, some of which are
> configuring things that the subsystem already knows how to configure.

Right, which is what the driver has done since 79568b9412 "regulator:
initialization for ab8500 regulators" with your ack, so we decided not
to change that and simply move the init data from platform code
to the device tree.

	Arnd
