From: joel@jms.id.au (Joel Stanley)
Date: Wed, 27 Apr 2016 18:01:00 +0930
Subject: [PATCH v2 03/11] doc/devicetree: Add Aspeed clock bindings
In-Reply-To: <4956403.scaVRGhPEf@diego>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-4-git-send-email-joel@jms.id.au> <4956403.scaVRGhPEf@diego>
Message-ID: <CACPK8XfvLR+yZv77C0Eq=RsPOufrwvQjdPtBhnufNc=eJRLZYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 8:50 PM, Heiko St?bner <heiko@sntech.de> wrote:
> [+clock-related patches should include clock-maintainers and lists]

Thanks.

> Am Donnerstag, 21. April 2016, 17:34:01 schrieb Joel Stanley:
>> +For example:
>> +
>> +     clk_clkin: clk_clkin {
>> +             #clock-cells = <0>;
>> +             compatible = "fixed-clock";
>> +             clock-frequency = <48000000>;
>> +     };
>> +
>> +     clk_hpll: clk_hpll {
>> +             compatible = "aspeed,g4-hpll-clock";
>> +             #clock-cells = <0>;
>> +             reg = <0x1e6e2008 0x4>;
>> +     };
>> +
>> +     clk_apb: clk_apb at 1e6e2008 {
>> +             #clock-cells = <0>;
>> +             compatible = "aspeed,g4-apb-clock";
>> +             reg = <0x1e6e2008 0x4>;
>> +             clocks = <&clk_hpll>;
>> +     };
>
> You have both the hpll and apb_clk in the same register (probably even more
> clocks?) and separate clock instances where each instance will of_iomap the
> register itself (and thus multiple times in general).

Yep. I agree that's not ideal.

>
> From what I remember exposing the clock controller as one block (instead of
> declaring each clock individually in the dts) is still the preferred way but I
> don't think I can find Mike's mail from back then easily.

I can't picture how that would look. I took my lead from the moxart
clock driver; is there a better example that I should follow?

Cheers,

Joel
