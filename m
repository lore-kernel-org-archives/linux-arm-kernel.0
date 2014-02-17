From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 17 Feb 2014 10:11:37 +0100
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
Message-ID: <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 9:02 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Mon, Feb 17, 2014 at 4:54 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> On Sun, Feb 16, 2014 at 10:40:55AM +0100, Wolfram Sang wrote:
>>> From: Wolfram Sang <wsa@sang-engineering.com>
>>>
>>> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
>>
>> From your other mail:
>>
>> "[2/5] needs to be reworked to exclude the r8a7790 compatible string."
>>
>>> +             compatible = "renesas,i2c-r8a7791", "renesas,i2c-r8a7790";
>>
>> Why is that? From my knowledge, you start with the exact compatible
>> property and hardware compatible entries may follow.

Thanks for posting the link to the device tree wiki/quoting from it.
I had faint memories of that quote, but couldn't remember where I read it.

> I think this boils down to if they really are compatible or not. If
> for instance a 16550 port would be compatible with 8250 on a hardware
> level then using them in the order of "16550", "8250" makes sense. In
> this case the r8a7791 i2c is not really strictly based on r8a7790 i2c,
> it is just that r8a7790 has support in the driver. So it's a short cut
> instead of actual hardware compatibility.
>
> So far we've dealt with this by updating the driver and only relying
> on the actual SoC name as suffix.
>
> I'm sure there are tons of opinions. =)

Hehe ;-)

I think the tricky part is when a driver for "renesas,i2c-r8a7790" is updated
with a new feature for r8a7790, which doesn't necessarily exist in r8a7791.
Then the compatible entry above will cause breakage.

In our case, this probably won't happen, as we will have "renesas,i2c-r8a7791"
in the driver, but the driver could be forked in between the addition of
"renesas,i2c-r8a7790" and "renesas,i2c-r8a7791" in our non-ideal world.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
