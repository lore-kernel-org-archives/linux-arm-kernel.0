From: balbi@ti.com (Felipe Balbi)
Date: Fri, 12 Aug 2011 11:41:07 +0300
Subject: How to handle named resources with DT?
In-Reply-To: <20110812030218.GP30552@yookeroo.fritz.box>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<4E41A1B9.1060400@ti.com>
	<20110809211747.GJ11568@ponder.secretlab.ca>
	<4E41AA43.1000506@ti.com>
	<20110809214905.GK11568@ponder.secretlab.ca>
	<4E41AC5C.20301@ti.com> <20110810015214.GD23511@yookeroo.fritz.box>
	<CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
	<4E43CB07.20002@ti.com> <20110812030218.GP30552@yookeroo.fritz.box>
Message-ID: <20110812084106.GC19467@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 12, 2011 at 01:02:18PM +1000, David Gibson wrote:
> > That seems to be pretty straightforward to implement, and as soon as
> > it is useful even for a couple of drivers, it worth adding it.
> > 
> > It is anyway better than having to add a custom property to get the
> > information we will miss otherwise.
> > 
> > Moreover, since some drivers are relying on that call, it will avoid
> > having to add extra code for nothing if CONFIG_OF is set.
> > 
> > It will allow the driver to use a pretty standard API in anycase vs
> > using platform_get_resource + some extra optional calls to of_
> > functions + some code to get the information for non-DT build.
> 
> You don't need to add stuff to the DT to use the byname interface.
> Really.  All you need is a way for the driver (well match table entry,
> really) to provide a list of names to attach to the reg entries in
> order.

the whole point of using *byname() is for the driver to not care about
the order of the resources. So if driver has to provided an ordered list
of names, what's the benefit ? Sounds really stupid to provide an
ordered list of names to an ordered list of resources, just to use
*byname() instead of just assuming the list of resources is already
ordered.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110812/e7931997/attachment.sig>
