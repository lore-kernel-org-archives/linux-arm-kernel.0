From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jun 2012 12:59:38 +0000
Subject: [PATCH 06/14] mfd: Initialise the DB8500 PRCMU driver at
 core_initcall time
In-Reply-To: <4FD6FF6C.6040500@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdYoQFhBfRaPMBiVTiD979b+8708oS1qCPm+iyy5OZe2bw@mail.gmail.com>
 <4FD6FF6C.6040500@linaro.org>
Message-ID: <201206121259.38807.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 June 2012, Lee Jones wrote:
> On 11/06/12 22:01, Linus Walleij wrote:
> > Hm what shall we do when we run out of initlevels? I think this was the
> > kind of thing that deferred probe should solve. Usually changing this kind
> > of thing has side effects so I'm a bit hesitant.
> 
> Ah yes, I remember now. The IRQ domain needs to be in place before the 
> Device Tree is parsed by the Open Firmware subsystem. If it's not the 
> error "no irq domain found" is triggered and the IRQs are never mapped.
> 
> I'd be happy to take a second opinion, but I believe this (and the other 
> core_initcall patch) is required.

It's still just a hack. The real solution that we discussed last time it
came up is to defer the translation of irq numbers until device driver
probe time, and bail out with -EPROBE_DEFER if you try to use a device
whose interrupt is not available yet.

	Arnd
