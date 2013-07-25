From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 25 Jul 2013 15:22:29 +0200
Subject: How to create IRQ mappings in a GPIO driver that doesn't control
 its IRQ domain ?
In-Reply-To: <20130725131556.GD9858@sirena.org.uk>
References: <1624911.6TtmtVmU1T@avalon> <1408178.cxAUTUGJc5@avalon>
 <20130725131556.GD9858@sirena.org.uk>
Message-ID: <1681089.qGWOhLKTTo@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thursday 25 July 2013 14:15:56 Mark Brown wrote:
> On Thu, Jul 25, 2013 at 11:45:33AM +0200, Laurent Pinchart wrote:
> > The two devices are independent, so there's no real parent/child
> > relationship. However, as Grant proposed, I could list all the interrupts
> > associated with GPIOs in the GPIO controller DT node. I would then just
> > call irq_of_parse_and_map() in the .to_irq() handler to magically
> > translate the GPIO number to a mapped IRQ number.
> > 
> > The number of interrupts can be pretty high (up to 58 in the worst case so
> > far), so an alternative would be to specify the interrupt-parent only, and
> > call irq_create_of_mapping() directly. What solution would you prefer ?
> 
> Are the interrupts in a contiguous block in the controller so you can just
> pass around the controller and a base number?

In two of the three SoCs I need to fix they are. I've just realized that in 
the last one the interrupts are in two contiguous blocks in two different 
parents. I will thus need at least a list of <parent-phandle base count>. Our 
standard interrupt bindings don't seem to support multiple parents, is that 
something that we want to fix or should I go for custom bindings ?

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/be41a24f/attachment.sig>
