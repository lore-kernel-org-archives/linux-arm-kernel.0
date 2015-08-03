From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 3 Aug 2015 10:37:35 +0800
Subject: [linux-sunxi] [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage
 for sun7i-a20 to a level all boards can supply
In-Reply-To: <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
 <CAGRGNgV6b9yt2HnB2x2Wyc05KEahoX-Y+mVhxsryztcfA36H1g@mail.gmail.com>
Message-ID: <CAGb2v67o-=_cL2RWfXJ+3C86zfQ_1b5DYRi3_zwvwy6su6+gdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 3, 2015 at 7:35 AM, Julian Calaby <julian.calaby@gmail.com> wrote:
> Hi Timo,
>
> On Mon, Aug 3, 2015 at 5:23 AM, Timo Sigurdsson
> <public_timo.s@silentcreek.de> wrote:
>> sun7i-a20.dtsi contains an cpufreq operating point at 0.9 volts. Most A20 boards
>> (or all?), however, do not allow the voltage to go below 1.0V. Thus, raise the
>> voltage for the lowest operating point to 1.0V so all boards can actually use
>> it.
>
> Surely it wouldn't be added here if some could supply 0.9v.

On the side, the original OPPs in the FEX files are actually
frequency/voltage ranges, and not just points. Mainlines OPPv2
will support these, along with turbo frequencies.

Furthermore, the FEX files also have fields that limit the
minimum and maximum frequencies.

> Is the code that uses this smart enough to sensibly switch between two
> operating points with the same frequency and different voltages? If
> so, maybe just add a 144MHz @ 1.0v operating point?

You could try. Though I really don't see much to gain here.

> (Alternatively, would it make sense to modify the code that uses this
> to use frequencies with voltages specified that are lower than can be
> supplied with the lowest voltage it can?)

I think that's a bit harder to get accepted.


ChenYu
