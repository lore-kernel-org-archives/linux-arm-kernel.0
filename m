From: david-b@pacbell.net (David Brownell)
Date: Tue, 16 Nov 2010 06:19:00 -0800
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <20101116072225.GF4074@angua.secretlab.ca>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
Message-ID: <1289917140.1752.7.camel@helium>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-11-16 at 00:22 -0700, Grant Likely wrote:

> 
> After discussions about device init dependencies at plumbers, and
> since this is the first SPI device driver I've reviewed since that
> dicussion, this driver gets to be the first to implement the proposed
> policy.  :-)
> 
> Change this to module_initcall().  Many spi and i2c drivers use
> module or subsys_initcall to try and influence driver probe order so
> that certain regulator chips get registered before the devices that
> try to use them.  This approach is insane.

Last I observed the issue ... the situation was that various core
drivers were required to be able to say that a key subsystem was
functional ... with said subsystem required to boot properly.

The dependency being, that is, driver on subsystem (but that subsystem
needed a core/bus driver running before it could work.

What's insane is that Linux *STILL* has no clean way to express that
type of system dependency ... where driver dependencies are pure side
effects.  (Albeit ones that never change on many platforms, but where
board-specific differences are routine, and have the same kind of
indirect dependencies.


- Dave
