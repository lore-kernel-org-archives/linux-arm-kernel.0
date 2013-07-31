From: broonie@kernel.org (Mark Brown)
Date: Wed, 31 Jul 2013 14:27:08 +0100
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731115527.GR2810@htj.dyndns.org>
References: <20130731073306.GZ1754@pengutronix.de>
 <20130731082054.GF8540@nchen-desktop>
 <20130731084645.GB1754@pengutronix.de>
 <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
 <20130731115027.GN9858@sirena.org.uk>
 <20130731115527.GR2810@htj.dyndns.org>
Message-ID: <20130731132708.GQ9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 07:55:27AM -0400, Tejun Heo wrote:

> If you have DMA / IRQ / command engine deactivations in devm path
> which often is the case with full conversions, freeing any resources
> including DMA areas and host private data in the wrong order is a
> horrible idea.  It's worse as it won't really be noticeable in most
> cases.

It's really only interrupts that affect most devices - if there's DMA or
anything going on after the remove() then as you said earlier the driver
is probably doing something wrong.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/cd025781/attachment.sig>
