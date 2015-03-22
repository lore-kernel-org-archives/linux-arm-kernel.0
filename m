From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Mar 2015 03:20:52 +0100
Subject: [PATCH 0/5] Driver for pxa architectures
In-Reply-To: <1426977868-5414-1-git-send-email-robert.jarzmik@free.fr>
References: <1426977868-5414-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <201503220320.52675.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 March 2015, Robert Jarzmik wrote:
> It is as well one of the last steps (or so I hope) for pxa architure to be part
> of the multiplatform ARM architecture, and at the same time keep its legacy
> platforms operational. It will kill arch/arm/plat-pxa/dma.c in the long term.
> 

Hi Robert,

as much as I like this series, I think you still have a long way to go before
PXA can really be multiplatform. Other parts that would need to be solved
include the various cpu_is_pxa*() checks in drivers, the per-board header
files, the way that the I/O space is mapped in the PCMCIA drivers and
the XIP support.

I think all of them are theoretically doable, but I wasn't expecting
to ever get there.

	Arnd
