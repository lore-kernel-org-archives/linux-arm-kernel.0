From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 21:41:03 +0200
Subject: [PATCH 14/21] staging: nvec: allow modular build
In-Reply-To: <4082180.JXNz6TsAKc@ax5200p>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-15-git-send-email-arnd@arndb.de>
 <4082180.JXNz6TsAKc@ax5200p>
Message-ID: <201304232141.04123.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 April 2013, Marc Dietrich wrote:
> On Tuesday 23 April 2013 18:30:46 Arnd Bergmann wrote:
> > The serio code can be a loadable module, which in turn means that nvec
> > also has to be a module, so mark it as "tristate" in Kconfig.
> 
> oh, I didn't saw this randconfig error posting. NVEC isn't prepared for 
> modularized builds yet (it's on the TODO list though). So better say SERIO=y 
> here. Looking a bit closer, there is other stuff which can also be a module 
> (GPIOLIB, I2C, ...) so these also need a =y.

What is the problem with building it as a module? It looks all fine in that
regard.

I also did not see any problems with the other symbols, but that may be
because they get turned on as built-in even in allmodconfig. Marking it
as tristate certainly avoids the problem altogether.

> Should a post a patch?

If you have follow-on patches, they need to go on top now, since Greg
already took this patch.

	Arnd
