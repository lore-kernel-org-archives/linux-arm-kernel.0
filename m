From: broonie@kernel.org (Mark Brown)
Date: Thu, 25 Jul 2013 14:55:47 +0100
Subject: How to create IRQ mappings in a GPIO driver that doesn't control
 its IRQ domain ?
In-Reply-To: <1681089.qGWOhLKTTo@avalon>
References: <1624911.6TtmtVmU1T@avalon> <1408178.cxAUTUGJc5@avalon>
 <20130725131556.GD9858@sirena.org.uk> <1681089.qGWOhLKTTo@avalon>
Message-ID: <20130725135547.GG9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 03:22:29PM +0200, Laurent Pinchart wrote:
> On Thursday 25 July 2013 14:15:56 Mark Brown wrote:

> > Are the interrupts in a contiguous block in the controller so you can just
> > pass around the controller and a base number?

> In two of the three SoCs I need to fix they are. I've just realized that in 
> the last one the interrupts are in two contiguous blocks in two different 
> parents. I will thus need at least a list of <parent-phandle base count>. Our 
> standard interrupt bindings don't seem to support multiple parents, is that 
> something that we want to fix or should I go for custom bindings ?

It seems reasonable to define the bindings in a generic way in case
other people have the same problem but it's possible I may be missing a
trick regarding how to do this in DT so don't take my word for it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/1c948990/attachment.sig>
