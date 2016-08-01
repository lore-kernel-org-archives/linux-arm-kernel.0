From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 1 Aug 2016 20:01:49 +0800
Subject: [PATCH 00/13] arm64: Allwinner A64 support based on sunxi-ng
In-Reply-To: <20160801140012.41b8609b69faa1fe1d7d2a4a@free.fr>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
 <fb559224-561c-3476-1146-96f7aea427f0@arm.com>
 <20160801103024.cc74c093466d7fdfd91a2587@free.fr>
 <CAGb2v67+1rG1kj+7cGO=TMwSgpktP4xMAeZ9Zfy8PRWXyRLi+g@mail.gmail.com>
 <20160801140012.41b8609b69faa1fe1d7d2a4a@free.fr>
Message-ID: <CAGb2v66bvtY5qtkSJ_BgyPtA+Mi-3m06NwVnntcwaNnbdwYC6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 1, 2016 at 8:00 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> On Mon, 1 Aug 2016 17:13:34 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
>> > But I don't see why you are keeping the simple-gates. The bus gate may
>> > be ungated/gated when the clock is enabled/disabled, and that's what
>> > Allwinner's software does.
>>
>> For peripherals that have a separate mod clock, having them separate
>> is a good thing. One example might be the audio codecs. You could ungate
>> the bus gate to access its registers to program it, but only enable
>> the mod clock when you actually play something.
>
> The roles of the bus gate and the clock gate are the same. I don't see
> any reason to set one gate without setting the other one. More, the
> spec says what the bus gate must be enabled before the clock gate (and
> reverse order while disabling). So, setting both gates in one function
> call seems safer.

Wha? Aren't bus gates and clock gates the same thing in this context?

ChenYu

> Then, if you want to save some power while not playing anything, just do
> clk_disable() of the (main and only) i2s clock.
>
> --
> Ken ar c'henta? |             ** Breizh ha Linux atav! **
> Jef             |               http://moinejf.free.fr/
