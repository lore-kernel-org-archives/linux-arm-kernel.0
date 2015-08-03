From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 3 Aug 2015 12:26:17 +0800
Subject: [linux-sunxi] [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage
 for sun7i-a20 to a level all boards can supply
In-Reply-To: <CAGRGNgXH90m9h0DDejd5MTf8enduGFQ8dPKrRhmc8Z6y_PaC1w@mail.gmail.com>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
 <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
 <CAGb2v67o-=_cL2RWfXJ+3C86zfQ_1b5DYRi3_zwvwy6su6+gdw@mail.gmail.com>
 <CAGRGNgXH90m9h0DDejd5MTf8enduGFQ8dPKrRhmc8Z6y_PaC1w@mail.gmail.com>
Message-ID: <CAGb2v67p5UhZ9Kwd_YEEQQzgiK7dgHqeQMckS7aw4HCFCCGoUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 3, 2015 at 12:22 PM, Julian Calaby <julian.calaby@gmail.com> wrote:
> Hi Chen-Yu,
>
> On Mon, Aug 3, 2015 at 12:37 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> Hi,
>>
>> On Mon, Aug 3, 2015 at 7:35 AM, Julian Calaby <julian.calaby@gmail.com> wrote:
>>> Hi Timo,
>>>
>>> On Mon, Aug 3, 2015 at 5:23 AM, Timo Sigurdsson
>>> <public_timo.s@silentcreek.de> wrote:
>>>> sun7i-a20.dtsi contains an cpufreq operating point at 0.9 volts. Most A20 boards
>>>> (or all?), however, do not allow the voltage to go below 1.0V. Thus, raise the
>>>> voltage for the lowest operating point to 1.0V so all boards can actually use
>>>> it.
>>>
>>> Surely it wouldn't be added here if some could supply 0.9v.
>>
>> On the side, the original OPPs in the FEX files are actually
>> frequency/voltage ranges, and not just points. Mainlines OPPv2
>> will support these, along with turbo frequencies.
>
> Ah, that makes sense.
>
>> Furthermore, the FEX files also have fields that limit the
>> minimum and maximum frequencies.
>
> Is this going to be supported by OPPv2 too?

IIRC yes, OPPv2 moves to a range profile. OPPv2 is not merged yet.

>>> Is the code that uses this smart enough to sensibly switch between two
>>> operating points with the same frequency and different voltages? If
>>> so, maybe just add a 144MHz @ 1.0v operating point?
>>
>> You could try. Though I really don't see much to gain here.
>
> From what I recall, lower frequency = less power usage, though my
> experience is from x86 laptops, not ARM SoCs and I'm sure I'm missing
> a lot of details. This is the sort of thing that requires thorough
> testing on a dev board.

I agree, though my limited experiences tell me that the major savings
come from lowering the core voltage.

>>> (Alternatively, would it make sense to modify the code that uses this
>>> to use frequencies with voltages specified that are lower than can be
>>> supplied with the lowest voltage it can?)
>>
>> I think that's a bit harder to get accepted.
>
> Oh, definitely. It kinda makes sense, but at the same time it'll
> require some seriously thorough testing on a lot of different boards.
>
> My only real objection here is are there boards that can go down to
> 0.9v and if so, won't this change make them less power efficient in
> the almost-idle case? And are those power savings enough to justify
> not accepting this patch?

This will require most testing as well. (sigh) Alas, my boards aren't
stable enough at 0.9V, so I can't say much about it.


ChenYu
