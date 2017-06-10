From: icenowy@aosc.io (icenowy at aosc.io)
Date: Sat, 10 Jun 2017 23:26:47 +0800
Subject: [linux-sunxi] Re: [PATCH v2 01/11] dt-bindings: update the
 binding for Allwinner H3 TVE support
In-Reply-To: <7305754.diZEu7DK25@jernej-laptop>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170609164915.enap3epreg5vr2gy@flea.home>
 <53E8FC74-8AC0-461A-B875-812EE4A3267E@aosc.io>
 <7305754.diZEu7DK25@jernej-laptop>
Message-ID: <34f5ad92200d09a854d4b62ef7d60a4f@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-06-10 05:24?Jernej ?krabec ???
> Hi!
> 
> Dne petek, 09. junij 2017 ob 18:51:02 CEST je Icenowy Zheng napisal(a):
>> ? 2017?6?10? GMT+08:00 ??12:49:15, Maxime Ripard <maxime.ripard@free-
> electrons.com> ??:
>> >On Wed, Jun 07, 2017 at 04:48:50PM +0800, Icenowy Zheng wrote:
>> >> >> @@ -189,6 +211,8 @@ supported.
>> >> >>
>> >> >>  Required properties:
>> >> >>    - compatible: value must be one of:
>> >> >>      * allwinner,sun8i-v3s-de2-mixer
>> >> >>
>> >> >> +    * allwinner,sun8i-h3-de2-mixer0
>> >> >> +    * allwinner,sun8i-h3-de2-mixer1
>> >> >
>> >> >Again, please explain why we need to have different compatibles
>> >> >here. If it's only about the number of planes, this should be dealt
>> >> >with a property, not a compatible.
>> >>
>> >> Only mixer0 has "VEP" and write-back support, at least on H3.
>> >
>> >What is that VEP? writeback support can also be expressed by a
>> >property.
>> 
>> I don't know what VEP is...
> 
> VEP is probably Video Enhancement Processor (?). Although I'm not sure 
> if that
> is really mixer specific. Icenowy, can you explain where did you get 
> this info?

In 
lichee/linux-3.4/drivers/video/sunxi/disp2/disp/de/lowlevel_sun8iw7/de_feat.c:

static const int de_is_support_vep[] = {
	/* DISP0 CH0 */
	1,
	/* DISP0 CH1 */
	0,
	/* DISP0 CH2 */
	0,
	/* DISP0 CH3 */
	0,
	/* DISP1 CH0 */
	0,
	/* DISP1 CH1 */
	0,
};

> 
> Best regards,
> Jernej
> 
>> 
>> But we are really facing different cores, like sun50i-a64-mmc
>> and sun50i-a64-emmc.
>> 
>> >Maxime
>> 
>> --
>> You received this message because you are subscribed to the Google 
>> Groups
>> "linux-sunxi" group. To unsubscribe from this group and stop receiving
>> emails from it, send an email to 
>> linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
