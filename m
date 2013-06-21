From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 16:32:12 +0200
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <CAD=GYpZ_5Lp1La=f+2BQfmuj+sc3FgygZRD4gfj4JGGZ0Do=_Q@mail.gmail.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <201306211600.04986.arnd@arndb.de>
 <CAD=GYpZ_5Lp1La=f+2BQfmuj+sc3FgygZRD4gfj4JGGZ0Do=_Q@mail.gmail.com>
Message-ID: <201306211632.12577.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Joel A Fernandes wrote:
> I haven't come across this problem but- are you saying there is a
> shortcoming in Kbuild/Kconfig that selects an option even if its
> dependency is not met?

Well, the shortcoming is that it lets you specify impossible
contraints. You get a warning from Kconfig when building
such a configuration, but then it continues.

> The problem with defconfig is also too many options I feel for a common case.
> CONFIG_DMADEVICES=y
> CONFIG_TI_EDMA=y
> 
> Most if not all future OMAPs from will use EDMA. Why not we can be
> explicit about it and just built it in anyway. If ARCH_OMAP and
> DMADEVICES are selected, then we can just build EDMA in by default.

It's just not how we do things. Kconfig is a mess because we are
not consistent in the way this is done.

> I agree maybe the option can be dropped from Davinci but I suggest
> let's keep it for OMAP. Is that ok?

No, I would still like you to not add it to either one. I'm spending
a lot of my time tracking down incorrect 'select' statements and I'd
rather spend it in a different way. I've had to a number of 'select'
statements from OMAP in the past, please don't add any new ones
unless there is a strict build dependency (which normally should not
exist).

	Arnd
