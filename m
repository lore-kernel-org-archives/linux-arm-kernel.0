From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 Sep 2013 22:10:36 +0200
Subject: [PATCH v4 4/4] ARM: bcm4760: Add restart hook
In-Reply-To: <20130915185220.GA32054@glitch>
References: <20130914152032.401907974@gmail.com>
 <201309152009.26462.arnd@arndb.de> <20130915185220.GA32054@glitch>
Message-ID: <201309152210.36738.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 September 2013, Domenico Andreoli wrote:
> issue here is that there is already a proper watchdog driver, the sp805.
> 
> so I guess now the task shifts to adding restart hook support to it, right?

Yes, correct.

There is an interesting question however: we have to deal with the same driver
being used in some machines that need to use it as the only way to reset the
system, as well as the case where you actually want to use some other method.

An easy way to handle this would be a boolean device tree property that
tells the driver whether or not to register, but we might want to
come up with a more sophisticated way to have multiple reset handlers
registered an prioritized so we try the "best" one first. Maybe someone
else has an opinion on this. If not, just do the property.

	Arnd
