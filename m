From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 6 Oct 2012 16:49:56 +0100
Subject: [RFC 20/24] SERIAL: core: add xmit buffer allocation callbacks
In-Reply-To: <E1TKTlL-0002ni-MB@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
 <E1TKTlL-0002ni-MB@rmk-PC.arm.linux.org.uk>
Message-ID: <20121006164956.2956375c@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 06 Oct 2012 13:45:47 +0100
Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> This allows drivers (such as OMAP serial) to allocate and free their
> transmit buffers in a sane manner, rather than working around the
> buffer allocation provided by serial_core.

I think this just illustrates how broken the serial_core layering is in
that drivers can't treat it as a library but get constrained by it.

Fine for now and actually probably a useful hook to begin removing the
circ buffers for the kernel generic kfifo and other work that needs doing
eventually.

Alan
