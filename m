From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 1 Nov 2017 19:41:15 -0500
Subject: [PATCH v6 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <CAP6Zq1jPva2sFMYaNoN6C_4sXL9q=W_Wyt9Hy3+OsG6UJUVd6w@mail.gmail.com>
References: <20170919224001.22284-1-brendanhiggins@google.com>
 <20170919224001.22284-3-brendanhiggins@google.com>
 <CAP6Zq1jPva2sFMYaNoN6C_4sXL9q=W_Wyt9Hy3+OsG6UJUVd6w@mail.gmail.com>
Message-ID: <CAL_JsqKgwepy4Kb21oikYRsOtFpKJFTiLRs4q613AX+9opHQKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 3:33 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
> On 20 September 2017 at 00:40, Brendan Higgins
> <brendanhiggins@google.com> wrote:
>> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
>> specific device tree for the NPCM750 (Poleg) evaluation board.
>>

>> +                       timer0: timer at f0000000 {
>> +                               compatible = "nuvoton,npcm750-timer";
>> +                               interrupts = <0 32 4>;
>> +                               reg = <0xf0000000 0x1000>;
>> +                               clocks = <&clk NPCM7XX_CLK_TIMER>;
>> +                       };
>
> I started the upstream process of NPCM7xx clocksource driver, I got
> the following comment:
> https://www.spinics.net/lists/devicetree/msg197916.html
>
> Is it possible to modify the the timer DT entry to:
>
> timer0: timer at f0008000 {
>         compatible = "nuvoton,npcm7xx-timer";

Please don't. Using 750 is correct. Using 7xx (i.e. wildcards) is not.

If there's subsequent SoCs with the same block, then you can do:
'"nuvoton,npcm760-timer", "nuvoton,npcm750-timer"'.

Rob
