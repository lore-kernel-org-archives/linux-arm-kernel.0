From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Oct 2011 17:14:47 +0100
Subject: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
In-Reply-To: <1317566760-25681-16-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-16-git-send-email-arnd@arndb.de>
Message-ID: <20111002161447.GC12323@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 04:45:45PM +0200, Arnd Bergmann wrote:
> The logic to allow only one DMA driver in MUSB is currently
> flawed, because it also allows picking no DMA driver at all
> and also not selecting PIO mode.
> 
> Using a choice statement makes this foolproof for now and
> also simplifies the Makefile.
> 
> Unfortunately, we will have to revisit this when we start
> supporting multiple ARM platforms in a single kernel binary,
> because at that point we will actually need to select
> multiple DMA drivers and pick the right one at run-time.

I thought there was some work going on to convert this to use the
dmaengine stuff?

But in any case, a stop-gap fix is needed for randconfig.
