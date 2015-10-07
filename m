From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Oct 2015 11:41:21 +0100
Subject: [PATCH v6 2/4] spi: bcm2835: add bcm2835 auxiliary spi device
 driver
In-Reply-To: <5613B2A2.9020309@martin.sperl.org>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
 <1441970527-2403-3-git-send-email-kernel@martin.sperl.org>
 <20151006112320.GP12635@sirena.org.uk>
 <5613B2A2.9020309@martin.sperl.org>
Message-ID: <20151007104121.GG12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 01:38:10PM +0200, Martin Sperl wrote:
> On 06.10.2015 13:23, Mark Brown wrote:
> >On Fri, Sep 11, 2015 at 11:22:04AM +0000, kernel at martin.sperl.org wrote:

> >>+	bs->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);

> >Why are we using this unusual DT specific API here?  I'd expect to see
> >just use platform_get_irq() here and this seems to be the only DT
> >dependency in the driver.

> I copied it from spi-bcm2835.c, where it is also used in exactly that
> fashion.

> You want me to move to your recommended api instead for both drivers?

> >I'd expect to request the IRQ after we reset the hardware in order to
> >ensure that the hardware is in a known good state
> 
> Same copy/paste in this case - i can change the order for both
> drivers if you want.

Yes, that'd be better.  I'll just apply this now and you can send
followup patches fixing these for both drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/8379787a/attachment.sig>
