From: balbi@ti.com (Felipe Balbi)
Date: Fri, 31 Jan 2014 09:47:21 -0600
Subject: [PATCH] usb: dwc3: keystone: switch to use runtime pm
In-Reply-To: <52EBC499.2070302@ti.com>
References: <1391174426-13773-1-git-send-email-grygorii.strashko@ti.com>
 <20140131151955.GB20736@saruman.home> <52EBC499.2070302@ti.com>
Message-ID: <20140131154721.GD20736@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 10:43:21AM -0500, Santosh Shilimkar wrote:
> On Friday 31 January 2014 10:19 AM, Felipe Balbi wrote:
> > Hi,
> > 
> > On Fri, Jan 31, 2014 at 03:20:26PM +0200, Grygorii Strashko wrote:
> >> The Keystone PM management layer has been implemented using PM bus for
> >> power management clocks. As result, most of Keystone drivers don't need
> >> to manage clocks directly. They just need to enable runtime PM and use it
> >> to handle their PM state and clocks.
> >>
> >> Hence, remove clock management code and switch to use runtime PM.
> >>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > 
> > quite a few weeks back I sent a series enabling runtime pm for all glue
> > layers. I'll use that version instead, sorry.
> > 
> That should be fine but you need to drop clk_*() related code
> from that patch. I assume you will send refresh version of it then.

why ? it makes no difference if you enable twice and disable twice.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/a181155d/attachment-0001.sig>
