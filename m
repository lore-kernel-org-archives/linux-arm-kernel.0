From: cinifr@gmail.com (cinifr)
Date: Fri, 13 Sep 2013 00:23:21 +0800
Subject: [linux-sunxi] Re: [PATCH 4/4] Add arch count timer node in dts
 for Allwinner A20(sunxi 7i).
In-Reply-To: <1379000686.10076.76.camel@kazak.uk.xensource.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-5-git-send-email-cinifr@gmail.com>
 <20130912145756.GD22013@e106331-lin.cambridge.arm.com>
 <1379000686.10076.76.camel@kazak.uk.xensource.com>
Message-ID: <CAK3cCByUJG42D6w4e1tdnXY0TQ517yOjQxFZJEnsyS4d0bxZyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2013 23:44, Ian Campbell <ijc@hellion.org.uk> wrote:
> On Thu, 2013-09-12 at 15:57 +0100, Mark Rutland wrote:
>
>> > +                   interrupts = <1 13 0x308>,
>> > +                                <1 14 0x308>,
>> > +                                <1 11 0x308>,
>> > +                                <1 10 0x308>;
>> > +                   clock-frequency = <24000000>;
>>
>> If at all possible, your bootloader should set CNTFREQ, and
>> clock-frequency should only be used as a last resort when it's
>> impossible to get it to set CNTFREQ. It's not possible to set CNTFREQ
>> from the non-secure side, so guests (which might not be Linux, and might
>> not handle DT in the same way) may see a completely wrong frequency
>> value.
Yes, My bootloader dont set it, and I have to set it at  dtsi  fot
boot, I found <clock-frequency> is be set in dtsi file for ohters
cups.
