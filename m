From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 1 Sep 2016 14:42:41 +0800
Subject: [PATCH v2 3/7] dts: sun8i-h3: add i2c0/i2c1 SoC peripherals
In-Reply-To: <CAKqGPHwBqWn05SQqEPUQiwxi=WyBJ2LFto2Ucbh8w=Eqe49eTA@mail.gmail.com>
References: <1472671858-29220-1-git-send-email-jorik@kippendief.biz>
 <1472671858-29220-4-git-send-email-jorik@kippendief.biz>
 <CAGb2v66c8uFHUtVtHOZCfxDEEgG7CzZgBRKWMUQS7NTizF6jyQ@mail.gmail.com>
 <CAKqGPHwBqWn05SQqEPUQiwxi=WyBJ2LFto2Ucbh8w=Eqe49eTA@mail.gmail.com>
Message-ID: <CAGb2v66tW+F_aitXUkxTtwzfkijAwAP+OqC1gGQi6JgZN0w-2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 2:31 PM, Jorik Jonker <jorik@kippendief.biz> wrote:
> Hi,
>
> A bit tricky to reply to two mails in one, as I think my reply relates to
> both, but here it goes.
>
> On 1 September 2016 at 04:42, Chen-Yu Tsai <wens@csie.org> wrote:
>>
>> On Thu, Sep 1, 2016 at 3:30 AM,  <jorik@kippendief.biz> wrote:
>> > From: Jorik Jonker <jorik@kippendief.biz>
>> >
>> > This enables the i2c0/i2c1 peripherals of the SoC. There is actually a
>> > third
>> > controller, but I do not have a board on hands on which i2c2 is exposed
>> > in such
>> > a way that I can verify that it works.
>>
>> If they are listed in the manual, and the interrupts, clocks, resets, pins
>> all exist, that is good enough for me.
>
>
> That sounds sensible, I will do that in v3.
>
>> These pinmuxes are the only ones possible for each peripheral.
>> Please drop the _a suffix and the @0 address for both of them.
>
> Agreed. But: I think the same goes for UARTs 0-3, of which 0-1 have a pinmux
> following the _a / @0 syntax in current kernel. There are not really options
> here, except leaving out RTS/CTS on uarts1-3, which one could do in a
> board-specific pinmux.

That would work. You could also do the RTS/CTS pins and call them
"uartX_rts_cts_pins: uartX-rts-cts { ... }". Of course doing all these
is dependent on some board actually using them. Let's see what Maxime
has to say about your other patches. :)

> Moreover, I could put all the pinmux-peripheral associations for H3 in the
> DTSI, removing them from the DTS files (including already existing), as the
> associations themselves are not really board specific, right?

I've done so for a few peripherals, such as RSB and IR, where there are
only 1 set of pins that make sense. For 2/4/8 pin UARTs, MMC, LCDs, etc,
I wouldn't do it.

ChenYu
