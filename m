From: john@metanate.com (John Keeping)
Date: Tue, 4 Apr 2017 14:15:13 +0100
Subject: [PATCH] dt-bindings: display: rk3288-mipi-dsi: add reset property
In-Reply-To: <20170312120659.hpiwnsto6hkxs5yh@rob-hp-laptop>
References: <20170224125506.21533-1-john@metanate.com>
 <20170224125506.21533-24-john@metanate.com>
 <20170302215643.GA49163@google.com>
 <20170303113945.3bd2cbd9.john@metanate.com>
 <20170312120659.hpiwnsto6hkxs5yh@rob-hp-laptop>
Message-ID: <20170404141513.2bad3b1b.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Sun, 12 Mar 2017 07:06:59 -0500, Rob Herring wrote:

> On Fri, Mar 03, 2017 at 11:39:45AM +0000, John Keeping wrote:
> > This reset is required in order to fully reset the internal state of the
> > MIPI controller.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> > On Thu, 2 Mar 2017 13:56:46 -0800, Brian Norris wrote:  
> > > On Fri, Feb 24, 2017 at 12:55:06PM +0000, John Keeping wrote:  
> > > > +	/*
> > > > +	 * Note that the reset was not defined in the initial device tree, so
> > > > +	 * we have to be prepared for it not being found.
> > > > +	 */
> > > > +	apb_rst = devm_reset_control_get(dev, "apb");    
> > > 
> > > Did this reset ever get documented in the device tree bindings? I
> > > couldn't find it. Perhaps a follow-up patch is in order?  
> > 
> > Here's a patch to do that.
> > 
> >  .../devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt  | 7 +++++++
> >  1 file changed, 7 insertions(+)  
> 
> Acked-by: Rob Herring <robh@kernel.org>

I don't see this patch in linux-next, so I guess it has fallen through
the cracks somewhere.  Since we have Rob's ack, can you pick this via
drm-misc?


Regards,
John
