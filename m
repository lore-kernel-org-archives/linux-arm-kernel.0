From: balbi@ti.com (Felipe Balbi)
Date: Fri, 25 Jan 2013 10:45:01 +0200
Subject: [PATCH v3 1/4] drivers: usb: phy: add a new driver for usb part
 of control module
In-Reply-To: <51024581.6020301@ti.com>
References: <1359080391-5120-1-git-send-email-kishon@ti.com>
 <1359080391-5120-2-git-send-email-kishon@ti.com>
 <510218FE.8080606@wwwdotorg.org>
 <20130125074818.GF15886@arwen.pp.htv.fi> <51024581.6020301@ti.com>
Message-ID: <20130125084501.GI15886@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Fri, Jan 25, 2013 at 02:12:41PM +0530, kishon wrote:
> On Friday 25 January 2013 01:18 PM, Felipe Balbi wrote:
> >On Thu, Jan 24, 2013 at 09:32:46PM -0800, Stephen Warren wrote:
> >>On 01/24/2013 06:19 PM, Kishon Vijay Abraham I wrote:
> >>>Added a new driver for the usb part of control module. This has an API
> >>>to power on the USB2 phy and an API to write to the mailbox depending on
> >>>whether MUSB has to act in host mode or in device mode.
> >>>
> >>>Writing to control module registers for doing the above task which was
> >>>previously done in omap glue and in omap-usb2 phy will be removed.
> >>
> >>>diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/usb/usb-phy.txt
> >>
> >>This file seems to be specific to the TI USB PHYs, not all USB PHYs;
> >>shouldn't it be renamed ti-usb-phy.txt, or even better renamed to match
> >>the compatible value it documents, giving ti,omap-usb2.txt?
> >
> >could be, but that can be done as a separate patch. It's not part of
> >$SUBJECT.
> >
> >>>  add the address of control module dev conf register until a driver for
> >>>  control module is added
> >>>
> >>>+Optional properties:
> >>>+ - ctrl_module : phandle of the control module used by PHY driver to power on
> >>>+   the PHY.
> >>
> >>DT property names generally use - not _ as the word separator.
> >
> >fair enough, Kishon, can you fix this up ?
> 
> Sure. Will post a patch..

Great, notice that I've already applied some of your patches to my tree.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130125/e0bd2cfb/attachment.sig>
