From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 23:41:51 +0100
Subject: [PATCH 1/2] ARM: debug: Add CLSP711X_UART1 config choice
In-Reply-To: <4E77BE34.6070702@codeaurora.org>
References: <20110916114140.GA31334@e102144-lin.cambridge.arm.com>
	<1316455300-5752-1-git-send-email-sboyd@codeaurora.org>
	<20110919212502.GB23613@e102144-lin.cambridge.arm.com>
	<4E77BE34.6070702@codeaurora.org>
Message-ID: <20110919224151.GB28237@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 03:12:04PM -0700, Stephen Boyd wrote:
> On 09/19/11 14:25, Will Deacon wrote:
> > Thanks for cooking the patch, it was somewhere on my list of things to do
> > this week! I think we also need to fix the DEBUG_DC21285_PORT option as that
> > has a similar `if not selected then use a different UART' behaviour. It can be
> > fixed in the same way as you have done in this patch.'
> 
> Ah my eyes glossed over the DC21285 one. Here's one on top of patch 2.
> Feel free to squash, etc.

Err, the DC21285 only has one serial port.

Some footbridge platforms expose the DC21285 to the outside world, others
don't.  Some footbridge platforms have a separate 8250 UART at the standard
PCI COM1 address, others don't.

What DEBUG_DC21285_PORT is selecting between is whether to use the DC21285
port (when set) or the 8250 at PCI COM1 (when unset).
