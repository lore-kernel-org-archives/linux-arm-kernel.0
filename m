From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2012 15:15:08 +0000
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120507141551.GE17002@opensource.wolfsonmicro.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071319.48768.arnd@arndb.de>
 <20120507141551.GE17002@opensource.wolfsonmicro.com>
Message-ID: <201205071515.08179.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 May 2012, Mark Brown wrote:
> > Using a 'struct resource' of type IORESOURCE_IO to pass information
> > about non-PIO registers to child devices is inconsistent, ugly and
> > confusing, but I agree it doesn't actually result in bugs. The problems
> 
> I actually don't find it at all confusing, but I think that's mostly
> because at a high level I look at _IO as being about a register space
> and this is just a different register space.

At least it managed to confuse Haojian ;-)

The part that confuses me most about the abuse of IORESOURCE_IO is that
these have no parent resource and are not registered or listed in
/proc/ioports.

	Arnd
