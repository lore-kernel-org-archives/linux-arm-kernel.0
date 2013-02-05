From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:46:51 +0200
Subject: [PATCH v2 4/6] ARM: dts: omap5: add dwc3 omap dt data
In-Reply-To: <5110CBB9.5080307@ti.com>
References: <1359112312-6918-1-git-send-email-kishon@ti.com>
 <1359112312-6918-5-git-send-email-kishon@ti.com>
 <510432BF.80808@mvista.com> <5110C2E6.30504@ti.com>
 <20130205083828.GE32118@arwen.pp.htv.fi> <5110C6EC.6050606@ti.com>
 <5110CBB9.5080307@ti.com>
Message-ID: <20130205094650.GO32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 02:37:05PM +0530, Santosh Shilimkar wrote:
> On Tuesday 05 February 2013 02:16 PM, kishon wrote:
> >Hi,
> >
> >On Tuesday 05 February 2013 02:08 PM, Felipe Balbi wrote:
> >>On Tue, Feb 05, 2013 at 01:59:26PM +0530, kishon wrote:
> >>>On Sunday 27 January 2013 01:17 AM, Sergei Shtylyov wrote:
> >>>>Hello.
> >>>>
> >>>>On 25-01-2013 15:11, Kishon Vijay Abraham I wrote:
> >>>>
> >>>>>Add dwc3 omap glue data to the omap5 dt data file. The information
> >>>>>about
> >>>>>the dt node added here is available @
> >>>>>Documentation/devicetree/bindings/usb/omap-usb.txt
> >>>>
> >>>>>Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>>>---
> >>>>>  arch/arm/boot/dts/omap5.dtsi |   11 +++++++++++
> >>>>>  1 file changed, 11 insertions(+)
> >>>>
> >>>>>diff --git a/arch/arm/boot/dts/omap5.dtsi
> >>>>>b/arch/arm/boot/dts/omap5.dtsi
> >>>>>index 5f59bf2..1703a72 100644
> >>>>>--- a/arch/arm/boot/dts/omap5.dtsi
> >>>>>+++ b/arch/arm/boot/dts/omap5.dtsi
> >>>>>@@ -513,6 +513,17 @@
> >>>>>              ti,type = <2>;
> >>>>>          };
> >>>>>
> >>>>>+        omap_dwc3 at 4a020000 {
> >>>>>+            compatible = "ti,dwc3";
> >>>>>+            ti,hwmods = "usb_otg_ss";
> >>>>>+            reg = <0x4a020000 0x1ff>;
> >>>>
> >>>>    Shoudn't the "reg" length be 0x200 here? It's length, not limit.
> >>>
> >>>I think 0x1ff is correct. I got the data from hwmod data.
> >>
> >>hwmod is utterly wrong. Looking at TRM, it says the size here is 64KiB
> >>(0x10000), so is the size for dwc3 itself. Please don't blindly trust
> >>hwmod, make sure you read data from TRM ;-)
> >
> >hmm..ok. But it has only 17 registers :-D
> >
> As Felipe said, it should be 0x200. And if you are
> interested in lesser space, there is no need to map entire 64 KB
> address space if it isn't being used.

We get really close to using all of it. For DWC3, the last address is at
0xcc10 (a 32-bit register).

For dwc3-wrapper, then it's correct, we don't use it, I would still map
the whole thing to make it future proof.

Any draw-backs from mapping all 64K ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/3756f02e/attachment.sig>
