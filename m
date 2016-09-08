From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 21:59:20 +0200
Subject: Regmap regression in next caused by of_iomap change
In-Reply-To: <20160908184111.vj3sb2ik6ydehkag@atomide.com>
References: <20160908184111.vj3sb2ik6ydehkag@atomide.com>
Message-ID: <4088076.eNNe5WgnxT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 11:41:12 AM CEST Tony Lindgren wrote:
> Hi,
> 
> Looks like commit 39de2c4275a9 ("mfd: syscon: Make use of of_iomap")
> makes at least MMC PBIAS regulator stop working on omap3.
>
> That's probably because of_syscon_register uses the now unintialized
> struct resource res to set syscon_config.max_register.

Looks correct. Lee, please send a revert of that patch to Linus
along with any other fixes you may have.
 
> I have a strange deja vu feeling that we've been through this
> before  See commit ca668f0edfae ("mfd: syscon: Set regmap max_register
> in of_syscon_register")
> 
> Maybe we should add comments there instead?

I wonder why gcc didn't detect this case. I usually do my
test builds with -Wmaybe-uninitialized that should have
caught it but didn't.

	Arnd
