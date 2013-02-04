From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Feb 2013 21:47:38 +0000
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <CACRpkdbPyZt8=pLhz-5qcaSSAk6VBn61dPTNp6teU9HksBwN2w@mail.gmail.com>
References: <510C2A47.1090607@mvista.com>
 <20130204203358.GX4720@opensource.wolfsonmicro.com>
 <CACRpkdbPyZt8=pLhz-5qcaSSAk6VBn61dPTNp6teU9HksBwN2w@mail.gmail.com>
Message-ID: <201302042147.38407.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 February 2013, Linus Walleij wrote:
> So I think the above concerns are moot. The callback we can
> set on cookies is entirely optional, and it's even implemented by
> each DMA engine, and some may not even support it but require
> polling, and then it won't even be implemented by the driver.

Just to ensure that everybody is talking about the same thing here:
Is it just the callback that is optional, or also the interrupt
coming from the hardware? With NAPI, you want to avoid both, since
getting an interrupt for every packet adds noticeable overhead,
but you still want to be able to tell the hardware that you
are fed up with polling and would like to get an interrupt again
when the next data arrives (ideally, after either a little time
has passed after the next packet, or a specific number of packets
has arrived).

	Arnd
