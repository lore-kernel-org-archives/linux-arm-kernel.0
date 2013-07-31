From: broonie@kernel.org (Mark Brown)
Date: Wed, 31 Jul 2013 14:57:51 +0100
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731134215.GS2810@htj.dyndns.org>
References: <20130731084645.GB1754@pengutronix.de>
 <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
 <20130731115027.GN9858@sirena.org.uk>
 <20130731115527.GR2810@htj.dyndns.org>
 <20130731132708.GQ9858@sirena.org.uk>
 <20130731134215.GS2810@htj.dyndns.org>
Message-ID: <20130731135751.GT9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 09:42:15AM -0400, Tejun Heo wrote:
> On Wed, Jul 31, 2013 at 02:27:08PM +0100, Mark Brown wrote:

> > It's really only interrupts that affect most devices - if there's DMA or
> > anything going on after the remove() then as you said earlier the driver
> > is probably doing something wrong.

> Hmmm... it depends on the specific driver is converted but if the
> deactivation sequence - shutting down of command engine - is also
> handled by devm as in libata and if you have non-devres resource free
> in the exit path, you have the same problem.  Again, in general,

That's the only API I've ever heard of doing that.  Everything else is
just using it to do deallocation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/052b3772/attachment.sig>
