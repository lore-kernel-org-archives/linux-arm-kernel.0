From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 08:04:17 -0600
Subject: [RESEND PATCH 6/6] dt-bindings: phy-mt65xx-usb: add support for
 mt2712 platform
In-Reply-To: <1485053419.10292.88.camel@mhfsdcap03>
References: <1484719214-11989-1-git-send-email-chunfeng.yun@mediatek.com>
 <1484719214-11989-6-git-send-email-chunfeng.yun@mediatek.com>
 <20170121200844.k5ivauhws43ac2s2@rob-hp-laptop>
 <1485053419.10292.88.camel@mhfsdcap03>
Message-ID: <CAL_JsqJkJwwfqq6ezyNiQXyefR8V=q6_hOUPVmssEGs_pdxhuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 21, 2017 at 8:50 PM, Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> On Sat, 2017-01-21 at 14:08 -0600, Rob Herring wrote:
>> On Wed, Jan 18, 2017 at 02:00:14PM +0800, Chunfeng Yun wrote:
>> > add a new compatible string for "mt2712", and a new reference clock
>> > for SuperSpeed analog phy;
>> >
>> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> > ---
>> >  .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |   81 +++++++++++++++++---
>> >  1 file changed, 70 insertions(+), 11 deletions(-)

[...]

>> > @@ -31,21 +37,27 @@ Example:
>> >  u3phy: usb-phy at 11290000 {
>> >     compatible = "mediatek,mt8173-u3phy";
>> >     reg = <0 0x11290000 0 0x800>;
>> > -   clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
>> > -   clock-names = "u3phya_ref";
>> > +   clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>, <&clk26m>;
>> > +   clock-names = "u2ref_clk", "u3ref_clk";
>> >     #address-cells = <2>;
>> >     #size-cells = <2>;
>> >     ranges;
>> >     status = "okay";
>> >
>> > -   phy_port0: port at 11290800 {
>> > -           reg = <0 0x11290800 0 0x800>;
>> > +   u2port0: port at 11290800 {
>>
>> port is for OF graph. This should be usb-phy at ... instead.
> Is there any problems if u2port0's name at addr is the same as its parent's
> (u3phy)?  as following:
>         u3phy: usb-phy at 11290000 {
>                 compatible = ...;
>                 // no reg property
>                 clocks = ...;
>                 u2port0: usb-phy at 11290000 {
>                         reg = ...;
>         }

No problem, that is fine.

Rob
