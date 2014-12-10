From: balbi@ti.com (Felipe Balbi)
Date: Wed, 10 Dec 2014 09:00:49 -0600
Subject: [RFC/PATCH 2/7] arm: omap: devicetree: add new properties for
 OMAP devices
In-Reply-To: <54882967.60302@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-3-git-send-email-balbi@ti.com>
 <54882967.60302@ti.com>
Message-ID: <20141210150049.GD4602@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 10, 2014 at 04:37:19PM +0530, Lokesh Vutla wrote:
> Hi Felipe,
> 
> On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> > In order to get rid of some more hwmod data, we
> > introduce a few extra properties to OMAP DT
> > data in order to be able to pass the needed
> > information through DT.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  Documentation/devicetree/bindings/arm/omap/omap.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > index 4f6a82c..c6b9515 100644
> > --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> > +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > @@ -23,6 +23,13 @@ Optional properties:
> >    during suspend.
> >  - ti,no-reset-on-init: When present, the module should not be reset at init
> >  - ti,no-idle-on-init: When present, the module should not be idled at init
> > +- ti,rev_offs: IP block revision register offset (defaults to 0)
> > +- ti,sysc_offs: OCP_SYSCONFIG register offset (defaults to 0)
> > +- ti,syss_offs: OCP_SYSSTATUS register offset (defaults to 0)
> > +- ti,srst_udelay: Delay needed after a softreset in usecs (defaults to 0)
> > +- ti,idlemodes: Slave and Master supported idling modes
> > +- ti,clockact: default value of clock activity bits (defaults to 0)
> > +- ti,sysc_type: OCP_SYSCONFIG type. Valid types are 1, 2 or 3 (defaults to 1)
> Once if all the hwmod data comes to dt it will be very dufficult to see all the data
> together. Can we separate out hwmod class data like clocks data is separated out into different node
> or something of the sort like below?
> 
> 	ti, hwmod_class {
> 		ti,class_name = <>;

this can be done, but I don't want to pass a class name. It's anyways
just the hwmod name without the digits. For those which are not, I would
rather change the class name to match.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141210/b2448ca5/attachment.sig>
