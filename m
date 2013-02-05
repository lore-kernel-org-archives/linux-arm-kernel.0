From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 10:38:28 +0200
Subject: [PATCH v2 4/6] ARM: dts: omap5: add dwc3 omap dt data
In-Reply-To: <5110C2E6.30504@ti.com>
References: <1359112312-6918-1-git-send-email-kishon@ti.com>
 <1359112312-6918-5-git-send-email-kishon@ti.com>
 <510432BF.80808@mvista.com> <5110C2E6.30504@ti.com>
Message-ID: <20130205083828.GE32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 01:59:26PM +0530, kishon wrote:
> On Sunday 27 January 2013 01:17 AM, Sergei Shtylyov wrote:
> >Hello.
> >
> >On 25-01-2013 15:11, Kishon Vijay Abraham I wrote:
> >
> >>Add dwc3 omap glue data to the omap5 dt data file. The information about
> >>the dt node added here is available @
> >>Documentation/devicetree/bindings/usb/omap-usb.txt
> >
> >>Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>---
> >>  arch/arm/boot/dts/omap5.dtsi |   11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >
> >>diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> >>index 5f59bf2..1703a72 100644
> >>--- a/arch/arm/boot/dts/omap5.dtsi
> >>+++ b/arch/arm/boot/dts/omap5.dtsi
> >>@@ -513,6 +513,17 @@
> >>              ti,type = <2>;
> >>          };
> >>
> >>+        omap_dwc3 at 4a020000 {
> >>+            compatible = "ti,dwc3";
> >>+            ti,hwmods = "usb_otg_ss";
> >>+            reg = <0x4a020000 0x1ff>;
> >
> >    Shoudn't the "reg" length be 0x200 here? It's length, not limit.
> 
> I think 0x1ff is correct. I got the data from hwmod data.

hwmod is utterly wrong. Looking at TRM, it says the size here is 64KiB
(0x10000), so is the size for dwc3 itself. Please don't blindly trust
hwmod, make sure you read data from TRM ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/4e925b99/attachment.sig>
