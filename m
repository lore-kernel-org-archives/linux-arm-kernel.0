From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Sep 2013 15:40:02 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <1378994596.2627.449.camel@shinybook.infradead.org>
References: <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk>
 <523186DF.4070203@freescale.com>
 <1378982395.2627.416.camel@shinybook.infradead.org>
 <20980858CB6D3A4BAE95CA194937D5E73EA0EE8B@DBDE04.ent.ti.com>
 <1378984665.2627.423.camel@shinybook.infradead.org>
 <20130912114831.GL29403@sirena.org.uk>
 <1378987323.2627.429.camel@shinybook.infradead.org>
 <20130912134345.GQ29403@sirena.org.uk>
 <1378994596.2627.449.camel@shinybook.infradead.org>
Message-ID: <20130912144002.GT29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 03:03:16PM +0100, David Woodhouse wrote:

> Not so in this case. The controller driver appears "know", in advance,
> what commands are going to be sent. It preloads its buffers (the LUT)
> with what it *expects* us to send, and when we make a request it'll just
> trigger a send from the appropriate buffer. And it will crap itself if
> we actually try to send anything *different*.

> Or so I understand it.

Yes, that was pretty much my understanding of what was going on here -
clearly the way the driver is currently figuring out what the commands
are isn't good enough.

> So to go back to your question: the commands that it "knows" we are
> going to send are indeed specific to (one particular type of) SPI NOR
> flash. But there's nothing on the MTD side which justifies that
> assumption. Even if you use a different type of SPI NOR flash which uses
> different opcodes for its commands, this broken scheme will fall over.

Right, the specific opcodes do need to variable at least and should be
being provided by the driver for the flash - but is the generic format
of the commands and requirement to send them abstractable?  Given that
it's apparently been baked into hardware and based on having a quick
scan through drivers/mtd/devices I'd guess so but...

> Unless, as I say, I've completely misunderstood what's going on here.
> Huang?

...like you say some clarity would be good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/9fedf9a8/attachment.sig>
