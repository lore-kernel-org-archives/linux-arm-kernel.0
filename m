From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 11 Dec 2012 17:32:32 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <20121211164608.GT14363@n2100.arm.linux.org.uk>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de> <20121211170338.4859ddf0@skate>
 <201212111615.03262.arnd@arndb.de> <20121211173013.0ceea196@skate>
 <20121211164608.GT14363@n2100.arm.linux.org.uk>
Message-ID: <20121211173232.43668ab3@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> with it.  It's very simple.  The IO port space is for ISA/PCMCIA and
> PCI IO port regions.  It is nothing more than that.

And on a lot of devices the LPC bus.

> Plus, if you _have_ IO space support, you must have some MMIO region for
> them to target - doing what many platforms have done to date and targetted
> ISA IO address 0 at virtual address 0 is just not on because as soon as
> you build a device driver which probes ISA addresses into your kernel,
> you will oops.

There shouldn't really be anything poking around that is modern - this is
true of some PC stuff too.

In general however if its because you have a window partly mapped you
could just catch the exception and load 0xFF for reads (and probably
whine with a backtrace so you know who to moan at).

Alan
