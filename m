From: balbi@ti.com (Felipe Balbi)
Date: Mon, 30 Jun 2014 13:34:06 -0500
Subject: [PATCH v2 05/12] usb: phy: add the Berlin USB PHY driver
In-Reply-To: <20140630145211.GA29613@kwain>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-6-git-send-email-antoine.tenart@free-electrons.com>
 <20140627155622.GL8069@saruman.home> <20140627160557.GA6622@kwain>
 <20140627230433.GC762@saruman.home> <20140630145211.GA29613@kwain>
Message-ID: <20140630183406.GT31442@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 04:52:11PM +0200, Antoine T?nart wrote:
> Felipe,
> 
> On Fri, Jun 27, 2014 at 06:04:33PM -0500, Felipe Balbi wrote:
> > On Fri, Jun 27, 2014 at 06:05:57PM +0200, Antoine T?nart wrote:
> > > Hi Felipe,
> > > 
> > > On Fri, Jun 27, 2014 at 10:56:22AM -0500, Felipe Balbi wrote:
> > > > On Tue, Jun 24, 2014 at 12:35:14PM +0200, Antoine T?nart wrote:
> > > > > Add the driver driving the Marvell Berlin USB PHY. This allows to
> > > > > initialize the PHY and to use it from the USB driver later.
> > > > > 
> > > > > Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> > > > 
> > > > since this is a brand new driver, it should go to drivers/phy instead.
> > > 
> > > This PHY is used by a ChipIdea USB driver, which uses the provided
> > > common function for ChipIdea. These functions use the usb_phy framework.
> > > That's why this PHY driver is there.
> > 
> > right, but you can add support for the new PHY layer which would help
> > other users convert their PHY drivers to the new PHY framework.
> 
> Adding the support for the new PHY layer in the common CI code is not
> complicated, but these functions also use some parts from usb hcd or usb
> otg which are only usb_phy compatible.
> 
> Shouldn't these parts add the new PHY support first, to avoid ending up
> with a fairly big series, quite long to do and complicated to review?

sure, patches are welcome. :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/b1c71aab/attachment-0001.sig>
