From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 29 Aug 2015 10:07:12 +0800
Subject: [PATCH 2/6] ARM: dts: sunxi: Add dtsi for AXP221 PMIC
In-Reply-To: <20150828204351.GS29389@lukather>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
 <1440755679-8266-3-git-send-email-wens@csie.org>
 <20150828123159.GJ29389@lukather>
 <CAGb2v66nBh+_P=EDxrNYeFoUUXqPWuZyfq1OEQww_aSMhT8wVQ@mail.gmail.com>
 <20150828204351.GS29389@lukather>
Message-ID: <CAGb2v66qxgpGGzYHTP8=m-jhy2B2W2Z0iQmSed+e49PJVX_Q_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 29, 2015 at 4:43 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Aug 29, 2015 at 12:09:55AM +0800, Chen-Yu Tsai wrote:
>> >> +/*
>> >> + * AXP221/221s/223 Integrated Power Management Chip
>> >> + * http://www.x-powers.com/product/AXP22X.php
>> >> + * http://dl.linux-sunxi.org/AXP/AXP221%20Datasheet%20V1.2%2020130326%20.pdf
>> >> + */
>> >
>> > I'm usually not really fond of URLs in the source code and/or the
>> > commit logs. They tend to be broken very easily.
>>
>> OK. Would you rather I put them in Documentation/arm/sunxi/README?
>> It's not immediately clear that sunxi and axp* are connected though.
>
> It's one of the first things that pop up when googling, and it's not
> really related to sunxi, so I'd say simply leave them out.

Ok.

>> >> +
>> >> +&axp221 {
>> >> +     compatible = "x-powers,axp221";
>> >> +     interrupt-controller;
>> >> +     #interrupt-cells = <1>;
>> >> +
>> >> +     regulators {
>> >> +             /* Default work frequency for buck regulators */
>> >> +             x-powers,dcdc-freq = <3000>;
>> >> +
>> >> +             /* supplies for dc1sw & dc5ldo are connected internally */
>> >> +             dcdc1-supply = <&reg_dcdc1>;
>> >> +             dcdc5-supply = <&reg_dcdc5>;
>> >
>> > so the parent regulator of DCDC1 is DCDC1 ?
>>
>> These probably aren't the best names. These are the supplies for DC1SW and
>> DC5LDO, respectively. They are connected internally, so there aren't named
>> pins for them. The comment above explains it, though probably not clearly
>> enough. Furthermore, the input pins for DCDC1/5 are VIN1/5.
>
> I'm not quite sure I understand. They're connected internally but they
> have pins ?

Internally, DCDC1's output feeds the input for DC1SW (which is just a switch
BTW), and DCDC5's output feeds DC5LDO (which is an LDO). Both these extra
regulators have separate controls. There are no external pins to name the
supplies after, so I just named them after which regulator supplies them.

ChenYu
