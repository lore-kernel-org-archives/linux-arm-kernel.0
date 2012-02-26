From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 26 Feb 2012 10:41:16 +0100
Subject: [GIT PULL] ux500 patches for v3.4
In-Reply-To: <201202241625.13080.arnd@arndb.de>
References: <1329809787-2788-1-git-send-email-linus.walleij@linaro.org>
 <201202241523.18355.arnd@arndb.de>
 <CACRpkdZfkcAD2WqOCcDfSbiiBJxEvic5QmyzpyvUfHX39cDf9Q@mail.gmail.com>
 <201202241625.13080.arnd@arndb.de>
Message-ID: <CACRpkdbqsMOeA1BPo+0iWyZCTiaOJQ3Pr40-DGjO81Vkryhg0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 5:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 24 February 2012, Linus Walleij wrote:
>> > Then you just need to find a convenient value for UX500_ASICID_VIRT
>> > that does not conflict with the other static mappings.
>>
>> But the problem is that the ASIC address is not
>> at all constant across ASIC variants. They are on different
>> places in the ROM for U8500, U5500. U9540... So as described
>> above we already know the main type of ASIC, but we need to
>> read this value to get the subvariant, process etc.
>>
>> So there is no such thing as UX500_ASICID_ADDR.
>>
>> Unless we defines it with #ifdefs and compile a kernel for just
>> U8500, U5500 or U9540 and that's mainly what we want to
>> get away from you know...
>
> My point was that you use the same virtual address here independent
> of which physical address is used. The physical address already gets
> passed into the function as its argument, we only need to map it
> to a convenient place in order to read it!

Oh sorry I'm slow in the head :-/

Yes that should work of course, I will attempt to make an additional
patch on top of these that consolidates the whole thing into one
function that does that.

Thanks Arnd!
Linus Walleij
