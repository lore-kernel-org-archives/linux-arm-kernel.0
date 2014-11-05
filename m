From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Nov 2014 20:17:38 +0200
Subject: [PATCH 2/7] pinctrl: pinconf-generic: Infer map type from DT
 property
In-Reply-To: <d0c8876b424049059acab000d07ffa4b@BN1AFFO11FD053.protection.gbl>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <21124316.ibhe1N9UZS@avalon>
 <d0c8876b424049059acab000d07ffa4b@BN1AFFO11FD053.protection.gbl>
Message-ID: <1417202.djDaFURS6d@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

On Wednesday 05 November 2014 10:09:35 S?ren Brinkmann wrote:
> On Wed, 2014-11-05 at 03:56PM +0200, Laurent Pinchart wrote:
> > On Monday 03 November 2014 11:05:26 Soren Brinkmann wrote:
> > > With the new 'groups' property, the DT parser can infer the map type
> > > from the fact whether 'pins' or 'groups' is used to specify the pin
> > > group to work on.
> > > To maintain backwards compatibitliy with current usage of the DT
> > > binding, this is only done when an invalid map type is passed to the
> > > parsing function.
> > 
> > The Renesas PFC implements similar bindings with using the vendor-specific
> > properties "renesas,pins" and "renesas,groups" (bindings and
> > implementation available at
> > Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt and
> > drivers/pinctrl/sh-pfc/pinctrl.c respectively).
> > 
> > The Renesas implementation is a bit more generic in that it allows both
> > pins and groups to be specified in a single subnode. Do you think that
> > feature would make sense for pinconf-generic as well ?
> 
> I don't have a use-case for that. I guess if somebody needs this kind of
> functionality it could be added later. I would like to avoid blocking
> pinctrl-zynq on adding more features here.

I'm fine with that, as long as the changes won't require breaking the DT ABI. 
I don't think they would but I wanted to raise the issue in case I would have 
missed a potential issue.

-- 
Regards,

Laurent Pinchart
