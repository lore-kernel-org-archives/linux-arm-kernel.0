From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 12 Jul 2018 08:46:01 +0200
Subject: [linux-sunxi] Re: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output
 on Banana Pi M2 Zero
In-Reply-To: <8F6CDF5C-2AC1-43EC-858A-5C6345CF279A@aosc.io>
References: <20180711132233.42301-1-icenowy@aosc.io>
 <20180711132233.42301-2-icenowy@aosc.io>
 <20180711150532.6gzm7krouriddreh@flea>
 <8F6CDF5C-2AC1-43EC-858A-5C6345CF279A@aosc.io>
Message-ID: <20180712064601.m3bdd46wzac5fpgh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 11:15:50PM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2018?7?11? GMT+08:00 ??11:05:32, Maxime Ripard <maxime.ripard@bootlin.com> ??:
> >Hi,
> >
> >On Wed, Jul 11, 2018 at 09:22:32PM +0800, Icenowy Zheng wrote:
> >> Banana Pi M2 Zero board has a miniHDMI port connected to the HDMI
> >> controller of Allwinner H3 SoC.
> >> 
> >> Enable the HDMI output in Banana Pi M2 Zero device tree.
> >> 
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25
> >+++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> index 7d01f9322658..eb61dcf32797 100644
> >> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> @@ -26,6 +26,17 @@
> >>  		stdout-path = "serial0:115200n8";
> >>  	};
> >>  
> >> +	hdmi-connector {
> >> +		compatible = "hdmi-connector";
> >> +		type = "c";
> >
> >This is not one of the connector type declared in DRM, how is it
> >exposed to the userspace?
> 
> So just use "A" here (because of single link)?

If the connector type is C, it should be C, and DRM / driver adjusted
to handle it.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180712/c463380a/attachment-0001.sig>
