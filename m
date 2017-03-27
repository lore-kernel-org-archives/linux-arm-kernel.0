From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Mar 2017 13:47:18 +0200
Subject: [PATCH v5 0/8] Add dual-role OTG support for Allwinner H3
In-Reply-To: <73c148dd-fe21-da12-45d1-0c70d9a5b998@ti.com>
References: <20170325145015.22076-1-icenowy@aosc.xyz>
 <73c148dd-fe21-da12-45d1-0c70d9a5b998@ti.com>
Message-ID: <20170327114718.sm37yzjpawgatcfc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 03:35:25PM +0530, Kishon Vijay Abraham I wrote:
> 
> 
> On Saturday 25 March 2017 08:20 PM, Icenowy Zheng wrote:
> > Allwinner H3 have a its USB PHY0 routed to two USB controllers: one is
> > a MUSB controller, which can work in peripheral mode, but works badly in
> > host mode (several hardware will fail on the MUSB controller, even connect
> > one MUSB controller in peripheral mode to another one in host mode cannot
> > work); the other is a pair of EHCI/OHCI controller, which can work only
> > in host mode, but have better compatibillity. The route is controlled in
> > a register, which we have set it to HCI only when we do not know about
> > it well.
> > 
> > Add support to route to the best controller according to current USB mode
> > (host/peripheral).
> > 
> > Note: Currently even if hardware only support hostmode, we should still
> > enable the MUSB controller, as it controls the USB mode. (Some this kind
> > of hardware can also work in peripheral mode by settings in the sysfs
> > node of MUSB, then connect it to another host via a USB Type-A to Type-A
> > cable.)
> > 
> > Patch 1 changes the device tree binding to include the "pmu0" for HCI pair.
> > 
> > Patch 2 and 3 are fixes for H3 PHY, in order to make MUSB really working
> > on H3.
> > 
> > Patch 4 adds support for auto routing of PHY0. It's currently only enabled
> > on H3, but it's easy to extend it to other SoCs which feature this
> > route control.
> 
> merged the 1st four patch of this series.

And applied the last four.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/6759d5f6/attachment.sig>
