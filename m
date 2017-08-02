From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 03 Aug 2017 06:49:38 +0800
Subject: [linux-sunxi] [PATCH 01/13] dt-bindings: update the binding for
 Allwinner H3 DE2 support
In-Reply-To: <48442573.082BymFnMM@jernej-laptop>
References: <20170801131304.7741-1-icenowy@aosc.io>
 <79034825.lnfmIyYlWl@jernej-laptop>
 <d6c7c6de29be2674ad6b37b184d1df7f@aosc.io>
 <48442573.082BymFnMM@jernej-laptop>
Message-ID: <712DBBDE-0C7F-4333-A73C-29504FD9352C@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?8?3? GMT+08:00 ??3:06:26, "Jernej ?krabec" <jernej.skrabec@siol.net> ??:
>Hi,
>
>Dne sreda, 02. avgust 2017 ob 07:02:39 CEST je icenowy at aosc.io
>napisal(a):
>> ? 2017-08-02 12:53?Jernej ?krabec ???
>> 
>> > Hi Icenowy,
>> > 
>> > Dne torek, 01. avgust 2017 ob 15:12:52 CEST je Icenowy Zheng
>> > 
>> > napisal(a):
>> >> Allwinner H3 features a "Display Engine 2.0".
>> >> 
>> >> Add device tree bindings for the following parts:
>> >> - H3 TCONs
>> >> - H3 Mixers
>> >> - H3 Display engine
>> >> 
>> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> >> ---
>> >> 
>> >>  .../bindings/display/sunxi/sun4i-drm.txt           | 25
>> >> 
>> >> ++++++++++++++++++---- 1 file changed, 21 insertions(+), 4
>> >> deletions(-)
>> >> 
>> >> diff --git
>> >> a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> >> b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>index
>> >> 2ee6ff0ef98e..92512953943e 100644
>> >> ---
>a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> >> +++
>b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> >> 
>> >> @@ -87,18 +87,17 @@ Required properties:
>> >>     * allwinner,sun6i-a31-tcon
>> >>     * allwinner,sun6i-a31s-tcon
>> >>     * allwinner,sun8i-a33-tcon
>> >> 
>> >> +   * allwinner,sun8i-h3-tcon
>> >> 
>> >>     * allwinner,sun8i-v3s-tcon
>> >>   
>> >>   - reg: base address and size of memory-mapped region
>> >>   - interrupts: interrupt associated to this IP
>> >>   
>> >>   - clocks: phandles to the clocks feeding the TCON. Three are
>needed:
>> >>     - 'ahb': the interface clocks
>> >> 
>> >> -   - 'tcon-ch0': The clock driving the TCON channel 0
>> >> 
>> >>   - resets: phandles to the reset controllers driving the encoder
>> >>   
>> >>     - "lcd": the reset line for the TCON channel 0
>> >>   
>> >>   - clock-names: the clock names mentioned above
>> >>   - reset-names: the reset names mentioned above
>> >> 
>> >> - - clock-output-names: Name of the pixel clock created
>> >> 
>> >>  - ports: A ports node with endpoint definitions as defined in
>> >>  
>> >>    Documentation/devicetree/bindings/media/video-interfaces.txt.
>The
>> >> 
>> >> @@ -112,7 +111,23 @@ Required properties:
>> >>    channel the endpoint is associated to. If that property is not
>> >>    present, the endpoint number will be used as the channel
>number.
>> >> 
>> >> -On SoCs other than the A33 and V3s, there is one more clock
>required:
>> >> +For the following compatibles:
>> >> +   * allwinner,sun5i-a13-tcon
>> >> +   * allwinner,sun6i-a31-tcon
>> >> +   * allwinner,sun6i-a31s-tcon
>> >> +   * allwinner,sun8i-a33-tcon
>> >> +   * allwinner,sun8i-v3s-tcon
>> >> +there is one more clock and one more property required:
>> >> + - clocks:
>> >> +   - 'tcon-ch0': The clock driving the TCON channel 0
>> >> + - clock-output-names: Name of the pixel clock created
>> >> +
>> >> +For the following compatibles:
>> >> +   * allwinner,sun5i-a13-tcon
>> >> +   * allwinner,sun6i-a31-tcon
>> >> +   * allwinner,sun6i-a31s-tcon
>> >> +   * allwinner,sun8i-h3-tcon
>> >> 
>> >> +there is one more clock required:
>> >>     - 'tcon-ch1': The clock driving the TCON channel 1
>> >>  
>> >>  DRC
>> >> 
>> >> @@ -207,6 +222,8 @@ supported.
>> >> 
>> >>  Required properties:
>> >>    - compatible: value must be one of:
>> >>      * allwinner,sun8i-v3s-de2-mixer
>> >> 
>> >> +    * allwinner,sun8i-h3-de2-mixer0
>> >> +    * allwinner,sun8i-h3-de2-mixer1
>> > 
>> > About that, I concur with Maxime here, plane number properties
>would be
>> > better. If we don't do this now, we will never have it.
>> 
>> But I still prefer different compatibles, as the capabilities are
>> already
>> proven to be different between mixer0 and mixer1, and furtherly we
>> cannot
>> promise Allwinner won't add more functions only available at mixer0.
>> 
>> Then we will be trapped into a situation that we describe more and
>more
>> functions via properties, but they should be encoded into the
>> compatible.
>
>It is either multiple compatibles or multiple properties. I prefer the
>later, 
>but it is up to maintainers to decide.
>
>Anyway, I think DE2 will not evolve much since DE3 is almost ready
>(H6). At 
>least basics seems to be similar according to a BSP code drop.

According to what I heard from TL Lim, DE3 is just an evolution
to DE2.

>
>Regards,
>Jernej
>
>> 
>> > Reference:
>> >
>http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/512902.htm
>> > l
>> > 
>> > Regards,
>> > Jernej
>> 
>> --
>> You received this message because you are subscribed to the Google
>Groups
>> "linux-sunxi" group. To unsubscribe from this group and stop
>receiving
>> emails from it, send an email to
>linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
