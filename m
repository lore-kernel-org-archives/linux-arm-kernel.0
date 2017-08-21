From: icenowy@aosc.io (icenowy at aosc.io)
Date: Mon, 21 Aug 2017 16:44:30 +0800
Subject: [PATCH] ARM: sun8i: a33: add dts for Q8 tablets with different
 resolution
In-Reply-To: <20170821084053.s4qmhlvgsmckmqgh@flea.lan>
References: <20170817074926.3410-1-icenowy@aosc.io>
 <20170821084053.s4qmhlvgsmckmqgh@flea.lan>
Message-ID: <4a0a72b4679db296a8e48512c41a2ce5@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-08-21 16:40?Maxime Ripard ???
> On Thu, Aug 17, 2017 at 03:49:26PM +0800, Icenowy Zheng wrote:
>> Q8 tablets with Allwinner A33 SoC now come with two kind of LCD, 
>> either
>> 800x480 or 1024x600.
>> 
>> In order for sun4i-drm to be able to choose correct LCD configuration,
>> two different device trees should be present, one for a resolution.
>> 
>> Add stub device trees for two resolutions.
>> 
>> As the sun4i-drm driver still has some problems to support the LCDs, 
>> the
>> real LCD device nodes are not added to the device tree files.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> 
> This should be an overlay, ideally applied by the bootloader.

I think this is not suitable for overlay.

The two kind of Q8 tablets are not compatible at all, and they
should both have a suitable device tree. The old DT without
resolution is only kept for backward compatibility.

> 
> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
