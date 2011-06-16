From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jun 2011 17:25:03 +0200
Subject: Dynamic patching in discarded sections
In-Reply-To: <201106161721.27330.arnd@arndb.de>
References: <201106081123.59414.arnd@arndb.de>
	<alpine.LFD.2.00.1106080946000.2142@xanadu.home>
	<201106161721.27330.arnd@arndb.de>
Message-ID: <201106161725.03366.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 June 2011, Arnd Bergmann wrote:
> 10000 randconfig kernel build later without that patch, I'm rather sure
> that there is only a single driver that is suffering from this. While your
> patch absolutely makes sense, a less invasive workaround would be to just
> not mark mmc_spi_remove as __devexit until Dave's patch gets in.

Scratch that. Even when Dave's patch gets into binutils, we'd still need to
make a compile time decision to figure out if the linker is new enough, so
we definitely need Nicolas' patch as well.

	Arnd
