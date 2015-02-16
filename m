From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 16 Feb 2015 15:04:16 +0100
Subject: [PATCH/RFC] ARM: shmobile: r8a7790: Fix HSUSB clock to hp_clk
 from mp_clk
In-Reply-To: <20150216135754.GA5479@verge.net.au>
References: <1424011746-3787-2-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdX=cdHaiHCnYsJvZFc2RNv=Pk8cLXuvkezg4Ht4U4mXsg@mail.gmail.com>
 <20150216135754.GA5479@verge.net.au>
Message-ID: <CAMuHMdUHMA+cJTGWS-0Prt6-BT5=UkGQ4OWZ+bz-g2G7DSwLzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Feb 16, 2015 at 2:57 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Feb 16, 2015 at 10:20:10AM +0100, Geert Uytterhoeven wrote:
>> Hi Kaneko-san, Mizuguchi-san,
>>
>> On Sun, Feb 15, 2015 at 3:49 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>> >
>> > HSUSB uses hp_clk for H/W register access.
>>
>> That indeed seems to be true, and that's what this patch is changing.
>>
>> > HSUSB uses mp_clk for USB-DMAC access.
>>
>> However, page 64-2 doesn't mention the MP clock for USB-DMAC:
>>    "AXI bus clock (ZS?: 260 MHz), HPB bus clock (HP?: 130 MHz).
>>     USB local bus clock (48 MHz)"
>> So your statement doesn't seem to be true?
>
> Thanks, I see that too.
>
>> Note that mstp3_clks in dtsi has hp_clk as the parent for both usbdmac0 and
>> usbdmac1, so if your statement would be true, that has to changed, too?
>>
>> The same is true for other members of the R-Car Gen2 family, e.g. your patch
>> for r8a7791.
>
> It seems to me that we could:
>
> 1. Apply this patch with the changelog updated and;
> 2. Follow up on the DMAC clocks
>
> Does that sound reasonable to you?

Yes, that sounds fine to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
