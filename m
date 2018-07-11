From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 11 Jul 2018 23:19:00 +0800
Subject: [linux-sunxi] Re: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output
 on Banana Pi M2 Zero
In-Reply-To: <3039364.lZKhBVCAIj@jernej-laptop>
References: <20180711132233.42301-1-icenowy@aosc.io>
 <20180711132233.42301-2-icenowy@aosc.io>
 <20180711150532.6gzm7krouriddreh@flea> <3039364.lZKhBVCAIj@jernej-laptop>
Message-ID: <2D440118-7036-4AA3-976C-A43116F459E7@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?11? GMT+08:00 ??11:14:19, "Jernej ?krabec" <jernej.skrabec@gmail.com> ??:
>Dne sreda, 11. julij 2018 ob 17:05:32 CEST je Maxime Ripard napisal(a):
>> Hi,
>> 
>> On Wed, Jul 11, 2018 at 09:22:32PM +0800, Icenowy Zheng wrote:
>> > Banana Pi M2 Zero board has a miniHDMI port connected to the HDMI
>> > controller of Allwinner H3 SoC.
>> > 
>> > Enable the HDMI output in Banana Pi M2 Zero device tree.
>> > 
>> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> > ---
>> > 
>> >  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25
>+++++++++++++++++++
>> >  1 file changed, 25 insertions(+)
>> > 
>> > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> > b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts index
>> > 7d01f9322658..eb61dcf32797 100644
>> > --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> > +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> > @@ -26,6 +26,17 @@
>> > 
>> >  		stdout-path = "serial0:115200n8";
>> >  	
>> >  	};
>> > 
>> > +	hdmi-connector {
>> > +		compatible = "hdmi-connector";
>> > +		type = "c";
>> 
>> This is not one of the connector type declared in DRM, how is it
>> exposed to the userspace?
>
>DT binding allows it:
>
>HDMI Connector
>==============
>
>Required properties:
>- compatible: "hdmi-connector"
>- type: the HDMI connector type: "a", "b", "c", "d" or "e"
>
>but DW HDMI bridge driver hardcodes it to type A. Actually, kernel has
>defines 
>only for type A and B.

I assume it's for single link/dual link.

>
>Actually, many HDMI drivers have type A hardcoded...
>
>Best regards,
>Jernej
