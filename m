From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Jan 2013 14:45:51 +0200
Subject: [PATCH 2/2] ARM: dts: omap: Add omap-usb2 dt data
In-Reply-To: <50EE9517.3030703@ti.com>
References: <1348050772-27819-1-git-send-email-kishon@ti.com>
 <1348050772-27819-3-git-send-email-kishon@ti.com>
 <50EE8A89.4010801@ti.com> <50EE921D.8020601@ti.com>
 <50EE9517.3030703@ti.com>
Message-ID: <20130110124551.GU28920@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 03:46:55PM +0530, kishon wrote:
> Hi,
> 
> On Thursday 10 January 2013 03:34 PM, Benoit Cousson wrote:
> >On 01/10/2013 10:31 AM, kishon wrote:
> >>Hi Benoit,
> >>
> >>On Wednesday 19 September 2012 04:02 PM, Kishon Vijay Abraham I wrote:
> >>>Add omap-usb2 data node in omap4 device tree file. Since omap-usb2 is
> >>>connected to ocp2scp, omap-usb2 dt data is added as a child node
> >>>of ocp2scp.
> >>>
> >>>Acked-by: Felipe Balbi <balbi@ti.com>
> >>>Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>
> >>This patch is also missing in mainline :-(
> >
> >Well, in that case this was done on purpose :-)
> >
> >>
> >>Thanks
> >>Kishon
> >>
> >>>---
> >>>   arch/arm/boot/dts/omap4.dtsi |    5 +++++
> >>>   1 file changed, 5 insertions(+)
> >>>
> >>>diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> >>>index 4fbb9dc..28eaddc 100644
> >>>--- a/arch/arm/boot/dts/omap4.dtsi
> >>>+++ b/arch/arm/boot/dts/omap4.dtsi
> >>>@@ -303,6 +303,11 @@
> >>>               #size-cells = <1>;
> >>>               ranges;
> >>>               ti,hwmods = "ocp2scp_usb_phy";
> >>>+            usb2phy at 4a0ad080 {
> >>>+                compatible = "ti,omap-usb2";
> >>>+                reg = <0x4a0ad080 0x58>,
> >>>+                      <0x4a002300 0x4>; /* TO BE REMOVED: SCM */
> >
> >Rob and I did not agree to use that temp hack in the case of DT, so you
> >were supposed to repost with a proper driver for the SCM part that
> >control the USB.
> 
> Ok. Missed that. Will work on that.

Didn't Tony say we should access SCM directly since it's a one time
thing ?

Tony ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/f6159f88/attachment.sig>
