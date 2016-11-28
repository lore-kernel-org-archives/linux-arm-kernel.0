From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 28 Nov 2016 18:24:24 +0800
Subject: [linux-sunxi] Re: [RFC PATCH] ARM: dts: sun8i: add simplefb node
 for H3
In-Reply-To: <496171480328390@web15g.yandex.ru>
References: <20161128095900.27615-1-icenowy@aosc.xyz>
 <CAGb2v67akcT6z-xOdCzpLQRZbgNGh3E5akYEs1BvFNP1rH8UeA@mail.gmail.com>
 <496171480328390@web15g.yandex.ru>
Message-ID: <CAGb2v66yQ2d=12P_MYyQXTfcZnNAMcb+0i=NEab4sNcJZUyL-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 6:19 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>
>
> 28.11.2016, 18:07, "Chen-Yu Tsai" <wens@csie.org>:
>> On Mon, Nov 28, 2016 at 5:59 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>>>  As there's currently a fork of U-Boot which provides simplefb support
>>
>> Please add it when its finalized...
>>
>>>  for H3, a simplefb node can be added to the device tree.
>>>
>>>  Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>>>  ---
>>>
>>>  I'm still not sure which pipeline should I use.
>>
>> You are supposed to add _all_ the pipelines that are available and
>> supported by U-boot. U-boot is then supposed to enable and update
>> the one it set up.
>
> I mean the pipeline string ;-)

Looks good to me. There's no separate frontend/backend in DE 2.0.

ChenYu

>
>>
>> ChenYu
>>
>>>  And, it seems that HDMI Slow Clock is not needed?
>>>
>>>  (seems that it's only for EDID, but simplefb won't use EDID)
>>>
>>>   arch/arm/boot/dts/sun8i-h3.dtsi | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>>  diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>>>  index 75a8654..cacc8dd 100644
>>>  --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>>>  +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>>>  @@ -50,6 +50,22 @@
>>>   / {
>>>          interrupt-parent = <&gic>;
>>>
>>>  + chosen {
>>>  + #address-cells = <1>;
>>>  + #size-cells = <1>;
>>>  + ranges;
>>>  +
>>>  + simplefb_hdmi: framebuffer at 0 {
>>>  + compatible = "allwinner,simple-framebuffer",
>>>  + "simple-framebuffer";
>>>  + allwinner,pipeline = "de0-lcd0-hdmi";
>>>  + clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_BUS_DE>,
>>>  + <&ccu CLK_BUS_HDMI>, <&ccu CLK_DE>,
>>>  + <&ccu CLK_TCON0>, <&ccu CLK_HDMI>;
>>>  + status = "disabled";
>>>  + };
>>>  + };
>>>  +
>>>          cpus {
>>>                  #address-cells = <1>;
>>>                  #size-cells = <0>;
>>>  --
>>>  2.10.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
