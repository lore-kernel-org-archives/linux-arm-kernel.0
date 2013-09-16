From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 16 Sep 2013 09:18:21 +0200
Subject: [PATCH v4 4/4] ARM: bcm4760: Add restart hook
In-Reply-To: <201309152210.36738.arnd@arndb.de>
References: <20130914152032.401907974@gmail.com>
 <201309152009.26462.arnd@arndb.de> <20130915185220.GA32054@glitch>
 <201309152210.36738.arnd@arndb.de>
Message-ID: <20130916071821.GA18210@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 15, 2013 at 10:10:36PM +0200, Arnd Bergmann wrote:
> On Sunday 15 September 2013, Domenico Andreoli wrote:
> > issue here is that there is already a proper watchdog driver, the sp805.
> > 
> > so I guess now the task shifts to adding restart hook support to it, right?
> 
> Yes, correct.
> 
> There is an interesting question however: we have to deal with the same driver
> being used in some machines that need to use it as the only way to reset the
> system, as well as the case where you actually want to use some other method.

in a certain sense, there is space for a generic watchdog based restart
hook mechanism but the current watchdog ops do not provide the necessary
guarantees in atomic context.

> An easy way to handle this would be a boolean device tree property that
> tells the driver whether or not to register, but we might want to
> come up with a more sophisticated way to have multiple reset handlers
> registered an prioritized so we try the "best" one first. Maybe someone
> else has an opinion on this. If not, just do the property.

the simplest solution I see is adding a DT option to the sp805 driver so
that it registers the restart hook when asked to do so.

need to investigate whether the sp805 DT support is provided by some generic
AMBA mechanism or is completely missing.

> 
> 	Arnd

thanks,
Domenico
