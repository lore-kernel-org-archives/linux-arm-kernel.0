From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 16 Jun 2011 18:07:54 +0100
Subject: Dynamic patching in discarded sections
In-Reply-To: <201106161725.03366.arnd@arndb.de>
References: <201106081123.59414.arnd@arndb.de>
	<alpine.LFD.2.00.1106080946000.2142@xanadu.home>
	<201106161721.27330.arnd@arndb.de>
	<201106161725.03366.arnd@arndb.de>
Message-ID: <20110616170754.GA30370@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 05:25:03PM +0200, Arnd Bergmann wrote:
> On Thursday 16 June 2011, Arnd Bergmann wrote:
> > 10000 randconfig kernel build later without that patch, I'm rather sure
> > that there is only a single driver that is suffering from this. While your
> > patch absolutely makes sense, a less invasive workaround would be to just
> > not mark mmc_spi_remove as __devexit until Dave's patch gets in.
> 
> Scratch that. Even when Dave's patch gets into binutils, we'd still need to
> make a compile time decision to figure out if the linker is new enough, so
> we definitely need Nicolas' patch as well.
> 
> 	Arnd

It would be nice to get it merged for the longer term, but we'll have
quite a long transitional period while the change propagates.

So we'd still need some other workaround for now.

Cheers
---Dave
