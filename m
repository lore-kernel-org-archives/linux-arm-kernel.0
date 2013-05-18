From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sat, 18 May 2013 09:03:41 +0200
Subject: [PATCH v3 09/20] ARM: shmobile: r8a7790: Add GPIO controller
 devices to device tree
In-Reply-To: <Pine.LNX.4.64.1305180851320.9241@axis700.grange>
References: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <14114689.gQXHdCTQYZ@avalon>
 <Pine.LNX.4.64.1305180851320.9241@axis700.grange>
Message-ID: <7692964.4oKpK3W9nB@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Saturday 18 May 2013 08:57:41 Guennadi Liakhovetski wrote:
> On Sat, 18 May 2013, Laurent Pinchart wrote:
> > On Friday 17 May 2013 14:26:48 Guennadi Liakhovetski wrote:
> > > On Wed, 15 May 2013, Laurent Pinchart wrote:
> > > > Add GPIO controller nodes to the r8a7790 core device tree.
> > > > 
> > > > Signed-off-by: Laurent Pinchart 
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > ---
> > > > 
> > > >  arch/arm/boot/dts/r8a7790.dtsi | 54 +++++++++++++++++++++++++++++++++
> > > >  1 file changed, 54 insertions(+)
> > > 
> > > Also here a couple of things are missing (presumably, for other SoCs you
> > > need the same):
> >
> > Thank you for testing the patch set. I'll integrate the modification in
> > the next version for r8a7778, r8a7779 and r8a7790.
> > 
> > As the gpio-ranges property specifies the number of GPIOs handled by the
> > controller, what's your opinion on dropping the #gpio-lines property from
> > the bindings ?
> 
> Well, gpio-ranges can contain several ranges, so, in a generic case you
> would have to sum them up to get a total count. But if you're ok with that
> or if your platforms only have 1 gpio gange per controller, of course,
> that property seems redundant.

The gpio-rcar driver exposes a single range on all the current platforms. I 
don't really foresee any change there in the future, but I might be 
overlooking something. Magnus, any opinion ?

> OTOH it is already used in r8a7779.dtsi, and thus already belongs to the
> ABI... Not sure whether removing it would be accepted.

It's only used in my DT bindings proposal that haven't been merged yet, so 
that shouldn't be an issue :-)

-- 
Regards,

Laurent Pinchart
