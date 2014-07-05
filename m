From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sat, 5 Jul 2014 02:28:24 +0200
Subject: [PATCH v9 3/3] dt-bindings: add mtk-timer bindings
In-Reply-To: <5b2c6b68-6177-47f4-937a-077b4f3c89a4@BN1AFFO11FD048.protection.gbl>
References: <1403264929-21325-1-git-send-email-matthias.bgg@gmail.com>
 <1403264929-21325-4-git-send-email-matthias.bgg@gmail.com>
 <20140620123602.GK30188@leverpostej>
 <CABuKBeKknz7OEyffKOGK=yk7ZH7fj7Jf9fgPhw2VGbTC-p21qw@mail.gmail.com>
 <5b2c6b68-6177-47f4-937a-077b4f3c89a4@BN1AFFO11FD048.protection.gbl>
Message-ID: <CABuKBeLv+wC9Fe=P40pBvU+R3KrEUyTWj2Gs3tg2qjjm2HONsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-07-01 20:00 GMT+02:00 S?ren Brinkmann <soren.brinkmann@xilinx.com>:
> On Tue, 2014-07-01 at 07:46PM +0200, Matthias Brugger wrote:
>> 2014-06-20 14:36 GMT+02:00 Mark Rutland <mark.rutland@arm.com>:
>> > On Fri, Jun 20, 2014 at 12:48:49PM +0100, Matthias Brugger wrote:
>> >> Add binding documentation for the General Porpose Timer driver of
>> >> the Mediatek SoCs.
>> >>
>> >> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> >> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>> >> Acked-by: Rob Herring <robh@kernel.org>
>> >> ---
>> >>  .../bindings/timer/mediatek,mtk-timer.txt          |   18 ++++++++++++++++++
>> >>  1 file changed, 18 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> >> new file mode 100644
>> >> index 0000000..10b7e09
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> >> @@ -0,0 +1,18 @@
>> >> +Mediatek MT6577, MT6572 and MT6589 Timers
>> >> +---------------------------------------
>> >> +
>> >> +Required properties:
>> >> +- compatible: Should be "mediatek,mt6577-timer"
>> >> +- reg: Should contain location and length for timers register.
>> >> +- clocks: Clocks driving the timer hardware. This list should include two
>> >> +     clocks. The order is system clock and as second clock the RTC clock.
>> >> +
>> >> +Examples:
>> >> +
>> >> +     timer at 10008000 {
>> >> +             compatible = "mediatek,mt6577-timer";
>> >> +             reg = <0x10008000 0x80>;
>> >> +             interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
>> >> +             clocks = <&system_clk>, <&rtc_clk>;
>> >> +             clock-names = "system-clk", "rtc-clk";
>> >
>> > These names should be mentioned above, or removed.
>>
>> I added the clock-names to make it the clock order clearer, as it is
>> done in the arm sp,804 [1].
>> But I think it is clear enough through the phandle names and the
>> description of the clocks property.
>> So I will delete the clock-names in the v10 round.
>
> I think I originally advocated for adding those names. And my argument
> was that the names in the dts are probably not clearly identifying the
> timer IP's clock inputs since they refer to SOC names for the clocks. We
> had this argument for a while now and it doesn't seem to get better
> than this. But to explain why I try to get IP vs. SOC clock names in
> here is, that I had such a case with Zynq's Ethernet core. That IP has
> quite a few clock inputs and luckily the mainline driver for that IP
> used the proper names from the IP data sheet for the clocks instead
> of the SOC names. That made it relatively easy to match things with the
> Zynq integration of that IP. Had that driver used SOC clock names,
> things would have been more difficult.

S?ren, I get the point. The problem is, that we don't have any
documentation other then the SoC datasheet for the timer.
Anyway the clock-names property does not help us in this at all. As I
already mentioned, the clock-names property was to illustrate the
clock order, but as I think, with the comment for the clocks property,
the order is clear enough.

Shall I delete your ack, when I resend the patch without the
clock-names property?

Regards,
Matthias

>
>         S?ren



-- 
motzblog.wordpress.com
