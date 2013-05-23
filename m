From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 14:09:02 +0200
Subject: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
In-Reply-To: <20130523112401.GO18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com> <201305231259.43750.arnd@arndb.de>
 <20130523112401.GO18614@n2100.arm.linux.org.uk>
Message-ID: <201305231409.02359.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Russell King - ARM Linux wrote:
> This is the problem you guys are missing - unreachable() means "we lose
> control of the CPU at this point".

I'm absolutely aware of this. Again, the current behaviour of doing nothing
at all isn't very different from undefined behavior when you get when you
get to the end of a function returning a pointer without a "return" statement,
or when you return from a function that has determined that it is not safe
to continue.

> If you have an embedded system and you've taken out all the printk()
> stuff, you most certainly want the system to do something if you hit
> an unexpected condition.

I did not claim that it was a good idea to disable BUG(), all I said is
that "random stuff may happen" is probably what Matt Mackall had in mind when
he introduced the option.

	Arnd
